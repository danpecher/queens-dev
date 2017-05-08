class InvoiceItem < ApplicationRecord
  belongs_to :product_variant
  validates_presence_of :quantity
end