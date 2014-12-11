class Listing < ActiveRecord::Base
  include ExpireableListing
  include Tokenable
  include Keyable

  has_many :transactions

  has_one :cover_photo

  has_attached_file :document, :s3_permissions => { :original => :private }

  validates :document, :presence => { :message => " or file must be included in a listing" }
  validates_attachment :document, :size => { :in => 0..APP_CONFIG['max_document_size'].megabytes }
  do_not_validate_attachment_file_type :document

  validates :title, :address, :amount, :presence => true
  validates :title, length: { in: 5..80 }
  validates :amount, numericality: { greater_than: APP_CONFIG['minimum_amount'] }
  validates :description, length: { maximum: 2000 }

  attr_accessor :cover_photo_token

  after_save :attach_correct_cover_photo, :if => :cover_photo_token


private
  def attach_correct_cover_photo
    cover_photo = CoverPhoto.find(self.cover_photo_token)
    if cover_photo.present?
      cover_photo.listing_id = self.id
      cover_photo.save!
    end
  end
end
