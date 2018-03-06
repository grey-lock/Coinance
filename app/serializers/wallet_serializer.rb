class WalletSerializer < ActiveModel::Serializer
  attributes :id, :name, :coin_amount, :user_deposit, :notes, :created_at, :updated_at
  has_many :transactions
  belongs_to :coin
  belongs_to :user
  
end
