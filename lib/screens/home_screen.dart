import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trueke/screens/notification_screen.dart';
import 'package:trueke/screens/notification_trueke_screen.dart';
import 'package:trueke/services/database_service.dart';
import 'package:trueke/tiles/product_tile.dart';
import 'package:trueke/models/post.dart';
import 'package:trueke/utilities/constants.dart';
import 'package:trueke/widgets/category_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{

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
                        '',
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
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationTruekeScreen())),
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
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(FontAwesomeIcons.coins),
                        SizedBox(width: 10),
                        Text('${settings.truekoin}')
                      ],
                    )
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
                text: 'Mis publicaciones',
                icon: Icons.post_add,
                isSelected: false,
                onTap: () => Navigator.pushNamed(context, '/user_posts')
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
                        onTap: () => signOut(context),
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
          Text('Categorías'),
          SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CategoryButton(
                  message: "Tecnología",
                  icon: Icon(Icons.laptop, color: Colors.white)
                ),
                SizedBox(width: 10),
                CategoryButton(
                  message: "Juguetes",
                  icon: Icon(FontAwesomeIcons.robot, color: Colors.white)
                ),
                SizedBox(width: 10),
                CategoryButton(
                  message: "Videojuegos",
                  icon: Icon(FontAwesomeIcons.playstation, color: Colors.white)
                ),
                SizedBox(width: 10),
                CategoryButton(
                  message: "Vehículos",
                  icon: Icon(FontAwesomeIcons.car, color: Colors.white)
                ),
                SizedBox(width: 10),
                CategoryButton(
                  message: "Telefonía",
                  icon: Icon(FontAwesomeIcons.mobileAlt, color: Colors.white)
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: FutureBuilder(
              future: getPosts(),
              builder: (context, snapshot) {
                if(snapshot.hasError) print(snapshot.error);
                return snapshot.hasData ? ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index){
                    List list = snapshot.data;
                    return ProductTile(post: Post.fromJson(list[index]));
                  },
                ) : Center(child: CircularProgressIndicator());
              },
            ),
          ),
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
