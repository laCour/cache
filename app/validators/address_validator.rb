class AddressValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || 'is not a valid address') unless value =~ APP_CONFIG['address_regex']
  end
end
