class Listing < ActiveRecord::Base
  include ExpireableListing
  include Tokenable
  include Keyable

  has_many :transactions

  has_attached_file :document, :s3_permissions => { :original => :private }
  has_attached_file :cover, :styles => { :original => '720x320>', :preview => '320x220#' }, :convert_options => { :all => '-quality 80' }, :processors => [:thumbnail, :compression]

  validates :title, allow_nil: true, length: { in: 5..80 }
  validates :description, allow_nil: true, length: { maximum: 2000 }
  validates :amount, allow_nil: true, numericality: { greater_than: APP_CONFIG['minimum_amount'] }
  validates :address, allow_nil: true, allow_blank: true, address: true

  validates_attachment :document, :size => { :in => 0..APP_CONFIG['max_document_size'].megabytes }
  validates_attachment :cover, :size => { :in => 0..APP_CONFIG['max_cover_size'].megabytes }, :content_type => { :content_type => /\Aimage\/.*\Z/ }

  def complete?
    requirements = [self.title, self.address, self.amount, self.document]
    requirements.all? { |r| r.present? }
  end

  def incomplete?
    !self.complete?
  end
end
