// import 'package:flutter/material.dart';

// class ListProductHomeWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: getProportionateScreenHeight(SizeConfig.screenHeight),
//       width: getProportionateScreenWidth(SizeConfig.screenWidth),
//       child: Obx(
//         () => ListView.builder(
//           padding: EdgeInsets.symmetric(
//             vertical: getProportionateScreenHeight(20),
//             horizontal: getProportionateScreenWidth(20),
//           ).copyWith(top: getProportionateScreenHeight(5)),
//           shrinkWrap: true,
//           itemCount: 
//           itemBuilder: (context, index) => ListProductWidget(
//             product: useForSearch
//                 ? productController.filteredProducts[index]
//                 : productController.products[index],
//             dismissible: useForSearch ? false : true,
//           ),
//         ),
//       ),
//     );
//   }
// }
