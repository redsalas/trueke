import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:sliding_card/sliding_card.dart';
import 'package:trueke/utilities/device_size.dart';
import 'package:trueke/widgets/notification_back_card.dart';
import 'package:trueke/widgets/notification_front_card.dart';

class NotificationCard extends StatefulWidget {
  final  SlidingCardController slidingCardController;
  final Function onTapped;
  final String name;
  final String lastName;
  final String created_at;
  final String creation_hour;
  final String information;
  final String image;
  final String truekeImage;
  final Function onAccept;
  final Function onDecline;

  const NotificationCard({
    Key key,
    this.slidingCardController,
    this.onTapped,
    this.name,
    this.lastName,
    this.created_at,
    this.creation_hour,
    this.information,
    this.image, this.truekeImage, this.onAccept, this.onDecline}) : super(key: key);

  @override
  _NotificationCardState createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        widget.onTapped();
      },
      child: SlidingCard(
        slimeCardElevation: 0.5,
        slidingAnimationReverseCurve: Curves.bounceInOut,
        cardsGap: DeviceSize.safeBlockVertical,
        controller: widget.slidingCardController,
        slidingCardWidth: DeviceSize.horizontalBloc * 90,
        visibleCardHeight: DeviceSize.safeBlockVertical * 27,
        hiddenCardHeight: DeviceSize.safeBlockVertical * 15,
        frontCardWidget: NotificationFrontCard(
          candidateName: widget.name,
          candidateSurname: widget.lastName,
          interviewDate: widget.created_at,
          interviewTime: widget.creation_hour,
          image: widget.image,
          onInfoTapped: () {
            print('info pressed');
            widget.slidingCardController.expandCard();
          },
          onDecline: widget.onDecline,
          onAccept: widget.onAccept,
          onCloseButtonTapped: (){
            widget.slidingCardController.collapseCard();
          },
        ),
        backCardWidget:NotificationBackCard(
          truekeImage: widget.truekeImage,
            onPhoneTapped: (){},
            companyInfo: widget.information
        ),
      ),
    );
  }
}
