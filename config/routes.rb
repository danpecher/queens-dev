Rails.application.routes.draw do
  root 'products#index'

  resources :products, :invoices
  delete '/product_variant/:id', to: 'products#destroy_variant', as: :delete_product_variant
  delete '/invoice_item/:id', to: 'invoices#destroy_item', as: :delete_invoice_item
end
