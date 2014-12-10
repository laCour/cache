desc "Cron service for handling withdrawals"

task :cron => :environment do
  operator_address = APP_CONFIG['fee_address']

  Transaction.where(['created_at < ?', 30.minutes.ago]).where(captured: true, withdrawn: false).find_each do |transaction|
    merchant_address = transaction.listing.address
    deposit_address = transaction.address

    raw_amount = transaction.amount - APP_CONFIG['network_min_fee']

    merchant_amount = raw_amount * (1 - APP_CONFIG['service_fee'])
    operator_amount = raw_amount * APP_CONFIG['service_fee']

    amount = [merchant_amount, operator_amount]
    from = [deposit_address]
    to = [merchant_address, operator_address]

    transaction.update({withdrawn: true}) if withdraw(amount, from, to)
  end
end

def withdraw(amount, from, to)
  amount = amount.map(&:to_s)
  
  begin
    response = BlockIo.withdraw_from_addresses(amounts: amount.join(','),
      from_addresses: from.join(','), to_addresses: to.join(','))

    if response['status'] == 'success'
      puts "Paid out #{amount} to #{to}."
      return true
    else
      puts "Error paying out: #{response['data']['error_message']}"
    end
  rescue Exception => e
    puts "Could not pay out #{amount} to #{to}: #{e}"
  end

  return false
end