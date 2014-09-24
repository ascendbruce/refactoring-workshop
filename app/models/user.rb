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
    api_result = try_api { PaymentGateway.subscribe }
    if api_result == :success
      update_attributes(subscription_plan: "monthly")
    end
    api_result
  end

  def unsubscribe
    api_result = try_api { PaymentGateway.unsubscribe }
    if api_result == :success
      update_attributes(subscription_plan: nil)
    end
    api_result
  end

  private

  def try_api
    yield
  rescue => e
    Rails.logger.error "API call failed. message: #{e.message}"
    return :network_error
  end
end
