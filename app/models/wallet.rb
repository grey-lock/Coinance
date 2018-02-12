class Wallet < ApplicationRecord
  belongs_to :user
  belongs_to :coin
  
  # Removing this association for now due to complexity of models
  # has_many :transactions
  
  validates :name, presence: true
  validates :coin_amount, :user_deposit, format: { with: /\A\d{1,6}(.\d{0,4})?\z/  }, numericality: { greater_than_or_equal_to: 0.0000 }
  
  def wallet_params=(wallet_params)
    @wallet_params = wallet_params
  end
  
  
end
