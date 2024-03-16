import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login_app_ui/const.dart';
import 'package:weather/weather.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherFactory _wf=WeatherFactory(OPENWEATHER_API_KEY);

  Weather? _weather;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _wf.currentWeatherByCityName("Mumbai").then((w){
      setState(() {
        _weather=w;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(body: _buildUI(),);

  }
  Widget _buildUI(){
    if(Weather==null){
      return const Center(

      );
    }
    return SizedBox(width: MediaQuery.sizeOf(context).width,
    height: MediaQuery.sizeOf(context).height,
      child:  Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _locationHeader(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height*0.08,
          ),
          _dateTimeInfo(),
          SizedBox(height: MediaQuery.sizeOf(context).height*0.05,),
          _weatherIcon(),
          SizedBox(height: MediaQuery.sizeOf(context).height*0.02,),
    _currentTemp(),
          SizedBox(height: MediaQuery.sizeOf(context).height*0.02,),
          _extraInfo(),
        ],
      ),
    );
  }
  Widget   _locationHeader(){
    return Text(_weather?.areaName ?? "",
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),)
    ;
  }

  Widget  _dateTimeInfo(){
    DateTime now=_weather!.date!;
    return Column(
      children: [
        Text(DateFormat("h:mm a").format(now), style: const TextStyle(
          fontSize: 35,
        ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(DateFormat("EEEE").format(now), style: const TextStyle(
                fontWeight: FontWeight.w300
            ),
            ),

            Text("  ${DateFormat("d.M.y").format(now)}", style: const TextStyle(
             fontWeight: FontWeight.w300
            ),
            ),
          ],
        )
      ],
    );
  }

  Widget _weatherIcon(){
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      Container(
        height:  MediaQuery.sizeOf(context).height*0.20,
        decoration: BoxDecoration(image: DecorationImage(image: NetworkImage("http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png"),
        ),
        ),
      ),
        Text(_weather?.weatherDescription ?? "",
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
        )
      ],
    );
  }

  Widget _currentTemp(){
    return Text("${_weather?.temperature?.celsius?.toStringAsFixed(0)}° C",
    style: const TextStyle(
      color: Colors.black,
      fontSize: 90,
      fontWeight: FontWeight.w500,
    ),
    );
  }
 Widget _extraInfo(){
    return Container(
  height: MediaQuery.sizeOf(context).height*0.15,
      width: MediaQuery.sizeOf(context).height*0.80,
      decoration: BoxDecoration(color: Colors.deepPurpleAccent,
      borderRadius: BorderRadius.circular(20),
      ),
 padding: const EdgeInsets.all(8.0),

    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [


            Text(
              "Sunrise: ${_weather?.sunrise != null ? DateFormat('hh:mm a').format(_weather!.sunrise!) : 'N/A'}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            Text(
              "Sunset: ${_weather?.sunset != null ? DateFormat('hh:mm a').format(_weather!.sunset!) : 'N/A'}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),

          ],
        ),


        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Wind: ${_weather?.windSpeed?.toStringAsFixed(0)}m/s",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,

              ),
            ),

            Text("Humidity: ${_weather?.humidity?.toStringAsFixed(0)}%",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,

              ),
            )
          ],
        ),
      ],
    ),
    );
 }
}
