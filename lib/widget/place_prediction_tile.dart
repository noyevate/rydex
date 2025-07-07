import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rydex/assistants/request_assistant.dart';
import 'package:rydex/core/reusable_text.dart';
import 'package:rydex/core/space_exs.dart';
import 'package:rydex/global/global.dart';
import 'package:rydex/info_handler/app_info.dart';
import 'package:rydex/models/directions.dart';
import 'package:rydex/models/predicted_places.dart';
import 'package:rydex/widget/progress_dialog.dart';

class PlacePredictionTileDesign extends StatefulWidget {
  const PlacePredictionTileDesign({super.key, this.predictedPlaces});

  final PredictedPlaces? predictedPlaces;

  @override
  State<PlacePredictionTileDesign> createState() =>
      _PlacePredictionTileDesignState();
}

class _PlacePredictionTileDesignState extends State<PlacePredictionTileDesign> {

  getPlaceDirectionDetails(String? placeId, context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => ProgressDialog(
        message: "Setting up drop-off, pleasw wait...",
      )
    );
    
    String placeDirectionDetailUrl = "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey";

    var responseApi = await RequestAssistant.recieveRequest(placeDirectionDetailUrl);
    Navigator.pop(context);
    if (responseApi == "no response") {
      return;
    }

    if(responseApi['status'] == "OK") {
      Directions directions = Directions();
      directions.locationName = responseApi['result']['name'];
      directions.locationId = placeId;
      directions.locationLatitude = responseApi['result']['geometry']['location']['lat'];
      directions.locationLongitude = responseApi['result']['geometry']['location']['lng'];


      Provider.of<AppInfo>(context, listen: false).updateDropOffLocation(directions);

      setState(() {
        UserDropOffAddress = directions.locationName!;
      });

      Navigator.pop(context, "obtainedDropOff");

    }
  }
  @override
  Widget build(BuildContext context) {
    bool darkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return MaterialButton(
      onPressed: () {
        getPlaceDirectionDetails(widget.predictedPlaces!.place_id, context);
      },
      color: darkTheme ? Colors.black : Colors.white,
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Row(
          children: [
            Icon(
              Icons.add_location,
              color: darkTheme ? Colors.amber.shade400 : Colors.lightBlue,
            ),
            10.s,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReuseableText(
                    title: widget.predictedPlaces!.main_text.toString(),
                    style: TextStyle(
                        fontSize: 15,
                        color: darkTheme
                            ? Colors.amber.shade400
                            : Colors.lightBlue),
                  ),

                  ReuseableText(
                    title: widget.predictedPlaces!.secondary_text.toString(),
                    style: TextStyle(
                        fontSize: 15,
                        color: darkTheme
                            ? Colors.amber.shade400
                            : Colors.lightBlue),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
