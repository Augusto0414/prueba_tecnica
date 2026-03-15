import 'package:btg_bank/models/fund.dart';
import 'package:btg_bank/providers/fund_provider.dart';
import 'package:btg_bank/widgets/home/fund_card.dart';
import 'package:btg_bank/widgets/home/subscription_form_sheet.dart';
import 'package:btg_bank/widgets/shared/fade_in_wrapper.dart';
import 'package:btg_bank/widgets/shared/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FundsGrid extends StatelessWidget {
  const FundsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final FundProvider provider = context.watch<FundProvider>();
    final bool largeScreen = MediaQuery.of(context).size.width > 760;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: provider.filteredFunds.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: largeScreen ? 2 : 1,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        mainAxisExtent: 260,
      ),
      itemBuilder: (BuildContext context, int index) {
        final Fund fund = provider.filteredFunds[index];
        return FadeInWrapper(
          delay: Duration(milliseconds: index * 50),
          child: FundCard(
            fund: fund,
            subscribed: provider.isSubscribed(fund.id),
            onSubscribe: () => _openSubscriptionSheet(context, provider, fund),
            onCancel: () => _cancelSubscription(context, provider, fund),
          ),
        );
      },
    );
  }

  Future<void> _openSubscriptionSheet(
    BuildContext context,
    FundProvider provider,
    Fund fund,
  ) async {
    final SubscriptionFormData? formData =
        await showModalBottomSheet<SubscriptionFormData>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          builder: (_) => SubscriptionFormSheet(fund: fund),
        );

    if (formData == null || !context.mounted) {
      return;
    }

    final String? error = await provider.subscribeToFund(
      fund: fund,
      notificationMethod: formData.notificationMethod,
      destination: formData.destination,
    );

    if (!context.mounted) {
      return;
    }

    if (error == null) {
      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (_) => const SuccessDialog(
          title: '¡Suscripción Exitosa!',
          message: 'Te has vinculado correctamente al fondo.',
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
          backgroundColor: const Color(0xFFB91C1C),
        ),
      );
    }
  }

  Future<void> _cancelSubscription(
    BuildContext context,
    FundProvider provider,
    Fund fund,
  ) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Cancelar participacion'),
          content: Text('¿Deseas cancelar tu participacion en ${fund.name}?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('No'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const Text('Si, cancelar'),
            ),
          ],
        );
      },
    );

    if (confirmed != true || !context.mounted) {
      return;
    }

    final String? error = await provider.cancelFund(fund);

    if (!context.mounted) {
      return;
    }

    if (error == null) {
      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (_) => const SuccessDialog(
          title: 'Cancelación Exitosa',
          message: 'Tu participación ha sido cancelada y el saldo ha sido devuelto.',
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
          backgroundColor: const Color(0xFFB91C1C),
        ),
      );
    }
  }
}
