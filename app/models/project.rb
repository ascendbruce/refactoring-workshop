class Project < ActiveRecord::Base

  scope :featured, -> { where(is_featured: true) }

  belongs_to :user

end
