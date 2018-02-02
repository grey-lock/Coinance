class Wallet < ApplicationRecord
  belongs_to :user
  belongs_to :coin
  
  # Removing this association for now due to complexity of models
  # has_many :transactions
  
  
end
