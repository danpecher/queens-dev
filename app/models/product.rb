class Product < ApplicationRecord
  validates_presence_of :name

  has_many :product_variants, dependent: :destroy
  accepts_nested_attributes_for :product_variants, allow_destroy: true
end