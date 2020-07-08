import 'package:sistemadetrocas/model/ProductDeal.dart';
import 'package:sistemadetrocas/model/deal.dart';

class Item
{
  ProductDeal headerValue;
  Deal expandedValue;
  bool isExpanded;

  Item({
    this.headerValue,
    this.expandedValue,
    this.isExpanded = false,
  });

   static List<Item> generateItems(List<ProductDeal> productsDeals, List<Deal> deals)  {
    int numberOfItems = productsDeals.length;
     return List.generate(numberOfItems, (int index) {
      return Item(
        headerValue: productsDeals[index],
        expandedValue: _findDeal(productsDeals[index].gIdDeal, deals),
      );
    });
  }

  static Deal _findDeal(int idDeal, List<Deal> deals) {
     Deal deal;
     for(final Deal currentDeal in deals ) {
       if ( currentDeal.gId == idDeal) {
         deal = currentDeal;
         break;
       }
     }
     return deal;
  }
}