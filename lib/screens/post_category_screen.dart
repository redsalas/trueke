import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trueke/screens/notification_screen.dart';
import 'package:trueke/services/database_service.dart';
import 'package:trueke/tiles/product_tile.dart';
import 'package:trueke/models/post.dart';
import 'package:trueke/utilities/constants.dart';

class PostCategoryScreen extends StatefulWidget {
  final String category;

  const PostCategoryScreen({Key key, this.category}) : super(key: key);

  @override
  _PostCategoryScreenState createState() => _PostCategoryScreenState();
}

class _PostCategoryScreenState extends State<PostCategoryScreen> with SingleTickerProviderStateMixin{

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
          Text('${widget.category}'),
          SizedBox(height: 10),
          Expanded(
            child: FutureBuilder(
              future: getPostsByCategory(widget.category),
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
