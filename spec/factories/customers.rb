# frozen_string_literal: true

FactoryBot.define do
  factory :customer do
    name { "Customer-#{SecureRandom.hex}" }
  end
end
