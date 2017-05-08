class ProductVariant < ApplicationRecord
  validates_presence_of :code

  belongs_to :product
end