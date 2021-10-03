import 'package:carousel_slider/carousel_slider.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trueke/screens/home_screen.dart';
import 'package:trueke/screens/notification_screen.dart';
import 'package:trueke/utilities/constants.dart';

class ItemDescriptionScreen extends StatefulWidget {
  final String photo;
  final String title;
  final String description;

  const ItemDescriptionScreen({Key key, this.photo, this.title, this.description}) : super(key: key);

  @override
  _ItemDescriptionScreenState createState() => _ItemDescriptionScreenState();
}

class _ItemDescriptionScreenState extends State<ItemDescriptionScreen> {
  String path;
  bool favorite = false;
  Icon icon;

  List<String> imgList;

  @override
  void initState() {
    super.initState();
    path = widget.photo;
    imgList = [
      'assets/images/$path-1.webp',
      'assets/images/$path-2.webp',
      'assets/images/$path-3.webp',
    ];
    icon = new Icon(Icons.favorite_border);
  }

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
                      isSelected: false,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen())),
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
          )
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Padding(
            padding: EdgeInsets.all(10),
            child: Text("Nuevo",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text("${widget.title}",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          SizedBox(height: 5),
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: Icon(Icons.star, size: 15),
                ),
                WidgetSpan(
                  child: Icon(Icons.star, size: 15),
                ),
                WidgetSpan(
                  child: Icon(Icons.star, size: 15),
                ),
                WidgetSpan(
                  child: Icon(Icons.star, size: 15),
                ),
                WidgetSpan(
                  child: Icon(Icons.star_half, size: 15),
                ),
                TextSpan(
                    text: " (3)",
                    style: TextStyle(color: Colors.black)
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            color: Colors.grey[200],
            child: CarouselSlider(
              options: CarouselOptions(
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,
              ),
              items: imgList.map((item) => ClipRRect(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      new Image.asset(item, fit: BoxFit.cover,
                      ),
                    ],
                  )
              )).toList(),
            ),
          ),
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black)
            ),
            child: ListTile(
              title: Text('Jane Doe'),
              subtitle: RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(Icons.place),
                    ),
                    TextSpan(
                      text: " Zapopan, Jalisco",
                      style: TextStyle(color: Colors.black)
                    ),
                  ],
                ),
              ),
              leading: CircleAvatar(
                radius: 25.0,
                backgroundImage: AssetImage(
                    "assets/images/woman.png"
                ),
                backgroundColor:  Colors.white,
              ),
              trailing: icon,
              onTap: () {
                favorite = !favorite;
                setState(() {
                  icon = favorite ? Icon(Icons.favorite) : Icon(Icons.favorite_border);
                });
              },
            ),
          ),
          SizedBox(height: 10),
          /*Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text("Valor estimado",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text("\$10,000.00",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
              ),
            ),
          ),*/
          SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text("Detalles",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              '${widget.description}',
              style: TextStyle(
                color: Colors.black
              ),
            ),
          ),
          SizedBox(height: 15),
          Center(
            child: ElevatedButton(
              child: Text("Me interesa!"),
              onPressed: () {
                CoolAlert.show(
                  context: context,
                  type: CoolAlertType.confirm,
                  title: 'Confirmación',
                  text: '¿Mandar un mensaje de Trueke?',
                  confirmBtnText: 'Sí',
                  cancelBtnText: 'No',
                  onConfirmBtnTap: () {
                    CoolAlert.show(
                      context: context,
                      type: CoolAlertType.success,
                      text: 'Se ha mandado un mensaje de Trueke!',
                      autoCloseDuration: Duration(seconds: 2),
                    );
                  },
                  confirmBtnColor: Colors.green,
                );
              },
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
