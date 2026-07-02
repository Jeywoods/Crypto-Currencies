import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CryptoCoinScreen extends StatefulWidget {
  const CryptoCoinScreen({super.key}); // ← Убираем coinId из конструктора

  @override
  State<CryptoCoinScreen> createState() => _CryptoCoinScreenState();
}

class _CryptoCoinScreenState extends State<CryptoCoinScreen> {
  String? coinId;
  Map<String, dynamic>? coinData;
  bool isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Получаем coinId из аргументов
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args == null) {
      debugPrint('No arguments provided');
      return;
    }

    if (args is! String) {
      debugPrint('Arguments must be String');
      return;
    }

    coinId = args;
    loadCoinData();
  }

  Future<void> loadCoinData() async {
    if (coinId == null) return;

    try {
      final response = await Dio().get(
          'https://api.coingecko.com/api/v3/coins/$coinId'
      );
      setState(() {
        coinData = response.data;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      debugPrint('Error loading coin: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(coinData?['name'] ?? 'Loading...')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Image.network(
                    coinData?['image']['large'] ?? '',
                    height: 60,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.currency_bitcoin, size: 60);
                    },
                  ),
                  const SizedBox(width: 16),
                  Text(
                    '\$${coinData?['market_data']['current_price']['usd']?.toStringAsFixed(2) ?? '...'}',
                    style: const TextStyle(fontSize: 28),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('24h Change: '),
                  Text(
                    '${coinData?['market_data']['price_change_percentage_24h']?.toStringAsFixed(2) ?? '0'}%',
                    style: TextStyle(
                      color: (coinData?['market_data']['price_change_percentage_24h'] ?? 0) >= 0
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ],
              ),
              ListTile(
                title: const Text('Market Cap'),
                trailing: Text('\$${_formatNumber(coinData?['market_data']['market_cap']['usd'] ?? 0)}'),
              ),
              ListTile(
                title: const Text('24h Volume'),
                trailing: Text('\$${_formatNumber(coinData?['market_data']['total_volume']['usd'] ?? 0)}'),
              ),
              ListTile(
                title: const Text('Max Supply'),
                trailing: Text(_formatNumber(coinData?['market_data']['max_supply'] ?? 0)),
              ),
              if (coinData?['description']['en'] != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    coinData?['description']['en'] ?? '',
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatNumber(num value) {
    if (value >= 1000000000) {
      return '${(value / 1000000000).toStringAsFixed(2)}B';
    } else if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(2)}M';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(2)}K';
    }
    return value.toStringAsFixed(2);
  }
}