import 'package:flutter/material.dart';
import 'package:rydex/assistants/request_assistant.dart';
import 'package:rydex/core/reusable_text.dart';
import 'package:rydex/core/space_exs.dart';
import 'package:rydex/models/predicted_places.dart';
import 'package:rydex/widget/place_prediction_tile.dart';

class SearchPlacesScreen extends StatefulWidget {
  const SearchPlacesScreen({super.key});

  @override
  State<SearchPlacesScreen> createState() => _SearchPlacesScreenState();
}

class _SearchPlacesScreenState extends State<SearchPlacesScreen> {
  List<PredictedPlaces> placesPredictedList = [];

  findPlaceAutoCompleteSearch(String inputText) async {
    if (inputText.length > 1) {
      String urlAutoCompleteSearch =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$inputText&key=$apiKey&components=country:NG";

      var responseAutoCompleteSearch =
          await RequestAssistant.recieveRequest(urlAutoCompleteSearch);
      if (responseAutoCompleteSearch == "no response") {
        print("no response");
        return;
      }
      if (responseAutoCompleteSearch["status"] == "OK") {
        print("ok");
        var placePrediction = responseAutoCompleteSearch["predictions"];
        var placePredictionList = (placePrediction as List).map((jsonData) => PredictedPlaces.fromJson(jsonData)).toList();
        print(placePredictionList.first);
        setState(() {
          placesPredictedList = placePredictionList;
        });
        
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool darkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: darkTheme ? Colors.black : Colors.white,
        appBar: AppBar(
          backgroundColor: darkTheme ? Colors.amber.shade400 : Colors.lightBlue,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: darkTheme ? Colors.black : Colors.white,
            ),
          ),
          title: ReuseableText(
              title: "Search & set drop-off location",
              style: TextStyle(
                  color: darkTheme ? Colors.black : Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold)),
          elevation: 0.0,
        ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: darkTheme ? Colors.amber.shade400 : Colors.lightBlue,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.white54,
                        blurRadius: 8,
                        spreadRadius: 0.5,
                        offset: Offset(0.7, 0.7))
                  ]),
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.adjust_sharp,
                          color: darkTheme ? Colors.black : Colors.white,
                        ),
                        15.h,
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: TextField(
                              onChanged: (value) {
                                findPlaceAutoCompleteSearch(value);
                              },
                              decoration: InputDecoration(
                                  hintText: "Search location here...",
                                  fillColor:
                                      darkTheme ? Colors.black : Colors.white54,
                                  filled: true,
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      left: 11, top: 8, bottom: 8)),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            (placesPredictedList.length > 0)
                ? Expanded(
                    child: ListView.separated(
                    physics: ClampingScrollPhysics(),
                    itemCount: placesPredictedList.length,
                    itemBuilder: (context, index) {
                      return PlacePredictionTileDesign(
                        predictedPlaces: placesPredictedList[index],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        height: 0,
                        color: darkTheme
                            ? Colors.amber.shade400
                            : Colors.lightBlue,
                        thickness: 0,
                      );
                    },
                  ))
                : SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
