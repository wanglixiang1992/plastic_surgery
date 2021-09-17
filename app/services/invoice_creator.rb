# frozen_string_literal: true

class InvoiceCreator
  attr_reader :invoice, :errors

  def initialize
    @errors = []
  end

  def call(invoice_params, line_item_params)
    ActiveRecord::Base.transaction do
      @invoice = Invoice.new(invoice_params)
      @invoice.save!
      line_item = @invoice.line_items.new(line_item_params)
      line_item.save!
      QuickbooksSynchronizer.new.sync_invoice(invoice: @invoice)
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved => e
      add_error(e.message)
      raise ActiveRecord::Rollback
    end
  end

  def success?
    @errors.empty?
  end

  private

  def add_error(message)
    @errors << message
  end
end
