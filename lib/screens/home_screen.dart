import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trueke/screens/notification_screen.dart';
import 'package:trueke/tiles/product_tile.dart';
import 'package:trueke/utilities/constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
  }

  final List<String> imgList = [
    'assets/images/add1.jpg',
    'assets/images/add2.jpg',
    'assets/images/add3.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6CA8F1),
        iconTheme: IconThemeData(color: Colors.black),
        title: Container(
          child: Stack(
            children: [
              TextField(
                keyboardType: TextInputType.name,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey[700],
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[700]),
                  hintText: "Buscar...",
                  fillColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
              icon: Stack(
                children: [
                  FaIcon(FontAwesomeIcons.handshake),
                  Positioned(
                    right: 0,
                    child: new Container(
                      padding: EdgeInsets.all(1),
                      decoration: new BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 12,
                        minHeight: 12,
                      ),
                      child: new Text(
                        '2',
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen())),
          )
        ],
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      drawer: Drawer(
          child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: ListView(padding: EdgeInsets.zero, children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Color(0xFF6CA8F1)),
                child: Column(
                  children: [
                    Expanded(
                        child: Image.asset(
                      'assets/logos/trueke.png',
                      width: 150,
                    )),
                    SizedBox(height: 10)
                  ],
                ),
              ),
              _menuItemTile(
                text: 'Inicio',
                icon: Icons.home,
                isSelected: true,
                onTap: () {}
              ),
              _menuItemTile(
                  text: 'Favoritos',
                  icon: Icons.favorite,
                  isSelected: false,
                  onTap: () {}
              ),
              _menuItemTile(
                  text: 'Mis truekes',
                  icon: Icons.shopping_basket,
                  isSelected: false,
                  onTap: () {}
              ),
              _menuItemTile(
                  text: 'Mi perfil',
                  icon: Icons.person,
                  isSelected: false,
                  onTap: () {}
              ),
            ]),
          ),
          Container(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.settings),
                        title: Text('Settings'),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: Icon(Icons.logout),
                        title: Text('Cerrar Sesión'),
                        onTap: () {},
                      ),
                    ],
                  )
                )
            )
          ),
        ],
      )),
      body: Column(
        children: [
          Container(
            color: Color(0xFF6CA8F1),
            child: ListTile(
              leading: Icon(Icons.place),
              title: Text("Zapopan, Jalisco"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
          SizedBox(height: 10),
          Container(
            child: CarouselSlider(
              options: CarouselOptions(
                enlargeCenterPage: true,
                autoPlay: true,
                enableInfiniteScroll: true,
                height: 150
              ),
              items: imgList.map((item) => ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(item, fit: BoxFit.cover,
                      ),
                    ],
                  )
              )).toList(),
            ),
          ),
          SizedBox(height: 10),
          TabBar(
            controller: _tabController,
            indicatorColor: Colors.transparent,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            labelPadding: EdgeInsets.symmetric(horizontal: 35),
            isScrollable: true,
            tabs: [
              Tab(
                child: Text(
                  'Novedades',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Recomendados',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Favoritos',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(0),
              children: [
                ProductTile(title: "Laptop Huawei 8GB", description: "En perfecto estado 128SSD", photo: "1"),
                ProductTile(title: "Laptop HP", description: "4 GB RAM", photo: "2"),
                ProductTile(title: "Celular Xiaomi", description: "Redmi 9C Nuevo", photo: "3"),
                ProductTile(title: "Motosierra", description: "Excelente para uso domestico", photo: "4"),
                ProductTile(title: "Smartwatch Clon", description: "iWatch clon, nuevo", photo: "5"),
                ProductTile(title: "TLC Televisión", description: "No tiene la base", photo: "6"),
                ProductTile(title: "Kit de herramientas", description: "Marca Dewalt, americano", photo: "7")
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _menuItemTile({IconData icon, String text, GestureTapCallback onTap, bool isSelected}) {
    return Ink(
      color: isSelected ? Color(0xffE3EAFF) : Colors.transparent,
      child: ListTile(
        selected: true,
        hoverColor: Colors.white,
        title: Row(
          children: <Widget>[
            Icon(icon),
            Padding(
              padding: EdgeInsets.only(left: 25.0),
              child: Text(text),
            )
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
