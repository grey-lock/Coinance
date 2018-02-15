class Wallet < ApplicationRecord
  belongs_to :user
  belongs_to :coin
  has_many :transactions
  
  delegate :coins, to: :transactions
  
  validates_associated :transactions, :message => "Transaction being added is invalid."
  validates :name, presence: true, uniqueness: true
  validates :coin_amount, :user_deposit, format: { with: /\A\d{1,6}(.\d{0,4})?\z/  }, numericality: { greater_than_or_equal_to: 0.0000 }
  
  def wallet_params=(wallet_params)
    @wallet_params = wallet_params
  end
  
  # I need to assign the coin that was chosen to the wallet, 
  # the same coin attributes to the transaction
  # And the transaction to the wallet
  
  def transactions_attributes=(transactions_attributes)
    transactions_attributes.values.each do |tx_attr|
      binding.pry
      if tx_attr[:id].nil?
        transaction = Transaction.new(tx_attr)
        transaction.user_id = self.user_id
        # transaction.wallet_id = self.id
        if transaction.valid?
          # transaction.save
          self.transactions << transaction
        end
      else
        transaction = Transaction.find_by(id: transaction.id)
        if transaction.valid? && self.valid?
          # transaction.save
          self.transactions << transaction
        end
      end
    end
  end 
  
  
end
