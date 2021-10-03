import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sliding_card/sliding_card.dart';
import 'package:trueke/utilities/device_size.dart';
import 'package:trueke/widgets/notification_card.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  SlidingCardController _controller;
  SlidingCardController _controller2;
  bool visible1, visible2;

  @override
  void initState() {
    super.initState();
    _controller = SlidingCardController();
    _controller2 = SlidingCardController();
    visible1 = true;
    visible2 = true;
  }

  @override
  Widget build(BuildContext context) {
    DeviceSize().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Notificaciones'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: visible1,
                child: NotificationCard(
                  name: "Luis",
                  lastName: "Lomelí",
                  created_at: "28 Septiembre 2021 ",
                  creation_hour: "1:00pm",
                  information: "Te propongo un cambio por este producto, me interesa mucho.",
                  image: '1-1.webp',
                  truekeImage: '5-1.webp',
                  onAccept: () {
                    CoolAlert.show(
                      context: context,
                      type: CoolAlertType.success,
                      text: 'Trueke aceptado, te mandamos un correo con el seguimiento!',
                      autoCloseDuration: Duration(seconds: 2),
                    );
                    setState(() {
                      visible1 = false;
                    });
                  },
                  onDecline: () {
                    setState(() {
                      visible1 = false;
                    });
                  },
                  onTapped: () {
                    if(_controller.isCardSeparated == true) {
                      _controller.collapseCard();
                    } else {
                      _controller.expandCard();
                    }
                  },
                  slidingCardController: _controller,
                ),
              ),
              SizedBox(height: 15),
              Visibility(
                visible: visible2,
                child: NotificationCard(
                  name: "Francisco",
                  lastName: "Ramirez",
                  created_at: "27 Septiembre 2021 ",
                  creation_hour: "5:46pm",
                  information: "Me interesa mucho tu laptop, te ofrezco la mia a cambio",
                  image: '1-1.webp',
                  truekeImage: '2-1.webp',
                  onAccept: () {
                    CoolAlert.show(
                      context: context,
                      type: CoolAlertType.success,
                      text: 'Trueke aceptado, te mandamos un correo con el seguimiento',
                      autoCloseDuration: Duration(seconds: 2),
                    );
                    setState(() {
                      visible2 = false;
                    });
                  },
                  onDecline: () {
                    setState(() {
                      visible2 = false;
                    });
                  },
                  onTapped: () {
                    if(_controller2.isCardSeparated == true) {
                      _controller2.collapseCard();
                    } else {
                      _controller2.expandCard();
                    }
                  },
                  slidingCardController: _controller2,
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
