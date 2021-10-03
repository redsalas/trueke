import 'package:flutter/material.dart';
import 'package:trueke/utilities/device_size.dart';

class NotificationBackCard extends StatelessWidget {
  final String companyInfo;
  final Function onPhoneTapped;
  final String truekeImage;

  const NotificationBackCard({
    Key key,
    this.companyInfo,
    this.onPhoneTapped, this.truekeImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: DeviceSize.horizontalBloc * 90,
          height: DeviceSize.safeBlockVertical * 15,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(25)),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: Text(
                        'Mensaje :',
                        style: TextStyle(
                          fontSize: DeviceSize.safeBlockHorizontal * 5,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,),
                      ),
                    )),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      width: DeviceSize.safeBlockHorizontal * 80,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Container(
                              child: Text(
                                companyInfo,
                                style: TextStyle(
                                    fontSize:
                                    DeviceSize.safeBlockHorizontal * 4,
                                    color: Colors.black),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 4,
                              ),
                            ),
                          ),
                          Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: onPhoneTapped,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle),
                                    child: Center(
                                        child: Image.asset(
                                          "assets/images/$truekeImage",
                                          width: 50,
                                        )/*Icon(
                                          Icons.phone,
                                          size: DeviceSize.safeBlockHorizontal * 9,
                                          color: Colors.white,
                                        )*/
                                    ),
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}