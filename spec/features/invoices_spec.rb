require 'rails_helper'

RSpec.feature "Invoices", type: :feature do
  let(:invoices) {create_list(:invoice, 10)}

  scenario 'list invoices without any records' do
    visit invoices_path
    expect(page).to have_text('Žádné doklady')
  end

  scenario 'list invoices with records' do
    invoices = create_list(:invoice, 10)
    visit invoices_path
    expect(page).to have_selector('tbody tr', count: 10)
    invoices.each do |invoice|
      expect(page).to have_text(invoice.number)
    end
  end

  scenario 'view invoice detail' do
    invoice = create(:invoice)
    visit invoice_path(invoice)
    expect(page).to have_text("Doklad ##{invoice.number}")
  end

  scenario 'create invoice' do
    product = create(:product_with_variants)
    visit new_invoice_path
    expect(page).to have_text("Nový doklad")
    fill_in 'invoice[number]', with: '1234'
    variant = product.product_variants.first
    page.find('[name="invoice[invoice_items_attributes][0][product_variant_id]"]').find("option[value=\"#{variant.id}\"]").select_option
    quantity = 2
    fill_in 'invoice[invoice_items_attributes][0][quantity]', with: quantity

    expect{
      click_button 'Uložit'
    }.to change(Invoice, :count).by(1)
    expect(page).to have_text('Doklad #1234')
    expect(page.find('tbody tr:eq(1) td:eq(1)')).to have_text(product.name)
    expect(page.find('tbody tr:eq(1) td:eq(2)')).to have_text(variant.code)
    expect(page.find('tbody tr:eq(1) td:eq(3)')).to have_text(quantity)
  end

  scenario 'edit invoice' do
    invoice = create(:invoice_with_items)
    visit edit_invoice_path(invoice)
    expect(page).to have_text("Upravit doklad ##{invoice.number}")

    fill_in 'invoice[number]', with: '1234'
    click_button 'Uložit'

    expect(page).to have_text("Upravit doklad #1234")
  end

  scenario 'delete invoice' do
    create_list(:invoice, 2)
    visit invoices_path
    expect {
      page.find('tbody tr:eq(2) a[data-method="delete"]').click
    }.to change(Invoice, :count).by(-1)
    expect(page).to have_selector('tbody tr', count: 1)
  end

end
