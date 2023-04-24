import 'package:auth_manager/config/constant.dart';
import 'package:flutter/material.dart';

class ReservationCard extends StatelessWidget {
  var _serviceName;
  var _date;
  var _time;
  String _iconService;

  ReservationCard(this._serviceName, this._date, this._time,
      this._iconService);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: ListTile(
          leading: _iconService == null
              ? Image.asset(_iconService)
              : Icon(Icons.history_outlined),
          title: Text(
            _serviceName,
            style: TextStyle(
              color: kTitleTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            _date + " " + _time,
            style: TextStyle(
              color: kTitleTextColor.withOpacity(0.7),
            ),
          ),
        ),
      ),
    );
  }
}
