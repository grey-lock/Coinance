class Wallet < ApplicationRecord
  belongs_to :user
  belongs_to :coin
  has_many :transactions
  
  validates :name, presence: true
  validates :coin_amount, :user_deposit, format: { with: /\A\d{1,6}(.\d{0,4})?\z/  }, numericality: { greater_than_or_equal_to: 0.0000 }
  
  def wallet_params=(wallet_params)
    @wallet_params = wallet_params
  end
  
  def transactions_attributes=(transactions_attributes)
    transactions_attributes.values.each do |tx|
      self.transactions.build(tx)
    end
    self.wallet_id = Wallet.find_by(id: wallet_attributes[:id])
  end
  
end
