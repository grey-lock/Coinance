class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :coin
  has_many :notes
  # belongs_to :wallet, optional: true
  
  validates :amount, :quantity, :price_per_coin, format: { with: /\A\d{1,6}(.\d{0,4})?\z/  }, numericality: { greater_than_or_equal_to: 0.0000 }
  validates :fee, format: { with: /\A\d{1,6}(.\d{0,4})?\z/  }, numericality: { greater_than_or_equal_to: 0.0000 }
  
  def note_attributes=(note_attributes)
    note_attributes.values.each do |comment|
      if !comment.empty? 
        self.notes.build(comment: comment, tx: self)
      end
    end
  end
  
  def wallets_attributes=(wallets_attributes)
    wallets_attributes.values.each do |wall_attr|
      self.wallets.build(wall_attr)
    end
  end
  
  def transaction_params=(transaction_params)
    @transaction_params = transaction_params
  end
  
end
