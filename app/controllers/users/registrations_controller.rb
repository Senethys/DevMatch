class Users::RegistrationsController < Devise::RegistrationsController
  # Extend default devise gem behaviour so that
  # users signing up with pro account (plan ID 2)
  # save with a special Stripe subscription def.
  # Otherwise Devise signis up sers as usual.
  def create
    super do |resource|
      if params[:plan]
        resource.plan_id = params[:plan]
        if resource.plan_id == 2
          resource.save_with_subscription
        else
          resource.save
        end
      end
    end
  end
end