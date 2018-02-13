class Note < ApplicationRecord
  belongs_to :tx, class_name: 'Transaction', foreign_key: 'transaction_id'
  
end
