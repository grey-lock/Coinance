class Coin < ApplicationRecord
  has_many :transactions
  has_many :users, through: :transactions
  has_many :wallets
  
  validates :name, :symbol, presence: true

  def self.all_coin_fullnames
    Cryptocompare::CoinList.all['Data'].map { |arr|  arr[1].dig('FullName') }.sort
  end
  
  def self.all_coin_symbols
    Cryptocompare::CoinList.all['Data'].map { |arr| arr[1].dig('Symbol') }
  end
  
  def self.all_coin_names
    Cryptocompare::CoinList.all['Data'].map { |arr| arr[1].dig('CoinName') }
  end
  
  
end
