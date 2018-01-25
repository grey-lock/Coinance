class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :coin
  belongs_to :wallet
end
