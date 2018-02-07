class CryptocompareApi < ApplicationRecord

  
  def self.price_from_to(crypto)
    if crypto && Cryptocompare::CoinSnapshot.find(crypto, 'USD')['Response'] == "Success"
      Cryptocompare::CoinSnapshot.find(crypto,"USD")['Data']['AggregatedData']['PRICE'].to_f.round(4)
    else
      return 0.0
    end
  end
  
  def self.list_all_coin_symbols
    Cryptocompare::CoinList.all['Data'].keys
  end
  
  def self.symbol(coinSym)
    Cryptocompare::CoinList.all['Data']["#{coin.upcase}"]['Symbol']
  end
  
  def self.find_coin_id(coinSym)
    coin.downcase
    Cryptocompare::CoinList.all['Data']["#{coin.upcase}"]['Id']
  end
  
  def self.last_known_value(coinSym)
    # Send the found coin symbol to the method for price conversion
    # coinSym.upcase
    CryptocompareApi.price_from_to(coinSym)
  end  
  
end