module Tokenable
  extend ActiveSupport::Concern

  included do
    before_create :generate_token
  end

  protected

  def generate_token
    self.token = loop do
      random_token = rand(36**APP_CONFIG['token_length']).to_s(36)
      break random_token unless self.class.exists?(token: random_token)
    end
  end
end