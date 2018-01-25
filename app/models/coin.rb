class Coin < ApplicationRecord
  has_many :transactions
  has_many :users, through: :transactions
  has_many :wallets
end
