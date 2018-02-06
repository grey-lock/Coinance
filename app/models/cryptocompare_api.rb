class CryptocompareApi < ApplicationRecord

  
  def self.price_from_to(crypto, fiat)
    cryptoSym = crypto.upcase
    if cryptoSym && Cryptocompare::CoinSnapshot.find(cryptoSym, fiat)['Response'] == "Success"
      Cryptocompare::CoinSnapshot.find(cryptoSym,"#{fiat.upcase}")['Data'].values[6]['PRICE'].to_f.round(2)
    else
      nil
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
    coinSym.upcase
    CryptocompareApi.price_from_to(coinSym, 'USD')
  end  
  
end