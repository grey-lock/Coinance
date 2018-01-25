class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :coin
  belongs_to :wallet
  
  validates :amount, :quantity, :price_per_coin, :fee, numericality: { greater_than: 0 }
  
end
