class PagesController < ApplicationController
  def index
  end

  def products
    @products = Product.page(params[:page]).per(10)
  end

  def about
    @page = Page.find_by(title: "About")
  end

  def contact
    @page = Page.find_by(title: "Contact")
  end

  def show
    @product = Product.find(params[:id])
  end
end
