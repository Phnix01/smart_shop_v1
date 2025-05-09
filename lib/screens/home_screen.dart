import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_shop_v1/consts/app_constants.dart';
import 'package:smart_shop_v1/providers/products_provider.dart';
import 'package:smart_shop_v1/providers/theme_provider.dart';
import 'package:smart_shop_v1/services/assets_manager.dart';
import 'package:smart_shop_v1/widgets/app_text_widget.dart';
import 'package:smart_shop_v1/widgets/products/category_rounded_widget.dart';
import 'package:smart_shop_v1/widgets/products/lastest_arrival.dart';
import 'package:smart_shop_v1/widgets/title_text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> bannerImage = [AssetsManager.banner1, AssetsManager.banner2];
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final productsProvider = Provider.of<ProductsProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            AssetsManager.shoppingCart,
          ),
        ),
        title: AppNameTextWidget(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: size.height * 0.25,
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return Image.asset(
                      bannerImage[index],
                      fit: BoxFit.fill,
                    );
                  },
                  itemCount: bannerImage.length,
                  pagination: SwiperPagination(
                    builder: DotSwiperPaginationBuilder(
                      activeColor: Colors.red,
                      color: Colors.white,
                    ),
                  ),
                  // control: SwiperControl(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TitleTextWidget(
                label: "Nouveau Arrivage",
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: size.height * 0.2,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return ChangeNotifierProvider.value(
                          value: productsProvider.getProducts[index],
                          child: const LatestArrivalProductsWidget());
                    }),
              ),
              const TitleTextWidget(label: "Categories"),
              const SizedBox(
                height: 15.0,
              ),
              GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                  AppConstants.categoriesList.length,
                  (index) {
                    return CategoryRoundedWidget(
                        image: AppConstants.categoriesList[index].image,
                        name: AppConstants.categoriesList[index].name);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
