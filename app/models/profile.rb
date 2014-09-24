class Profile < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :nickname, :bio
  validates_length_of   :nickname, in: 3..20
end
