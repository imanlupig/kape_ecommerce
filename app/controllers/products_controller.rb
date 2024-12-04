class ProductsController < ApplicationController
  def index
    # Filter by category
    if params[:category_id].present?
      @category = Category.find(params[:category_id])
      @products = @category.products
    else
      @products = Product.all
    end

    # Search for term and will filter products with name or description in results.
    if params[:search].present?
      search_term = "%#{params[:search].downcase}%"
      @products = @products.where("LOWER(name) LIKE ? OR LOWER(description) LIKE ?", search_term, search_term)
    end

    @products = @products.page(params[:page]).per(10)
  end

  def show
    @product = Product.find(params[:id])
  end
end
