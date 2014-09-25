class User < ActiveRecord::Base
  has_secure_password

  has_many :projects
  has_one  :profile
  accepts_nested_attributes_for :profile

  validates_presence_of :email
  validates_format_of   :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  def profile_nickname
    profile.nil? ? "Your name" : profile.nickname
  end

  def active_projects
    projects.where("updated_at > ?", 3.months.ago)
  end

  # FIXME: 4. Service Object
  def subscribe
    subscribe_service.subscribe
  end

  def unsubscribe
    subscribe_service.unsubscribe
  end

  private

  def subscribe_service
    @subscribe_service ||= SubscribeService.new(self)
  end

end
