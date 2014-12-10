module Keyable
  extend ActiveSupport::Concern

  included do
    before_create :generate_key
  end

  protected

  def generate_key
    self.key = SecureRandom.uuid
  end
end