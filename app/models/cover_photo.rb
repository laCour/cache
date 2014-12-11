class CoverPhoto < ActiveRecord::Base
  belongs_to :listing

  has_attached_file :image, :styles => { :original => '720x320>', :preview => '320x220#' }, :convert_options => { :all => '-quality 80' }, :processors => [:thumbnail, :compression]
  validates_attachment :image, :size => { :in => 0..APP_CONFIG['max_cover_size'].megabytes }, :content_type => { :content_type => /\Aimage\/.*\Z/ }
end
