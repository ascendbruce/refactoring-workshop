require 'rails_helper'

RSpec.describe User, :type => :model do
  describe "subscribe" do
    let(:user) { User.new }

    it "sets subscription_plan" do
      allow(PaymentGateway).to receive(:subscribe) { :success }
      expect(user.subscribe).to eq :success
      expect(user.subscription_plan).to eq "monthly"
    end

    it "does not set subscription_plan" do
      allow(PaymentGateway).to receive(:subscribe) { :fail }
      expect(user.subscribe).to eq :fail
      expect(user.subscription_plan).to eq nil
    end

    it "does not set subscription_plan if error" do
      allow(PaymentGateway).to receive(:subscribe).and_raise(SystemCallError, "Network Error")
      expect(user.subscribe).to eq :network_error
      expect(user.subscription_plan).to eq nil
    end
  end

  describe "unsubscribe" do
    let(:user) { User.new(subscription_plan: "monthly") }

    it "sets subscription_plan" do
      allow(PaymentGateway).to receive(:unsubscribe) { :success }
      expect(user.unsubscribe).to eq :success
      expect(user.subscription_plan).to eq nil
    end

    it "does not set subscription_plan" do
      allow(PaymentGateway).to receive(:unsubscribe) { :fail }
      expect(user.unsubscribe).to eq :fail
      expect(user.subscription_plan).to eq "monthly"
    end

    it "does not set subscription_plan if error" do
      allow(PaymentGateway).to receive(:unsubscribe).and_raise(SystemCallError, "Network Error")
      expect(user.unsubscribe).to eq :network_error
      expect(user.subscription_plan).to eq "monthly"
    end
  end
end
