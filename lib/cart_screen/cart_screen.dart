import 'package:add_to_cart_api/flutter_toast/flutter_toast.dart';
import 'package:add_to_cart_api/home_screen/home_screen.dart';
import 'package:add_to_cart_api/model_class/fake_api_photos_model_class.dart';
import 'package:add_to_cart_api/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MyCartScreen extends StatefulWidget {
  List<MyFakeApiPhotosModelClass> selectedItems = [];
  MyCartScreen({super.key, required this.selectedItems});

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  bool isCartEmpty = false;
  late String toast;

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));

    isCartEmpty = widget.selectedItems.isEmpty;
    animationController.forward();
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.repeat();
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Widget _buildEmptyCartAnimation() {
    Message.showToast("Your cart is empty");
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 300,
            width: 300,
            child: Expanded(
              child: AnimatedBuilder(
                child: RotationTransition(
                  turns: animationController,
                  child: Image(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/empty-cart.png"),
                  ),
                ),
                animation: animationController,
                builder: (BuildContext context, Widget? child) {
                  return Transform.rotate(
                    angle: animationController.value,
                    child: child,
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          RichText(
              text: const TextSpan(
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                  children: [
                TextSpan(text: "Your "),
                TextSpan(
                    text: "Cart ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: 30)),
                TextSpan(text: "is Empty")
              ]))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Cart Page"),
        leading: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MyHomeScreen()));
          },
          child: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyHomeScreen()));
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Consumer<HomeScreenStateMangement>(
        builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: isCartEmpty
                ? _buildEmptyCartAnimation()
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: widget.selectedItems.length,
                          itemBuilder: (context, index) {
                            final model = widget.selectedItems[index];

                            return Column(
                              children: [
                                Container(
                                  height: 162,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.black),
                                  ),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Expanded(
                                          child: Text(
                                            model.title.toString(),
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        leading: Expanded(
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.black,
                                              ),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGQ5rl0J8n2myZkotIPC6Ay5DWIB0UcVXgW-I68792t41c5y4X9GhqnEBEsH6J5trX7Is&usqp=CAU",
                                              ),
                                            ),
                                          ),
                                        ),
                                        trailing: Expanded(
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.black,
                                              ),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdeLyQ-Aw28lfgnIoJQhiUzfq50VV-I6VD16zIAwiT2WaIlunC9X3IyGIo1qXAxowmyb4&usqp=CAU",
                                              ),
                                            ),
                                          ),
                                        ),
                                        subtitle: Expanded(
                                          child: Text(
                                            "Id is: ${model.id.toString()}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.01,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                value
                                                    .removeItemsFromCart(model);
                                                isCartEmpty = widget
                                                    .selectedItems.isEmpty;
                                              },
                                              child: Container(
                                                height: 20,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.white,
                                                  ),
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: const Center(
                                                  child: Text(
                                                    "Remove",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 20,
                                                  width: 20,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: Colors.white,
                                                    ),
                                                    color: Colors.black,
                                                  ),
                                                  child: const Center(
                                                    child: FittedBox(
                                                      fit: BoxFit.cover,
                                                      child: Icon(
                                                        Icons.remove,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Container(
                                                  height: 20,
                                                  width: 20,
                                                  child: const Center(
                                                    child: Text(
                                                      "1",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Container(
                                                  height: 20,
                                                  width: 20,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: Colors.white,
                                                    ),
                                                    color: Colors.black,
                                                  ),
                                                  child: const Center(
                                                    child: FittedBox(
                                                      fit: BoxFit.cover,
                                                      child: Icon(
                                                        Icons.add,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.03,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
