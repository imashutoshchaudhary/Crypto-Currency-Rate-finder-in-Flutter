import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class HomePage extends StatefulWidget {
  List currencies;
  HomePage(this.currencies);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List currencies;
  final List<MaterialColor> _colors =[Colors.blue,Colors.indigo,Colors.red];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Crypto Rate"),elevation: defaultTargetPlatform == TargetPlatform.iOS ? 0.0:5.0,),
      body: CryptoWidget(),
    );
  }

  Widget CryptoWidget() {
    return new Container(
      child: Column(
        children: <Widget>[
         new Flexible(child: new ListView.builder(itemBuilder: (BuildContext context,int index){
            final Map currency = widget.currencies[index];
            final MaterialColor color = _colors[index % _colors.length];
            return _getListItemUI(currency,color);
        },itemCount: widget.currencies.length,)),
      ]),
    );
  }

  Widget _getListItemUI(Map currency, MaterialColor color){
    return new ListTile(
      leading: new CircleAvatar(backgroundColor: color, child: new Text(currency['name'][0]),),
      title: new Text(currency['name'],style: new TextStyle(fontWeight: FontWeight.bold),),
      subtitle: _getSubtitleText(currency['price_usd'],currency['percent_change_1h']),
      isThreeLine: true,
    );
  }

  Widget _getSubtitleText(String priceUSD, String percentageChange){
    TextSpan priceTextWidget = new TextSpan(text: "\$$priceUSD\n",style: TextStyle(color: Colors.black));
    String percentageChangeText = "1 hour: $percentageChange%";
    TextSpan percentageChangeTextWidget;
    if (double.parse(percentageChange)>0){
      percentageChangeTextWidget = new TextSpan(text: percentageChangeText,style: new TextStyle(color: Colors.green));
    }
    else {
      percentageChangeTextWidget = new TextSpan(text: percentageChangeText,style: new TextStyle(color: Colors.red));
    }
    return new RichText(text: new TextSpan(children: [priceTextWidget,percentageChangeTextWidget]));
  }
}