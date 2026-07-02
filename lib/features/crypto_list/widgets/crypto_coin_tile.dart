import 'package:flutter/material.dart';

class CryptoCoinTile extends StatelessWidget {
  final String coinName;
  final String price;
  final double priceChange;
  final String imageUrl;
  final String coinId;

  const CryptoCoinTile({
    super.key,
    required this.coinName,
    required this.price,
    required this.priceChange,
    required this.imageUrl,
    required this.coinId,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPositive = priceChange >= 0;

    return ListTile(
      leading: imageUrl.isNotEmpty
          ? Image.network(
        imageUrl,
        height: 30,
        width: 30,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.currency_bitcoin, size: 30);
        },
      )
          : const Icon(Icons.currency_bitcoin, size: 30),
      title: Text(
        coinName,
        style: theme.textTheme.bodyMedium,
      ),
      subtitle: Text(
        price,
        style: theme.textTheme.labelSmall,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${isPositive ? '+' : ''}${priceChange.toStringAsFixed(2)}%',
            style: TextStyle(
              color: isPositive ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward_ios),
        ],
      ),
      onTap: () {
        Navigator.of(context).pushNamed(
          '/coin',
          arguments: coinId,
        );
      },
    );
  }
}