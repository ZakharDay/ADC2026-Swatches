class SubscriptionsController < ApplicationController
  def create
    @subscription = Subscription.new(subscription_params)

    respond_to do |format|
      if @subscription.save
        format.turbo_stream { render :show }
      else
        format.turbo_stream { render :error }
      end
    end
  end

  private

    def subscription_params
      params.expect(subscription: [ :email ])
    end

end
