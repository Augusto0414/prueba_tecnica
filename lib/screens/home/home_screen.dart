import 'package:btg_bank/providers/fund_provider.dart';
import 'package:btg_bank/screens/home/widgets/error_view.dart';
import 'package:btg_bank/screens/home/widgets/funds_grid.dart';
import 'package:btg_bank/widgets/home/balance_card.dart';
import 'package:btg_bank/widgets/shared/fade_in_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FundProvider provider = context.watch<FundProvider>();

    return RefreshIndicator(
      onRefresh: provider.loadFunds,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FadeInWrapper(
                  child: BalanceCard(balance: provider.balance),
                ),
                const SizedBox(height: 24),
                FadeInWrapper(
                  delay: const Duration(milliseconds: 100),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Fondos disponibles',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                FadeInWrapper(
                  delay: const Duration(milliseconds: 150),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      onChanged: provider.updateSearchQuery,
                      decoration: InputDecoration(
                        hintText: 'Buscar fondos...',
                        prefixIcon: const Icon(Icons.search, size: 20),
                        contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                FadeInWrapper(
                  delay: const Duration(milliseconds: 200),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: provider.categories.map((category) {
                        final isSelected = provider.selectedCategory == category;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ChoiceChip(
                            label: Text(category),
                            selected: isSelected,
                            onSelected: (selected) {
                              if (selected) {
                                provider.updateSelectedCategory(category);
                              }
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                if (provider.isLoading)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (provider.error != null)
                  ErrorView(
                    message: provider.error!,
                    onRetry: provider.loadFunds,
                  )
                else
                  const FundsGrid(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
