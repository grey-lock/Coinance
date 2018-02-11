class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :coin
  
  # Removing this association until app is more complete
  # belongs_to :wallet, optional: true
  
  validates :amount, :quantity, :price_per_coin, format: { with: /\A\d{1,6}(.\d{0,4})?\z/  }, numericality: { greater_than_or_equal_to: 0.0000 }
  validates :fee, format: { with: /\A\d{1,6}(.\d{0,4})?\z/  }, numericality: { greater_than_or_equal_to: 0.0000 }
  
  def transaction_params=(transaction_params)
    @transaction_params = transaction_params
  end
  
end
