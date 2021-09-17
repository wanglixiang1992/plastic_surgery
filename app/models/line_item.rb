# frozen_string_literal: true

class LineItem < ApplicationRecord
  belongs_to :invoice

  validates :invoice_id, presence: true
  validates :description, presence: true

  def price
    unit_price * quantity
  end
end
