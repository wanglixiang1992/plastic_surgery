# frozen_string_literal: true

class QuickbooksSyncService
  def initialize; end

  def sync_invoice(invoice:)
    qbo_invoice                      = Quickbooks::Model::Invoice.new
    qbo_invoice.line_items           = get_line_items(items: invoice.line_items)
    qbo_invoice.due_date             = invoice.due_date
    qbo_invoice.txn_date             = invoice.invoice_date
    qbo_invoice.customer_id          = invoice.customer_id
    qbo_invoice.doc_number           = invoice.invoice_number

    invoice_service              = Quickbooks::Service::Invoice.new
    invoice_service.access_token = access_token
    invoice_service.company_id   = realm_id
    qbo_invoice = invoice_service.create(qbo_invoice)
    invoice.update!(qbo_id: qbo_invoice.id)
  end

  def sync_customer(customer:)
    service               = Quickbooks::Service::Customer.new
    service.company_id    = realm_id
    service.access_token  = access_token

    qbo_customer = service.find_by(family_name: customer.name)
    if qbo_customer.blank?
      qbo_customer = Quickbooks::Model::Customer.new
      qbo_customer.family_name = customer.name
      qbo_customer = service.create(qbo_customer)
    end
    customer.update!(qbo_id: qbo_customer.id)
  end

  private

  def access_token
    quickbooks_credential.access_token
  end

  def realm_id
    quickbooks_credential.realm_id
  end

  def quickbooks_credential
    QuickbooksCredential.active.first
  end

  def get_line_items(items:)
    line_items = []
    items.each { |item| line_items << create_line_item(item: item) }
    line_items
  end

  def create_line_item(item:)
    line_item = Quickbooks::Model::InvoiceLineItem.new({
                                                         amount: item.price,
                                                         description: item.description
                                                       })

    line_item.sales_item! do |detail|
      detail.unit_price    = item.unit_price
      detail.quantity      = item.quantity
    end
    line_item
  end
end
