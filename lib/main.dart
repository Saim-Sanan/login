import 'package:flutter/material.dart';
import 'package:widgets/menu_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final userNameController = TextEditingController();
  final passWordController = TextEditingController();
  bool isShow = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : Center(
              child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildTextBlue("Login"),
                  TextField(
                    controller: userNameController,
                    decoration: InputDecoration(
                      labelText: "User Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: passWordController,
                    obscureText: isShow,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: isShow
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            isShow = !isShow;
                          });
                        },
                      ),
                      labelText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: login,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.blue,
                      backgroundColor: Colors.blue,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      minimumSize: Size(MediaQuery.sizeOf(context).width, 50),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        wordSpacing: 2,
                      ),
                    ),
                  ),
                ],
              ),
            )),
    );
  }

  Future<void> login() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 3));
    try {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Profile(
            text: userNameController.text,
            pass: passWordController.text,
          ),
        ),
      );
    } catch (e) {
      print("error");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget buildTextBlue(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.blue,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class Profile extends StatefulWidget {
  final String text;
  final String pass;
  const Profile({super.key, required this.text, required this.pass});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<MenuItem> menuItems = [
    MenuItem(title: 'burger', desc: 'sdadasdada', price: 20),
    MenuItem(title: 'pizza', desc: 'sdadasdada', price: 30),
    MenuItem(title: 'sandwich', desc: 'sdadasdada', price: 10),
  ];

  List<MyTile> items = [
    const MyTile(
      image: "assets/images/img.jpg",
      title: "Burger",
      price: "40",
    ),
    const MyTile(
      image: "assets/images/background.jpg",
      title: "pizza",
      price: "40",
    ),
    const MyTile(
      image: "assets/images/finalLogo.png",
      title: "asdasd",
      price: "40",
    ),
  ];

  List<MenuItem> favItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavItems(items: favItems),
                ),
              );
            },
            icon: const Icon(Icons.favorite),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(20),
            child: MyTile(
              image: items[index].image,
              title: items[index].title,
              price: items[index].price,
            ),
          );
          // ListTile(
          //   title: Text(menuItems[index].title),
          //   subtitle: Text(menuItems[index].desc),
          //   trailing: IconButton(
          //     icon: Icon(
          //       Icons.favorite,
          //       color: favItems.contains(menuItems[index])
          //           ? Colors.red
          //           : Colors.black,
          //     ),
          //     onPressed: () {
          //       setState(() {
          //         if (favItems.contains(menuItems[index])) {
          //           favItems.remove(menuItems[index]);
          //         } else {
          //           favItems.add(menuItems[index]);
          //         }
          //       });
          //     },
          //   ),
          // );
        },
      ),
    );
  }
}

class FavItems extends StatelessWidget {
  final List<MenuItem> items;
  const FavItems({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Items'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index].title),
            subtitle: Text(items[index].desc),
            trailing: Text("\$${items[index].price}"),
          );
        },
      ),
    );
  }
}

class MyTile extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  const MyTile(
      {super.key,
      required this.image,
      required this.title,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.all(30),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                image,
              ),
              fit: BoxFit.fill)),
      width: double.infinity,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Image.asset(
          //   "assets/images/img.jpg",
          //   height: 50,
          //   width: 50,
          // ),
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 30),
          ),
          Text(
            price,
            style: const TextStyle(color: Colors.white, fontSize: 30),
          ),
        ],
      ),
    );
  }
}
