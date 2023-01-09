import 'package:http_requests/http_requests.dart';
import 'dart:convert';

//TODO: Add your imports here.

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const apiKey = 'YOUR-API-KEY-HERE';

class CoinData {
  Future<String> getCoinData(selectedCurrency, selectedCoin) async {
    String returnString = "0";
    try {
      Response response = await HttpRequests.get(
          'https://rest.coinapi.io/v1/exchangerate/$selectedCoin/$selectedCurrency?apikey=50BC638A-147E-4319-8307-B32861003F7E');

      if (response.statusCode == 200) {
        print(response.content);
        var responseBody = response.content;
        dynamic responsePrice = jsonDecode(responseBody)['rate'];
        print(responsePrice);
        return responsePrice.toString();
        returnString = responseBody.toString();
      } else {
        return "0";
      }
    } catch (e) {
      print(e);
    }
    return returnString;
  }

  //TODO: Create your getCoinData() method here.
}
