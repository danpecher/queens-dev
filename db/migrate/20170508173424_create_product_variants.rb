class CreateProductVariants < ActiveRecord::Migration[5.1]
  def change
    create_table :product_variants do |t|
      t.string :code
      t.references :product, foreign_key: true
    end
  end
end
