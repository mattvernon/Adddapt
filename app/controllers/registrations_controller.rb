class RegistrationsController < Devise::RegistrationsController
  protected

  # Redirect to first step in after_signup_controller using Wicked Forms
  def after_sign_up_path_for(resource)
    after_signup_path(:personal)
  end

end