# frozen_string_literal: true

class Customer < ApplicationRecord
  has_many :invoices, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
