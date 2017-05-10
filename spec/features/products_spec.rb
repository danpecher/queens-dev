require 'rails_helper'

RSpec.feature "Products", type: :feature do
  scenario 'list products without any records' do
    visit products_path
    expect(page).to have_text('Žádné produkty')
  end

  scenario 'list products with records' do
    products = create_list(:product, 10)
    visit products_path
    expect(page).to have_selector('tbody tr', count: 10)
    products.each do |product|
      expect(page).to have_text(product.name)
    end
  end

  scenario 'view product detail' do
    product = create(:product)
    visit product_path(product)
    expect(page).to have_text("Produkt #{product.name}")
  end

  scenario 'create product', js: true do
    visit new_product_path

    expect(page).to have_text('Nový produkt')
    expect(page).to have_text('Kód varianty', count: 1)

    fill_in 'product[name]', with: 'Testovaci produkt'
    fill_in 'product[product_variants_attributes][0][code]', with: 'A'
    click_on 'Přidat variantu'
    expect(page).to have_text('Kód varianty', count: 2)
    fill_in 'product[product_variants_attributes][1][code]', with: 'B'

    expect {
      click_button 'Uložit'
    }.to change(Product, :count).by(1)

    expect(page).to have_text('Testovaci produkt')
  end

  scenario 'edit product' do
    product = create(:product_with_variants)
    visit edit_product_path(product)
    expect(page).to have_text(product.name)

    fill_in 'product[name]', with: 'Updated name'
    fill_in 'product[product_variants_attributes][0][code]', with: '1234'
    click_button 'Uložit'

    expect(page).to have_selector('input[name="product[name]"][value="Updated name"]')
    expect(page).to have_selector('input[name="product[product_variants_attributes][0][code]"][value="1234"]')
  end

  scenario 'remove product variant', js: true do
    product = create(:product_with_variants, variants_count: 2)
    visit edit_product_path(product)
    first('.nested_product_product_variants').click_on 'Smazat'
    expect {
      click_button 'Uložit'
    }.to change(ProductVariant, :count).by(-1)
  end

  scenario 'delete product' do
    create_list(:product, 2)
    visit products_path
    expect {
      page.find('tbody tr:eq(2) a[data-method="delete"]').click
    }.to change(Product, :count).by(-1)
    expect(page).to have_selector('tbody tr', count: 1)
  end

end
