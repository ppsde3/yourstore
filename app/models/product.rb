class Product < ApplicationRecord

  belongs_to :category
  has_one_attached :image
    
  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validates :category, presence: true
  
end
