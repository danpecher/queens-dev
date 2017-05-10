FactoryGirl.define do
  factory :invoice_item do
    quantity 1
    product_variant {create(:product_with_variants).product_variants.first}
  end
end
