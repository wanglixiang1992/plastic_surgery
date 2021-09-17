# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QuickbooksSynchronizer, type: :service do
  before do
    stub_request(:post, 'https://oauth.platform.intuit.com/oauth2/v1/tokens/bearer').to_return(status: 200, body: '{"expires_in": 3000, "refresh_token": "RefreshToken", "access_token": "AccessToken", "x_refresh_token_expires_in": 300}', headers: { 'Content-Type' => 'application/json' })
    stub_request(:get, /.*intuit.com.*query/).to_return(
      status: 200, 
      body: qbo_customer_query_response, 
      headers: { 'Content-Type': 'application/xml', 'Accept': 'application/xml' }
    )
    stub_request(:post, /.*intuit.com.*invoice/).to_return(
      status: 200, 
      body: qbo_invoice_response, 
      headers: { 'Content-Type': 'application/xml', 'Accept': 'application/xml' }
    )
  end

  let_it_be(:qbo_credential) { create(:quickbooks_credential) }

  let(:qbo_customer_query_response) { File.read('./spec/data/quickbooks/customer.xml') }
  let(:qbo_invoice_response) { File.read('./spec/data/quickbooks/invoice.xml') }
  
  let_it_be(:customer) { create(:customer, name: 'Lauterbach') }
  let_it_be(:invoice) { create(:invoice, customer: customer) }
  let_it_be(:line_item) { create(:line_item, invoice: invoice) }

  describe '#sync_invoice' do
    before do
      described_class.new.sync_invoice(invoice: invoice)
    end

    it 'synces invoice' do
      expect(invoice.qbo_id).to be_present
    end

    it 'synces customer' do
      expect(invoice.customer.qbo_id).to be_present
    end
  end
end
