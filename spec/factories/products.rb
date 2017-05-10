FactoryGirl.define do
  factory :product do
    sequence :name do |n|
      "Produkt #{n}"
    end

    factory :product_with_variants do
      transient do
        variants_count 5
      end

      after(:create) do |product, evaluator|
        create_list(:product_variant, evaluator.variants_count, product: product)
      end
    end
  end
end
