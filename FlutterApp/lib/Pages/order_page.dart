import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_sweater_shop/Models/order.dart';
import 'package:flutter_sweater_shop/Models/shopping_item.dart';
import 'package:flutter_sweater_shop/Utilities/constants.dart';

class OrderPage extends StatelessWidget {
  final Order order;

  const OrderPage({super.key, required this.order});

  Widget _buildSpacedText(BuildContext context, String text1, String text2) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Flexible(
        child: Text(
          text1,
          maxLines: 2,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
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

  Widget _buildItemListing(BuildContext context, ShoppingItem item) {
    var itemProperties = [];
    if (item.hasColor) itemProperties.add(item.productColor!.name);
    if (item.hasSize) itemProperties.add(item.productSize!.name);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSpacedText(context, "${item.quantity} x ${item.name}",
            currencyFormatter.format(item.price * item.quantity)),
        Text(itemProperties.join(", ")),
        const SizedBox(height: 5)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.order),
      ),
      body: Container(
        padding: pagePadding,
        child: Column(
          children: [
            _buildSpacedTextSmall(context, "", order.id),
            _buildSpacedText(
                context, "Created:", dateFormatter.format(order.createdAt)),
            const Divider(color: Colors.white),
            Flexible(
              child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: order.items.length,
                  separatorBuilder: (_, index) => const SizedBox(height: 5),
                  itemBuilder: (context, index) =>
                      _buildItemListing(context, order.items[index])),
            ),
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
    );
  }
}
