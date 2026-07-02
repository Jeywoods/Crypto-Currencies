import 'dart:developer';

import 'package:dio/dio.dart';
import 'models/crypto_coin_model.dart';

class CryptoCoinsRepository {
  Future<List<CryptoCoin>> getCoinsList() async {
    try {
      final response = await Dio().get(
        'https://api.coingecko.com/api/v3/coins/markets',
        queryParameters: {
          'vs_currency': 'usd',
          'order': 'market_cap_desc',
          'per_page': 20,
          'page': 1,
          'sparkline': false,
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to load coins');
      }

      final List<dynamic> data = response.data;

      final dataList = data.map((coin) => CryptoCoin(
        id: coin['id'] ?? '',
        name: coin['name'] ?? 'Unknown',
        symbol: coin['symbol']?.toUpperCase() ?? '',
        imageUrl: coin['image'] ?? '',
        price: (coin['current_price'] as num?)?.toDouble() ?? 0.0,
        priceChange: (coin['price_change_percentage_24h'] as num?)?.toDouble() ?? 0.0,
      )).toList();

      return dataList;

    } catch (e) {
      log('Error: $e');
      return [];
    }
  }
}