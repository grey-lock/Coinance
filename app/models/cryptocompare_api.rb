class CryptocompareApi < ApplicationRecord
  
  def self.price_from_to(crypto, fiat)
    Cryptocompare::CoinSnapshot.find("#{crypto.upcase}","#{fiat.upcase}")['Data'].values[6]['PRICE'].to_f.round(2)
  end
  
  def self.list_all_coin_symbols
    Cryptocompare::CoinList.all['Data'].keys
  end
  
  def self.find_name(coin)
    Cryptocompare::CoinList.all['Data']["#{coin}"]['CoinName']
  end
  
  def self.symbol(coin)
    Cryptocompare::CoinList.all['Data']["#{coin}"]['Symbol']
  end
  
  def self.find_coin_id(coin)
    Cryptocompare::CoinList.all['Data']["#{coin}"]['Id']
  end
  
  def self.last_known_value(coin)
    # Find the coin by symbol    
    coinSym = CryptocompareApi.symbol(coin)
    # Send the found coin symbol to the method for price conversion
    if coinSym
      CryptocompareApi.price_from_to(coinSym, 'USD')
    end
  end  
  
end