import 'package:carousel_slider/carousel_slider.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trueke/models/post.dart';
import 'package:trueke/models/user.dart';
import 'package:trueke/screens/home_screen.dart';
import 'package:trueke/screens/notification_screen.dart';
import 'package:trueke/services/database_service.dart';
import 'package:trueke/utilities/constants.dart';

class ItemDescriptionScreen extends StatefulWidget {
  final dynamic json;

  const ItemDescriptionScreen({Key key, this.json}) : super(key: key);

  @override
  _ItemDescriptionScreenState createState() => _ItemDescriptionScreenState();
}

class _ItemDescriptionScreenState extends State<ItemDescriptionScreen> {
  Post post;
  User owner;
  int votes = 0;
  bool favorite = false;
  Icon icon;
  List<String> imgList;

  @override
  void initState() {
    icon = new Icon(Icons.favorite_border);
    setProduct();
    imgList = [
      "https://sagarsoftware.com/public/posts/${post.id}/1.jpeg",
      "https://sagarsoftware.com/public/posts/${post.id}/2.jpeg",
      "https://sagarsoftware.com/public/posts/${post.id}/3.jpeg"
    ];
    super.initState();
  }

  void setProduct() {
    print(widget.json);
    setState(() {
      post = Post.fromJson(widget.json['post']);
      owner = User.fromJson(widget.json['user']);
      votes = widget.json['votes'];
    });
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
                                title: Text('Cerrar Sesi??n'),
                                onTap: () => signOut(context),
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
            child: Text("${post.condition}",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text("${post.title}",
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
                  child: Icon(Icons.favorite, size: 15),
                ),
                TextSpan(
                    text: " $votes votos",
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
                      new Image.network(item, fit: BoxFit.cover,
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
              title: Text('${owner.name} ${owner.lastname}'),
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
                backgroundImage: NetworkImage(
                  "https://sagarsoftware.com/public/profiles/${owner.image}",
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
              '${post.description}',
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
                  title: 'Confirmaci??n',
                  text: '??Mandar un mensaje de Trueke?',
                  confirmBtnText: 'S??',
                  cancelBtnText: 'No',
                  onConfirmBtnTap: () {
                    // TODO mandar a elegir objeto
                    if(settings.truekoin == 0) {
                      CoolAlert.show(
                        context: context,
                        type: CoolAlertType.error,
                        text: 'No cuenta con truekoins para realizar esta acci??n'
                      );
                    } else {
                      Navigator.pushNamed(context, '/trueke', arguments: post);
                    }
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
