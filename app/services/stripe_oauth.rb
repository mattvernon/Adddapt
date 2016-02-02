class StripeOauth < Struct.new( :designer )

  def oauth_url( params )
    url = client.authorize_url( {
      scope: 'read_write',
      stripe_landing: 'register',
      stripe_user: {
        email: designer.email
      }
    }.merge( params ) )

    begin
      response = RestClient.get url
      # If the request was successful, then we're all good to return
      # this URL.

    rescue 
      nil # TODO: improve
    end

    [ url, nil ]
  end

  def verify!( code )
    data = client.get_token( code, {
      headers: {
        'Authorization' => "Bearer #{Rails.application.secrets.stripe_secret_key}"
      }
    } )

    designer.designer_uid = data.params['stripe_user_id']
    designer.stripe_account_type = 'oauth'
    designer.publishable_key = data.params['stripe_publishable_key']
    designer.access_code = data.token

    designer.save!
  end

  private

  def client
    @client ||= OAuth2::Client.new(
      ENV["STRIPE_CONNECT_CLIENT_ID"],
      ENV["STRIPE_API_KEY"],
      {
        site: 'https://connect.stripe.com',
        authorize_url: '/oauth/authorize',
        token_url: '/oauth/token'
      }
    ).auth_code
  end
end