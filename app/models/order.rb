class Order < ApplicationRecord

   belongs_to :user
   has_many :line_items

   validates :stripe_charge_id, presence: true
   
end
