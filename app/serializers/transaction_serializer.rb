class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :amount, :quantity, :price_per_coin, :fee, :created_at, :updated_at
  has_many :comments
  belongs_to :coin
  belongs_to :user
  belongs_to :wallet
  
end
