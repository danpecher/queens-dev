class InvoiceItem < ApplicationRecord
  belongs_to :product_variant
  belongs_to :invoice
  validates_presence_of :quantity, :product_variant_id
end