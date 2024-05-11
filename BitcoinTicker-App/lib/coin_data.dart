import 'package:flutter/cupertino.dart';
import 'config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String coinApiKey = ApiKey().getCoinApi();

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

class CoinData {
  late String crypto;
  late String currency;

  Future getCoinData(String crypto, String currency) async {
    var url = Uri.https('rest.coinapi.io', 'v1/exchangerate/$crypto/$currency',
        {'apikey': coinApiKey});

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      var lastPrice = decodedData['rate'];
      return lastPrice;
    } else {
      print(response.statusCode);
      throw 'Problem with the get request';
    }
  }
}
