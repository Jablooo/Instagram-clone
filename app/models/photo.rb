class Photo < ApplicationRecord
  belongs_to :user
  has_many :comments
  include ImageUploader::Attachment.new(:image) # adds an `image` virtual attribute
end
