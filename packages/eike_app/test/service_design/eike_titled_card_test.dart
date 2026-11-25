import 'package:eike_app/service_design/components/eike_titled_card.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(EikeTitledCard, () {
    testWidgets(
      'should not overflow when a large text scale makes the title wrap',
      (tester) async {
        await tester.pumpWidget(
          const MediaQuery(
            data: MediaQueryData(textScaler: TextScaler.linear(3.0)),
            child: MaterialApp(
              home: Scaffold(
                body: EikeTitledCard(
                  leading: Icon(Icons.info_outline),
                  title: 'Ein Titel, der bei großer Schrift umbrechen muss',
                  trailing: Icon(Icons.edit),
                  child: Text('Inhalt'),
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);
      },
    );
  });
}
