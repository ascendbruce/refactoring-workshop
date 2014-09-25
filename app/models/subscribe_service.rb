class SubscribeService
  def initialize(user)
    @user = user
  end

  def subscribe
    api_result = try_api { PaymentGateway.subscribe }
    if api_result == :success
      @user.update_attributes(subscription_plan: "monthly")
    end
    api_result
  end

  def unsubscribe
    api_result = try_api { PaymentGateway.unsubscribe }
    if api_result == :success
      @user.update_attributes(subscription_plan: nil)
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
