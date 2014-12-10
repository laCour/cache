module ExpireableTransaction
  extend ActiveSupport::Concern

  included do
    before_create :delete_expired_transactions
  end

  protected

  def delete_expired_transactions
    self.class.delete_all(["created_at < ? AND created_at IS updated_at", 15.minutes.ago])
  end
end