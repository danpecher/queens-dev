FactoryGirl.define do
  factory :product_variant do
    sequence :code do |n|
      n
    end
  end
end
