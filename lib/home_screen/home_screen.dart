import 'package:add_to_cart_api/model_class/fake_api_photos_model_class.dart';
import 'package:add_to_cart_api/provider/provider.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  List<MyFakeApiPhotosModelClass> myFakeApiModelClass = [];

  String? title;

  Future blocLoadApiData() async {
    final response = await http.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/photos')); // Replace the URL with your API endpoint
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (Map<String, dynamic> index in data) {
        myFakeApiModelClass.add(MyFakeApiPhotosModelClass.fromJson(index));
        title = myFakeApiModelClass[0].title.toString();
      }
      print("Length of the list is ${myFakeApiModelClass.length}");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    blocLoadApiData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Main Page",
        ),
        backgroundColor: Colors.blue,
        actions: [
          Consumer<HomeScreenStateMangement>(
            builder: (context, value, child) {
              return IconButton(
                  onPressed: () {
                    value.navigateToCartScreen(context);
                  },
                  icon: const Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                  ));
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: blocLoadApiData(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: myFakeApiModelClass.length,
                    itemBuilder: (context, index) {
                      final model = myFakeApiModelClass[index];

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
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Center(
                                  child: Consumer<HomeScreenStateMangement>(
                                    builder: (context, value, child) {
                                      return InkWell(
                                        onTap: () {
                                          value.addDatatoCartScreen(model);
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
                                              "Add",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
