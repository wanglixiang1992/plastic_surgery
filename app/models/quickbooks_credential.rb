# frozen_string_literal: true

class QuickbooksCredential < ApplicationRecord
  validates :realm_id, presence: true
  validates :access_token, presence: true
  validates :refresh_token, presence: true

  scope :active, -> { where(active: true) }
end
