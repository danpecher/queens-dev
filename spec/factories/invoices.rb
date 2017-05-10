FactoryGirl.define do
  factory :invoice do
    sequence :number do |n|
      "#{Time.now.year}-#{n}"
    end

    factory :invoice_with_items do
      transient do
        items_count 2
      end

      after(:create) do |invoice, evaluator|
        create_list(:invoice_item, evaluator.items_count, invoice: invoice)
      end
    end
  end
end
