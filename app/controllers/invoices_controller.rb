class InvoicesController < ApplicationController
  before_action :find_invoice, only: [:edit, :show, :update, :destroy]

  def index
    @invoices = Invoice.page(params[:page])
  end

  def new
    @invoice = Invoice.new
    @invoice.invoice_items.build
  end

  def create
    @invoice = Invoice.new(invoice_params)
    unless @invoice.valid?
      render :new and return
    end

    @invoice.save
    redirect_to invoice_path(@invoice)
  end

  def update
    @invoice.assign_attributes(invoice_params)
    unless @invoice.valid?
      render :edit and return
    end

    @invoice.save
    redirect_to edit_invoice_path(@invoice)
  end

  def destroy
    @invoice.destroy

    redirect_to invoices_path
  end

  private
  def invoice_params
    params.require(:invoice).permit(:number, invoice_items_attributes: [:id, :product_variant_id, :quantity, :_destroy])
  end

  def find_invoice
    @invoice = Invoice.find(params[:id])
  end
end