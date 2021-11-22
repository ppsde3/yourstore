class ProductsController < ApplicationController
  def index
    if params[:search_key]
      @products = Product.where("name LIKE ? OR description LIKE ?", 
      "%#{params[:search_key]}%", "%#{params[:search_key.downcase]}%")
    else
      @products = Product.all.order(created_at: :desc)
    end
  
end

def show
  @product = Product.find params[:id]
 # @reviews = Review.where(product_id: params[:id]).order(created_at: :desc)
 # @average = Review.where(product_id: params[:id]).average(:rating)
end
end
