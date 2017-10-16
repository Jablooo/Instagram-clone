class Photo < ApplicationRecord
  include ImageUploader::Attachment.new(:image) # adds an `image` virtual attribute

  belongs_to :user
  has_many :comments
  has_and_belongs_to_many :likers, class_name: 'User', join_table: :likes

  def liked_by?(user)
    likers.exists?(user.id)
  end

  def toggle_liked_by(user)
   # If photo has been liked by `user`
    if likers.exists?(user.id)
      likers.destroy(user.id)
   # If photo has *not* been liked by `user`
    else
      likers << user
    end
  end

end
