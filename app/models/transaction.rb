class Transaction < ApplicationRecord
  has_many :comments
  belongs_to :user
  belongs_to :coin, optional: true
  belongs_to :wallet, optional: true
  
  validates :amount, :quantity, :price_per_coin, format: { with: /\A\d{1,6}(.\d{0,4})?\z/  }, numericality: { greater_than_or_equal_to: 0.0000 }
  validates :fee, format: { with: /\A\d{1,6}(.\d{0,4})?\z/ }, numericality: { greater_than_or_equal_to: 0.0000 }
  
  # def wallets_attributes=(wallets_attributes)
  #   wallets_attributes.values.each do |wall_attr|
  #     self.wallets.build(wall_attr)
  #   end
  #   # self.build_wallet(wallet_attributes)
  #   # self.wallet_id = Wallet.find(id: wallet_attributes[:id])
  # end
  
  def transactions_params=(transactions_params)
    @transactions_params = transactions_params
  end
  
end
