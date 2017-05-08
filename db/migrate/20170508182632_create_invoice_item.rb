class CreateInvoiceItem < ActiveRecord::Migration[5.1]
  def change
    create_table :invoice_items do |t|
      t.references :invoice, foreign_key: true
      t.references :product_variant, foreign_key: true
      t.integer :quantity
    end
  end
end
