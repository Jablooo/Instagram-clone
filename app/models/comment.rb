class Comment < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :photo, optional: true

end
