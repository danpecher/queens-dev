class Invoice < ApplicationRecord
  validates_presence_of :number
  has_many :invoice_items, dependent: :destroy
  accepts_nested_attributes_for :invoice_items, allow_destroy: true
end