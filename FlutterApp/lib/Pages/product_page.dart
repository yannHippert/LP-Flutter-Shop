import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_sweater_shop/Models/product.dart';
import 'package:flutter_sweater_shop/Models/product_color.dart';
import 'package:intl/intl.dart';

class ProductPage extends StatefulWidget {
  final Product product;

  const ProductPage({super.key, required this.product});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final oCcy = NumberFormat.simpleCurrency(locale: "fr_EU");
  ProductColor? _selectedColor;

  Product get product {
    return widget.product;
  }

  @override
  void initState() {
    super.initState();

    /*if (product.colors.isNotEmpty) {
      setState(() {
        _selectedColor = product.colors.elementAt(0);
      });
    }*/
  }

  Widget _buildImage() {
    Widget image = Image.network(product.image);
    if (_selectedColor != null) {
      return ColorFiltered(
          colorFilter: ColorFilter.mode(_selectedColor!.color, BlendMode.hue),
          child: image);
    }
    return image;
  }

  Widget _buildColorSelection() {
    if (product.isColorable) {
      return Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        children: product.colors
            .map(
              (color) => ElevatedButton(
                onPressed: () => setState(() {
                  _selectedColor = color;
                }),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        color == _selectedColor
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.secondary)),
                child: Text(color.name),
              ),
            )
            .toList(),
      );
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.product),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(6.0), child: _buildImage()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(oCcy.format(product.basePrice))
              ],
            ),
            _buildColorSelection()
          ],
        ),
      ),
    );
  }
}
