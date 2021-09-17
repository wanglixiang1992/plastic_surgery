# frozen_string_literal: true

FactoryBot.define do
  factory :quickbooks_credential do
    access_token { SecureRandom.hex }
    access_token_expires_at { Time.zone.now }
    refresh_token { SecureRandom.hex }
    refresh_token_expires_at { Time.zone.now }
    realm_id { SecureRandom.hex }
    active { true }
  end
end
