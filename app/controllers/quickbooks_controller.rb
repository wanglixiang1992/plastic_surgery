# frozen_string_literal: true

class QuickbooksController < ApplicationController
  def authenticate
    redirect_uri = oauth_callback_quickbooks_url
    grant_url = oauth2_client.auth_code.authorize_url(
      redirect_uri: redirect_uri,
      response_type: 'code',
      state: SecureRandom.hex(12), scope: 'com.intuit.quickbooks.accounting'
    )
    redirect_to grant_url
  end

  def disconnect
    quickbooks_credential.update!(active: false)
    redirect_to root_path, notice: I18n.t('quickbooks.disconnected')
  end

  def oauth_callback
    redirect_uri = oauth_callback_quickbooks_url
    response = oauth2_client.auth_code.get_token(params[:code], redirect_uri: redirect_uri)
    quickbooks_credential = QuickbooksCredential.find_or_initialize_by(realm_id: params[:realm_id])
    quickbooks_credential.access_token = response&.token
    quickbooks_credential.access_token_expires_at = Time.zone.now
    quickbooks_credential.refresh_token = response&.refresh_token
    quickbooks_credential.refresh_token_expires_at = Time.zone.now
    quickbooks_credential.active = true
    if quickbooks_credential.save
      redirect_to root_path, notice: I18n.t('quickbooks.connected')
    else
      redirect_to root_path, alert: I18n.t('quickbooks.failed')
    end
  end

  private

  def quickbooks_credential
    @quickbooks_credential ||= QuickbooksCredential.find(params[:id])
  end

  def oauth2_client
    OAuth2::Client.new(ENV['OAUTH_CLIENT_ID'], ENV['OAUTH_CLIENT_SECRET'], oauth_params)
  end

  def oauth_params
    {
      site: 'https://appcenter.intuit.com/connect/oauth2',
      authorize_url: 'https://appcenter.intuit.com/connect/oauth2',
      token_url: 'https://oauth.platform.intuit.com/oauth2/v1/tokens/bearer'
    }
  end
end
