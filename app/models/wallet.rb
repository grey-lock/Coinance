class Wallet < ApplicationRecord
  belongs_to :user
  belongs_to :coin
  has_many :transactions, through: users
end
