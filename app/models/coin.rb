class Coin < ApplicationRecord
  has_many :transactions
  has_many :users, through: :transactions
  has_many :wallets
  
  validates :name, :symbol, presence: true

  def self.all_coin_fullnames
    Cryptocompare::CoinList.all['Data'].map { |arr| arr[1].dig('FullName') }.sort
  end
  
  def self.all_coin_symbols
    Cryptocompare::CoinList.all['Data'].map { |arr| arr[1].dig('Symbol') }
  end
  
  def self.all_coin_names
    Cryptocompare::CoinList.all['Data'].map { |arr| arr[1].dig('CoinName') }
  end
  
  def name_from_full
    self.name.scan(/\w+(?!\w|\()/)[0]
  end
  
  def sym_from_full
    self.name.scan(/\w+(?!\w|\()/)[1]
  end
  
  def self.most_transactions
    coin_hash = {}
      self.all.each do |coin|
        coin_hash[coin.name] = coin.transactions.count
      end
    coin_hash.sort_by{|k, v| v}.reverse
  end
  
end
