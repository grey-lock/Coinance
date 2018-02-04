class Wallet < ApplicationRecord
  belongs_to :user
  belongs_to :coin, optional: true
  
  # Removing this association for now due to complexity of models
  # has_many :transactions
  
  def wallet_params=(wallet_params)
    @wallet_params = wallet_params
  end
  
  
end
