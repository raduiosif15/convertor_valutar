import 'package:flutter/material.dart';

void main() {
  runApp(const ConvertorValutar());
}

class ConvertorValutar extends StatefulWidget {
  const ConvertorValutar({Key? key}) : super(key: key);

  @override
  _ConvertorValutarState createState() => _ConvertorValutarState();
}

class _ConvertorValutarState extends State<ConvertorValutar> {
  late String _valoareInEuro = '';
  late String _valoareInLei = '';

  late String _eroareInput = '';

  final double _cursValutarEuroLei = 4.93;

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Currency convertor'),
          ),
        ),
        body: ListView(
          children: <Widget>[
            Image.network(
                'https://storage0.dms.mpinteractiv.ro/media/1/1481/22467/15488613/1/4-2823078-publimedia-shutterstock-copy-copy.jpg?width=600'),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'enter the amount in EUR',
                  errorText: _eroareInput,
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.close,
                    ),
                    onPressed: () {
                      setState(() {
                        _controller.clear();
                      });
                    },
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (String value) {
                  _valoareInEuro = value;
                },
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      // validare valoare in euro
                      bool valid = true;
                      bool punct = false;
                      for (int i = 0; i < _valoareInEuro.length; i++) {
                        if (_valoareInEuro.codeUnitAt(i) != 46 &&
                            (_valoareInEuro.codeUnitAt(i) < 48 || _valoareInEuro.codeUnitAt(i) > 59)) {
                          valid = false;
                          _eroareInput = 'please insert a number';
                          break;
                        } else {
                          if (punct && _valoareInEuro.codeUnitAt(i) == 46) {
                            valid = false;
                            _eroareInput = 'please insert a number';
                            break;
                          }

                          if (!punct && _valoareInEuro.codeUnitAt(i) == 46) {
                            punct = true;
                          }
                        }
                      }

                      if (valid) {
                        _eroareInput = '';
                        // conversie string => double
                        final double valoareEuroFloat = double.parse(_valoareInEuro);

                        // conversie euro => lei
                        final double valoareLeiFloat = valoareEuroFloat * _cursValutarEuroLei;

                        // conversie string rotunjire cu 2 zecimale
                        _valoareInLei = valoareLeiFloat.toStringAsFixed(2);
                      }
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                    child: Text(
                      'CONVERT!',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.grey[300]!),
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                _valoareInLei != null ? _valoareInLei + ' RON' : '',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 50.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
