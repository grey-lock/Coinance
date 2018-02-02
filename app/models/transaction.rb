class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :coin, optional: true
  belongs_to :wallet, optional: true
  
  validates :amount, :quantity, :price_per_coin, :fee, numericality: { greater_than: 0 }
  
end
