class PagesController < ApplicationController
  def index
  end

  def about
    @page = Page.find_by(title: "About")
  end

  def contact
    @page = Page.find_by(title: "Contact")
  end

  def show
  end
end
