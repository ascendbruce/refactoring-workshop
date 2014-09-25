class Project < ActiveRecord::Base

  scope :featured, -> { where(is_featured: true) }

  belongs_to :user

  def update_label
    if is_featured?
      if created_at > 1.week.ago
        self.label = "new featured"
      else
        self.label = "featured"
      end
    else
      self.label = "normal"
    end
    save
  end

end
