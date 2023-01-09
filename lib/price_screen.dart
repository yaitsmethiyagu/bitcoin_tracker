import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http_requests/http_requests.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'price_widget.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value.toString();
          updateUI();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: pickerItems,
    );
  }

  //TODO: Create a method here called getData() to get the coin data from coin_data.dart

  CoinData coinData = CoinData();

  String bTCPrice = '?';
  String eTHPrice = '?';
  String lTCPrice = '?';

  void updateUI() async {
    var bTCPriceFromData = await coinData.getCoinData(selectedCurrency, 'BTC');
    setState(() {
      bTCPrice = bTCPriceFromData;
    });
    var eTHPriceFromData = await coinData.getCoinData(selectedCurrency, 'ETH');
    setState(() {
      eTHPrice = eTHPriceFromData;
    });
    var lTCPriceFromDate = await coinData.getCoinData(selectedCurrency, 'LTC');
    setState(() {
      lTCPrice = lTCPriceFromDate;
    });
  }

  @override
  void initState() {
    super.initState();

    //TODO: Call getData() when the screen loads up.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          PriceWidget('1 BTC = $bTCPrice $selectedCurrency'),
          PriceWidget('1 ETH = $eTHPrice $selectedCurrency'),
          PriceWidget('1 LTC = $lTCPrice $selectedCurrency'),

          // Padding(
          //   padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
          //   child: Card(
          //     color: Colors.lightBlueAccent,
          //     elevation: 5.0,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(10.0),
          //     ),
          //     child: Padding(
          //       padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          //       child: Text(
          //         //TODO: Update the Text Widget with the live bitcoin data here.
          //         '1 BTC = $bTCPrice $selectedCurrency',
          //         textAlign: TextAlign.center,
          //         style: TextStyle(
          //           fontSize: 20.0,
          //           color: Colors.white,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
          //   child: Card(
          //     color: Colors.lightBlueAccent,
          //     elevation: 5.0,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(10.0),
          //     ),
          //     child: Padding(
          //       padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          //       child: Text(
          //         //TODO: Update the Text Widget with the live bitcoin data here.
          //         ,
          //         textAlign: TextAlign.center,
          //         style: TextStyle(
          //           fontSize: 20.0,
          //           color: Colors.white,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
          //   child: Card(
          //     color: Colors.lightBlueAccent,
          //     elevation: 5.0,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(10.0),
          //     ),
          //     child: Padding(
          //       padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          //       child: Text(
          //         //TODO: Update the Text Widget with the live bitcoin data here.
          //         '1 LTC = $lTCPrice $selectedCurrency',
          //         textAlign: TextAlign.center,
          //         style: TextStyle(
          //           fontSize: 20.0,
          //           color: Colors.white,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: androidDropdown(),
            // Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
