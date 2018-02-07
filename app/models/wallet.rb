class Wallet < ApplicationRecord
  belongs_to :user
  belongs_to :coin
  
  # Removing this association for now due to complexity of models
  # has_many :transactions
  
  validates :name, presence: true
  validates :coin_amount, :user_deposit, format: { with: /\A\d{1,4}(.\d{0,2})?\z/  }, numericality: { greater_than_or_equal_to: 0.00001 }
  
  def wallet_params=(wallet_params)
    @wallet_params = wallet_params
  end
  
  # Fix this once submitted
  def net_value=
    self.coin_amount * self.user_deposit
  end
  
  
end
