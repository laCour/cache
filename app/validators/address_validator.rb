require 'digest/sha2'

class AddressValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    network, address = APP_CONFIG['network'], value

    record.errors[attribute] << (options[:message] || 'is not a valid address') unless valid_address? network, address
  end

  private

  def valid_address?(network, address)
    networks = { 'btc' => ['00', '05'], 'btctest' => ['6F', 'C4'], 'ltc' => ['30', '05'], 'ltctest' => ['6F', 'C4'], 'doge' => ['1E', '16'], 'dogetest' => ['71', 'C4'] }

    binary_address = base58_decode address
    return false unless binary_address and binary_address.bytesize == 50
    valid_checksum?(binary_address) && networks[network].include?(binary_address[0...2].upcase)
  end

  def base58_decode(address)
    base58_alphabet = '123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz'

    decoded_address = 0

    address.reverse.each_char.with_index do |char, index|
      raise 'Value not a valid address.' unless char_index = base58_alphabet.index(char)
      decoded_address += char_index * (base58_alphabet.size ** index)
    end

    binary_address = decoded_address.to_s(16)
    binary_address = '0' + binary_address if binary_address.bytesize.odd?
    binary_address = '' if binary_address == '00'
    leading_zero_bytes = (address.match(/^([1]+)/) ? $1 : '').size
    binary_address = ('00' * leading_zero_bytes) + binary_address if leading_zero_bytes > 0

    binary_address
  end

  def valid_checksum?(binary_address)
    checksum(binary_address[0...42]) == binary_address[-8..-1]
  end

  def checksum(binary_address)
    Digest::SHA256.hexdigest(Digest::SHA256.digest([binary_address].pack('H*')))[0...8]
  end
end
