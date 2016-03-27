# require 'carrierwave/orm/activerecord'
# require 'file_size_validator'

class Micropost < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  mount_uploader :img, MicropostUploader
end
