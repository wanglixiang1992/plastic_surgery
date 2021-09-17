# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QuickbooksCredential, type: :model do
  describe 'Table structure' do
    it { is_expected.to have_db_column(:access_token).of_type(:text) }
    it { is_expected.to have_db_column(:access_token_expires_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:refresh_token).of_type(:text) }
    it { is_expected.to have_db_column(:refresh_token_expires_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:realm_id).of_type(:text) }
    it { is_expected.to have_db_column(:active).of_type(:boolean) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:access_token) }
    it { is_expected.to validate_presence_of(:refresh_token) }
    it { is_expected.to validate_presence_of(:realm_id) }
  end
end
