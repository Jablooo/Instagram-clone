class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  # allows you to call current_user.profile otherwise it can't find that method.
  # remember to do reciprical one in profile.rb too!!!!
  has_one :profile
  has_many :photos


  # The people who follow us
  has_and_belongs_to_many :followers, class_name: 'User', join_table: :followers, foreign_key: :followed_id, association_foreign_key: :follower_id

  # The people we follow
  has_and_belongs_to_many :following, class_name: 'User', join_table: :followers,
  foreign_key: :follower_id, association_foreign_key: :followed_id

  def followed_by?(user)
   followers.exists?(user.id)
  end

  def toggle_followed_by(user)
   # If currently following, we unfollow
    if followers.exists?(user.id)
      followers.destroy(user)
    # If currently not following, we follow
    else
      followers << user
    end
  end

  def photo_feed
    Photo.where(user: self.following).order(created_at: :desc)
  end
end
