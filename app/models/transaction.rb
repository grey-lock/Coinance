class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :coin
  
  # Removing this association until app is more complete
  # belongs_to :wallet, optional: true
  
  validates :amount, :quantity, :price_per_coin, format: { with: /\A\d{1,4}(.\d{0,2})?\z/  }, numericality: { greater_than_or_equal_to: 0.00001 }
  validates :fee, format: { with: /\A\d{1,4}(.\d{0,2})?\z/  }, numericality: { greater_than_or_equal_to: 0.00001 }
  
  def transaction_params=(transaction_params)
    @transaction_params = transaction_params
  end
  
end
