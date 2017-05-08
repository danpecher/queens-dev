class Product < ApplicationRecord
  validates_presence_of :name

  has_many :product_variants
end