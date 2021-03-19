import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storedoor/constants.dart';
import 'package:storedoor/controllers/category_controller.dart';
import 'package:storedoor/size_config.dart';
import 'package:storedoor/view/screen/auth/widgets/categories_widget.dart';

class ManageCategoryScreen extends StatelessWidget {
  final CategoryController categoryController =
      Get.find<CategoryController>(tag: "category-controller");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Get.back(),
        ),
      ),
      body: Container(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
        child: ListView(
          padding:
              EdgeInsets.symmetric(vertical: getProportionateScreenHeight(15)),
          children: [
            Text(
              "Kategori",
              style: TextStyle(
                color: mPrimaryColor,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            Obx(
              () => GridView.count(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                mainAxisSpacing: getProportionateScreenHeight(20),
                crossAxisSpacing: getProportionateScreenWidth(20),
                childAspectRatio: 4,
                crossAxisCount: 2,
                shrinkWrap: true,
                children: categoryController.categories
                    .map(
                      (c) => CategoryCard(
                        text: c.slug,
                        idx: c.id,
                        forManageCategory: true,
                      ),
                    )
                    .toList(),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(70),
            ),
            // Add Category
            Text(
              "Menambahkan Kategori",
              style: TextStyle(
                color: mPrimaryColor,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(25),
                  vertical: getProportionateScreenHeight(10)),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Nama Kategori",
                    ),
                    onChanged: categoryController.onChangeSlug,
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  Container(
                    width: getProportionateScreenWidth(180),
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      onPressed: () {
                        categoryController.addCategory();
                      },
                      color: oPrimaryColor,
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(50),
            ),
            Text(
              "Menghapus Kategori",
              style: TextStyle(
                color: mPrimaryColor,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            // Delete category
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(25),
                  vertical: getProportionateScreenHeight(10)),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Nama Kategori",
                    ),
                    onChanged: categoryController.onChangeSlugForDeleting,
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  Container(
                    width: getProportionateScreenWidth(180),
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      onPressed: () {
                        categoryController.removeCategory();
                      },
                      color: oPrimaryColor,
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(50),
            ),
            Text(
              "Memperbarui Kategori",
              style: TextStyle(
                color: mPrimaryColor,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            // Delete category
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(25),
                  vertical: getProportionateScreenHeight(10)),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Nama kategori sebelumnya",
                    ),
                    onChanged: categoryController.onChangeSlugBefore,
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Nama kategori setelah diperbarui",
                    ),
                    onChanged: categoryController.onChangeSlugAfter,
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  Container(
                    width: getProportionateScreenWidth(180),
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      onPressed: () {
                        categoryController.updateCategory();
                      },
                      color: oPrimaryColor,
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
