# frozen_string_literal: true

FactoryBot.define do
  factory :line_item do
    association :invoice

    description { "Item-#{SecureRandom.hex}" }
  end
end
