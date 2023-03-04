import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_sweater_shop/Models/order.dart';
import 'package:flutter_sweater_shop/Utilities/constants.dart';

class OrderPage extends StatelessWidget {
  final Order order;

  const OrderPage({super.key, required this.order});

  Widget _buildSpacedText(BuildContext context, String text1, String text2) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(text1, style: Theme.of(context).textTheme.displayMedium),
      Text(text2, style: Theme.of(context).textTheme.displayMedium)
    ]);
  }

  Widget _buildSpacedTextSmall(
      BuildContext context, String text1, String text2) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(text1, style: Theme.of(context).textTheme.labelLarge),
      Text(text2, style: Theme.of(context).textTheme.labelMedium)
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.order),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              _buildSpacedTextSmall(context, "Order-id:", order.id),
              _buildSpacedText(
                  context, "Created:", dateFormatter.format(order.createdAt)),
              const Divider(color: Colors.white),
              _buildSpacedText(context, AppLocalizations.of(context)!.subtotal,
                  currencyFormatter.format(order.subtotal)),
              _buildSpacedText(
                  context,
                  AppLocalizations.of(context)!.shipping_fee,
                  currencyFormatter.format(order.shipping)),
              const Divider(color: Colors.white),
              _buildSpacedText(context, AppLocalizations.of(context)!.total,
                  currencyFormatter.format(order.total)),
            ],
          ),
        ),
      ),
    );
  }
}
