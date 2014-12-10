class Transaction < ActiveRecord::Base
  include ExpireableTransaction

  belongs_to :listing

  def new_address
    begin
      response = BlockIo.get_new_address
      address = response['data']['address']
      label = response['data']['label']
    rescue Exception
      raise('Unable to create payment address')
    end

    return {address: address, label: label}
  end

  def captured?
    begin
      response = BlockIo.get_address_balance label: self.label
      balance = response['data']['available_balance'].to_f
      pending_balance = response['data']['pending_received_balance'].to_f
      balance += pending_balance
    rescue Exception
      raise('Unable to check address balance')
    end

    if balance >= self.amount
      sales = self.listing.sales + 1
      self.listing.update({sales: sales})
      self.update({captured: true})
      true
    else
      false
    end
  end
end
