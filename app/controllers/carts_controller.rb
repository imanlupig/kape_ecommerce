class CartsController < ApplicationController
  def create
    @current_cart.cart_items.create(product_id: params[:product_id])
  end

  def update
    if @cart_item.update(quantity: params[:quantity])
      redirect_to cart_path, notice: "Quantity updated successfully."
    else
      redirect_to cart_path, alert: "Failed to update quantity."
    end
  end

  def remove
    @cart_item.destroy
    redirect_to cart_path, notice: "Item removed from cart."
  end

  def show
  end

  def checkout
  end

  def stripe_session
    session = Stripe::Checkout::Session.create({
      ui_mode: "embedded",
      line_items: [ {
        # Provide the exact Price ID (e.g. pr_1234) of the product you want to sell
        price_data: {
          currency: "cad",
          unit_amount: (@current_cart.products.sum(&:price) * 100).to_i,
          product_data: {
            name: @current_cart.products.map(&:name).join(", ")
          }
        },
        quantity: 1
      } ],
      mode: "payment",
      return_url: success_cart_url(@current_cart.secret_id)
    })

    render json: { clientSecret: session.client_secret }
  end

  def success
    if @current_cart.cart_items.any?
      session[:current_cart_id] = nil
    end
    @purchased_cart = Cart.find_by_secret_id(params[:id])
  end
end