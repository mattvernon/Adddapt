class AfterSignupController < ApplicationController
  include Wicked::Wizard
  steps :personal, :profile_image, :social

  def show
    @designer = current_designer
    render_wizard
  end

  def update
    @designer = current_designer
    @designer.update(designer_params)
    render_wizard @designer
  end

  private

  def designer_params
    params.require(:designer).permit(:first_name, 
                                     :last_name, 
                                     :email, 
                                     :location, 
                                     :bio, 
                                     :website_url, 
                                     :facebook_url, 
                                     :dribbble_url, 
                                     :profile_pic, 
                                     :uid, 
                                     :provider, 
                                     :access_code, 
                                     :publishable_key)
  end
end
