module ExpireableListing
  extend ActiveSupport::Concern

  included do
    before_create :delete_expired_listings
  end

  protected

  def delete_expired_listings
    self.class.delete_all(["created_at < ? AND (address IS NULL OR amount IS NULL OR title IS NULL)", 1.hour.ago])
  end
end