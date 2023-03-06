import 'package:flutter/material.dart';
import 'package:flutter_sweater_shop/Models/shopping_item.dart';
import 'package:flutter_sweater_shop/Utilities/constants.dart';
import 'package:flutter_sweater_shop/Utilities/styles.dart';
import 'package:flutter_sweater_shop/Widgets/filtered_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const _containerPadding = EdgeInsets.symmetric(horizontal: 12, vertical: 10);

var _containerDecoration = BoxDecoration(
  color: Colors.white10,
  borderRadius: cBorderRadius,
  boxShadow: const [cBoxshadow],
);

const _hSpacer = SizedBox(width: 5);

const _vSpacer = SizedBox(height: 5);

class BasketItemCard extends StatelessWidget {
  final ShoppingItem basketItem;
  final Function() onDelete;
  final Function() onDecrementQuantity;
  final Function() onIncrementQuantity;

  BasketItemCard({
    super.key,
    required this.basketItem,
    required this.onDelete,
    required this.onDecrementQuantity,
    required this.onIncrementQuantity,
  });

  Widget _buildImage() {
    Color? color = basketItem.hasColor ? basketItem.productColor!.color : null;
    return FilteredImage(
      imageUrl: basketItem.image,
      color: color,
      width: 140,
      height: 140,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _containerPadding,
      decoration: _containerDecoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: _buildImage(),
              ),
              _hSpacer,
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _vSpacer,
                  Text(
                    basketItem.name,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  _vSpacer,
                  Text(
                    currencyFormatter.format(basketItem.price),
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ],
              )
            ],
          ),
          _vSpacer,
          Wrap(
            children: [
              Row(
                children: [
                  OutlinedButton(
                    onPressed: basketItem.quantity == 1
                        ? onDelete
                        : onDecrementQuantity,
                    child: Icon(
                      basketItem.quantity == 1 ? Icons.delete : Icons.remove,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text("${basketItem.quantity}"),
                  ),
                  OutlinedButton(
                    onPressed: onIncrementQuantity,
                    child: Icon(
                      Icons.add,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                  onPressed: onDelete,
                  child: Text(AppLocalizations.of(context)!.delete)),
              _hSpacer,
              ElevatedButton(
                  onPressed: () => {},
                  child: Text(AppLocalizations.of(context)!.move_to_wishlist))
            ],
          )
        ],
      ),
    );
  }
}
