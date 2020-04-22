class ChargesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_product
  
  def create
    stripe_card_id =
      if params[:credit_card].present?
        CreditCardService.new(current_user.id, card_params).create_credit_card
      else
        charge_params[:card_id]
      end
  
    stripe = Stripe::Charge.create(
      customer: current_user.customer_id,
      source:   stripe_card_id,
      amount:   @product.price_in_cents,
      currency: 'usd'
    )
    if params[:credit_card].present? && stripe_card_id
      current_user.credit_cards.create_with(card_params).find_or_create_by(stripe_id: stripe_card_id)
    end
    if stripe.status.eql?('succeeded')
      flash[:notice] = 'Payment received. Order Successfully accepted'
    else
      flash[:error] = 'Payment not accepted. please try again'
    end
    redirect_to root_path
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to @product
  end
  
  private
  
  def card_params
    params.require(:credit_card).permit(:digits, :month, :year, :cvc)
  end
  
  def charge_params
    params.require(:charge).permit(:card_id)
  end
  
  def find_product
    @product = Product.find(params[:product_id])
    rescue ActiveRecord::RecordNotFound => e
      flash[:error] = 'Product not found!'
      redirect_to root_path
  end
end
