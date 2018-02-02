class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :coin, optional: true
  
  # Removing this association until app is more complete
  # belongs_to :wallet, optional: true
  
  validates :amount, :quantity, :price_per_coin, numericality: { greater_than: 0 }
  validates :fee, numericality: { greater_than: 0 }, optional: true
  
end
