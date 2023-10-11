import 'package:bloc_demo/provider_demo/src/screens/home/providers/home_provider.dart';
import 'package:bloc_demo/provider_demo/src/utils/utilities.dart';
import 'package:bloc_demo/provider_demo/src/widgets/shimmers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<HomeProvider>(context, listen: false).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Build() called");
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "My Product",
          ),
          actions: [
            Consumer<HomeProvider>(
              builder: (_, provider, __) {
                debugPrint("DD Consumer() called");

                return Center(
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        border: Border.all(
                          color: Colors.white,
                          width: 1.4,
                        )),
                    child: DropdownButton<String>(
                      value: provider.dropDvalue,
                      onChanged: (String? newValue) async {
                        provider.dropDvalue = newValue!;
                        if (newValue.isNotEmpty &&
                            newValue != "--Select Category--") {
                          await provider.setSelectedItem(newValue);
                        } else {
                          Utilities.showToast(
                              "Please select at least one category");
                        }
                      },
                      dropdownColor: Colors.amber,
                      underline: const SizedBox.shrink(),
                      items: provider.dropDItems
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(fontSize: 13),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(width: 20),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Selector<HomeProvider, int>(
                  builder: (_, provider, __) {
                    debugPrint("Badge Selector() called");
                    return badges.Badge(
                      ignorePointer: false,
                      badgeContent: Text("$provider"),
                      child: Icon(provider > 0
                          ? Icons.shopping_bag
                          : Icons.shopping_bag_outlined),
                    );
                  },
                  selector: (BuildContext, hp) {
                    return hp.cartCount;
                  },
                ),
              ),
            ),

            /* InkWell(
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Icon(Icons.sort),
              ),
            ) */
          ]),
      body: RefreshIndicator(
          onRefresh: () async {
            Provider.of<HomeProvider>(context, listen: false).init();
          },
          child: const ProductListView()),
    );
  }
}

class ProductListView extends StatelessWidget {
  const ProductListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder:
          (BuildContext context, HomeProvider homeProvider, Widget? child) {
        debugPrint("Product List Consumer() called times ");

        return homeProvider.productList.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: homeProvider.productList.isNotEmpty
                    ? homeProvider.productList.length
                    : 0,
                itemBuilder: (bc, index) {
                  final data = homeProvider.productList[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                          title: Text(data.title.toString()),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${data.description}',
                                //style: const TextStyle(color: Colors.white),
                              ),
                              if (1 == 0) ...[],
                              ElevatedButton(
                                  onPressed: () async {
                                    context.read<HomeProvider>().addToCart(
                                        index,
                                        isAdded: data.addToCart!);
                                  },
                                  child: Text(data.addToCart!
                                      ? "Added"
                                      : "Add To Cart"))
                            ],
                          ),
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(data.image.toString()),
                          )),
                    ),
                  );
                })
            //: const Center(child: CircularProgressIndicator.adaptive());
            : const ShimmerForListView(); //
      },
    );
  }
}
