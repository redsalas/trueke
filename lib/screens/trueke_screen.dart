import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trueke/models/post.dart';
import 'package:trueke/services/database_service.dart';
import 'package:trueke/tiles/trueke_product_tile.dart';
import 'package:trueke/tiles/user_post_tile.dart';
import 'package:trueke/utilities/constants.dart';

class TruekeScreen extends StatefulWidget {
  final Post product;
  const TruekeScreen({Key key, this.product}) : super(key: key);

  @override
  _TruekeScreenState createState() => _TruekeScreenState();
}

class _TruekeScreenState extends State<TruekeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6CA8F1),
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Selección de Producto')
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
                      onTap: () => Navigator.pushNamed(context, '/home')
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
                      isSelected: true,
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
          Expanded(
            child: FutureBuilder(
              future: getPostsByUser(settings.userId),
              builder: (context, snapshot) {
                if(snapshot.hasError) print(snapshot.error);
                return snapshot.hasData ? ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index){
                    List list = snapshot.data;
                    return TruekeProductTile(post: Post.fromJson(list[index]), product: widget.product);
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
