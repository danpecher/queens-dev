class ProductsController < ApplicationController
  before_action :find_product, only: [:edit, :show, :update, :destroy]

  def index
    @products = Product.page(params[:page])
  end

  def new
    @product = Product.new
    @product.product_variants.build
  end

  def create
    @product = Product.new(product_params)
    unless @product.valid?
      render :new and return
    end

    @product.save
    redirect_to product_path(@product)
  end

  def update
    @product.assign_attributes(product_params)
    unless @product.valid?
      render :edit and return
    end

    @product.save
    redirect_to edit_product_path(@product)
  end

  def destroy
    @product.destroy

    redirect_to products_path
  end

  private
  def product_params
    params.require(:product).permit(:name, product_variants_attributes: [:id, :code, :_destroy])
  end

  def find_product
    @product = Product.find(params[:id])
  end
end