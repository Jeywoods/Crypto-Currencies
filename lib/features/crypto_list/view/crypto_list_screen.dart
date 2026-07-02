import 'package:crypto_currencies_list_app/features/crypto_list/widgets/widgets.dart';
import 'package:crypto_currencies_list_app/repositories/crypto_coins/crypto_coins_repository.dart';
import 'package:crypto_currencies_list_app/repositories/crypto_coins/models/crypto_coin_model.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key});

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  final CryptoCoinsRepository _repository = CryptoCoinsRepository();
  List<CryptoCoin> _coins = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadCoins();
  }

  Future<void> _loadCoins() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final coins = await _repository.getCoinsList();
      setState(() {
        _coins = coins;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to load coins: $e';
      });
      dev.log('Error loading coins: $e', name: 'CryptoListScreen');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crypto Currencies List'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 60, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              _errorMessage!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadCoins,
              child: const Text('Retry'),
            ),
          ],
        ),
      )
          : _coins.isEmpty
          ? const Center(child: Text('No coins available'))
          : ListView.separated(
        itemCount: _coins.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, i) {
          final coin = _coins[i];
          return CryptoCoinTile(
            coinName: coin.name,
            price: '\$${coin.price.toStringAsFixed(2)}',
            priceChange: coin.priceChange,
            imageUrl: coin.imageUrl,
            coinId: coin.id,
          );
        },
      ),
    );
  }
}