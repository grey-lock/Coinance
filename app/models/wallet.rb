class Wallet < ApplicationRecord
  belongs_to :user
  belongs_to :coin
  has_many :transactions
  
  validates :name, presence: true
  validates :coin_amount, :user_deposit, format: { with: /\A\d{1,6}(.\d{0,4})?\z/  }, numericality: { greater_than_or_equal_to: 0.0000 }
  
  def wallet_params=(wallet_params)
    @wallet_params = wallet_params
  end
  
  # I need to assign the coin that was chosen to the wallet, 
  # the same coin attributes to the transaction
  # And the transaction to the wallet
  # I get @wallet is invalid
  
  def transactions_attributes=(transactions_attributes)
    transactions_attributes.values.each do |tx_attr|
      transaction = Transaction.find_or_create_by(tx_attr)
      transaction.user_id = self.user_id
      transaction.wallet_id = self.id
      self.transactions << transaction
    end
  end 
  
  
end
