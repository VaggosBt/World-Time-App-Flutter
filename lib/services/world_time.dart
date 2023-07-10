import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{

  late String location ; //location name for the ui
  late String time;     // the time in the above location
  late String flag ;   // url to an asset flag icon
  late String url ;   // the location url for api endpoint
  late bool isDaytime; // true or false if daytime or not

  WorldTime(this.url,  this.location, this.flag);



  Future<void> getTime() async {

    try {

      //make the api request
      print('url: $url');
      print('location: $location');
      print('flag: $flag');
      Uri dataUrl = Uri.parse('http://worldtimeapi.org/api/timezone/$url');
      Response response = await get(dataUrl);
      Map data = jsonDecode(response.body);
      //print(data);

      // get specific properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
      //print('datetime: $datetime');
      //print('offset: $offset');

      // create DateTime object
      DateTime now = DateTime.parse(datetime.substring(0,26));
      //print(int.parse(offset));
      print('now: $now');

      //set the time property
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false ;
      time = DateFormat.jm().format(now);
    }catch(e){
      print('caught error: $e');
      time = 'Could not get tiime data';

    }



  }


}

