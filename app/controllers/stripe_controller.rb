class StripeController < ApplicationController

  def oauth
    connector = StripeOauth.new( current_designer )
    url, error = connector.oauth_url( redirect_uri: stripe_confirm_url )

    if url.nil?
      flash[:error] = error
      redirect_to root_path
    else
      redirect_to url
    end
  end

  def confirm
    connector = StripeOauth.new( current_designer )
    if params[:code]
      connector.verify!( params[:code] )

    elsif params[:error]
      flash[:error] = "Authorization request denied."
    end

    redirect_to dashboard_designer_path( current_designer ) 
    # TODO: Add flash message saying they can now accept payments
  end
end