class OrdersController < ApplicationController
    def show
        @order = Order.find(params[:id])
      end
    
      def create
        charge = perform_stripe_charge
        order  = create_order(charge)
    
        if order.valid?
          empty_cart!
          redirect_to order, notice: 'Your Order has been placed.'
        else
          redirect_to cart_path, error: order.errors.full_messages.first
        end
    
      rescue Stripe::CardError => e
        redirect_to cart_path, error: e.message
      end
    
      private
    
      def empty_cart!
        update_cart({})
      end
    
      def perform_stripe_charge
        Stripe::Charge.create(
          source:      params[:stripeToken],
          amount:      cart_total,
          description: "Your Order",
          currency:    'inr'
        )
      end
    
      def create_order(stripe_charge)
        order = Order.new(
          email: params[:stripeEmail],
          total_cents: cart_total,
          stripe_charge_id: stripe_charge.id, 
        )
        cart.each do |product_id, details|
          if product = Product.find_by(id: product_id)
            quantity = details['quantity'].to_i
            order.line_items.new(
              product: product,
              quantity: quantity,
              item_price: product.price,
              total_price: product.price * quantity
            )
          end
        end
        order.save!
        UserMailer.confirmation_email(current_user, order).deliver_now
        order
      end
    
      def cart_total
        total = 0
        cart.each do |product_id, details|
          if p = Product.find_by(id: product_id)
            total += p.price * details['quantity'].to_i
          end
        end
        total
      end
end
