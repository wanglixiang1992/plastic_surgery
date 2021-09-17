# frozen_string_literal: true

FactoryBot.define do
  factory :invoice do
    association :customer

    invoice_date { Time.zone.today }
    amount { Faker::Number.number }
  end
end
