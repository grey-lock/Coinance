class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :amount, :quantity, :price_per_coin, :fee, :wallet_id, :coin_id, :created_at, :updated_at
  has_many :comments
end
