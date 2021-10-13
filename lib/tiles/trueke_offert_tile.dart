import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:trueke/screens/item_description_screen.dart';
import 'package:trueke/models/post.dart';
import 'package:trueke/services/database_service.dart';
import 'package:trueke/utilities/constants.dart';

class TruekeOffertProductTile extends StatelessWidget {
  final Post post;

  const TruekeOffertProductTile({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Card(
      child: ListTile(
        title: Text("${post.title}"),
        subtitle: Text("Estatus: ${getStatus(post.status)}, Condiciones: ${post.condition}", style: TextStyle(
            color: getStatusColor(post.status)
        )),
        leading: Image.network(
          "https://sagarsoftware.com/public/posts/${post.id}/1.jpeg",
          width: 50,
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue),
        onTap: () async {
          CoolAlert.show(
            context: context,
            type: CoolAlertType.confirm,
            title: 'Confirmación',
            text: '¿Acepta este trueke?',
            confirmBtnText: 'Sí',
            cancelBtnText: 'No',
            onCancelBtnTap: () => Navigator.pop(context),
            onConfirmBtnTap: () async {
              if(settings.truekoin == 0) {
                CoolAlert.show(
                    context: context,
                    type: CoolAlertType.error,
                    text: 'No cuenta con truekoins para realizar esta acción'
                );
                Navigator.pop(context);
              } else {
                await acceptTrueke(post.id);
                print('aceptado');
                CoolAlert.show(
                  context: context,
                  type: CoolAlertType.success,
                  text: 'Se ha aceptado el mensaje de Trueke!',
                  autoCloseDuration: Duration(seconds: 2),
                );
                settings.truekoin = (int.parse(settings.truekoin)-1).toString();
                Navigator.pushNamed(context, '/home');
              }
            },
            confirmBtnColor: Colors.green,
          );
        },
      ),
    );
  }

  String getStatus(String status) {
    switch(status) {
      case 'open':
        return 'Abierto';
      case 'closed':
        return 'Cerrado';
      case 'trueke':
        return 'En trueke';
      default:
        return 'Cancelado';
    }
  }

  Color getStatusColor(String status) {
    switch(status) {
      case 'open':
        return Colors.green;
      case 'closed':
        return Colors.red;
      case 'trueke':
        return Colors.blueAccent;
      default:
        return Colors.black;
    }
  }

}
