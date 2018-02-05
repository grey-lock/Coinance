class Coin < ApplicationRecord
  has_many :transactions
  has_many :users, through: :transactions
  has_many :wallets
  
  validates :name, :symbol, presence: true, uniqueness: true

  def self.all_coin_fullnames
    Cryptocompare::CoinList.all['Data'].map { |arr|  arr[1].dig('FullName') }.sort
  end
  
  def self.all_coin_symbols
    Cryptocompare::CoinList.all['Data'].map { |arr| arr[1].dig('Symbol') }
  end
  
  def self.all_coin_names
    Cryptocompare::CoinList.all['Data'].map { |arr| arr[1].dig('CoinName') }
  end
  
  def symbol=(coin)
    Cryptocompare::CoinList.all['Data']["#{coin}"]['Symbol']
  end
  
  def id=(coin)
     Cryptocompare::CoinList.all['Data']["#{coin}"]['Id']
  end
  
  def last_known_value=(coin)
    # Check if the coin exists
    coinSym = Coin.all_coin_names.select { |c| c == coin }
    # Send the found coin symbol to the method for price conversion
    if coinSym
      self.last_known_value = CryptocompareApi.price_from_to(self.symbol, 'USD')
    end
  end  
  
  
end
