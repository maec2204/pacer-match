import 'package:flutter_test/flutter_test.dart';
import 'package:pacer_match/core/dominio/ritmo.dart';

void main() {
  group('Ritmo.parse', () {
    test('"4:05.3" vale 245,3 s y se muestra igual', () {
      final ritmo = Ritmo.parse('4:05.3');
      expect(ritmo.decimas, 2453);
      expect(ritmo.segundos, 245.3);
      expect(ritmo.toString(), '4:05.3');
    });

    test('"4:05" se lee como 4:05.0', () {
      final ritmo = Ritmo.parse('4:05');
      expect(ritmo, Ritmo.parse('4:05.0'));
      expect(ritmo.toString(), '4:05.0');
    });

    test('acepta minutos de dos cifras', () {
      expect(Ritmo.parse('12:30').toString(), '12:30.0');
    });

    for (final malo in [
      '4:65', 'abc', '4:5', '4:05.34', '4:05,3', ' 4:05', '4:05 ', //
      '123:00', ':05', '4:', '', '0:00', '0:00.0',
    ]) {
      test('rechaza "$malo"', () {
        expect(() => Ritmo.parse(malo), throwsFormatException);
        expect(Ritmo.tryParse(malo), isNull);
      });
    }
  });

  group('comparar', () {
    final rapido = Ritmo.parse('4:05.3');
    final lento = Ritmo.parse('4:05.4');

    test('menor es más rápido', () {
      expect(rapido < lento, isTrue);
      expect(lento > rapido, isTrue);
      expect(rapido.compareTo(lento), lessThan(0));
    });

    test('iguales por décimas', () {
      expect(Ritmo.parse('4:05.3'), rapido);
      expect(Ritmo.parse('4:05.3').hashCode, rapido.hashCode);
      expect(rapido <= Ritmo.parse('4:05.3'), isTrue);
      expect(rapido >= Ritmo.parse('4:05.3'), isTrue);
    });

    test('se ordena de más rápido a más lento', () {
      final lista = [lento, Ritmo.parse('3:59.9'), rapido]..sort();
      expect(lista.map((r) => r.toString()), ['3:59.9', '4:05.3', '4:05.4']);
    });
  });

  group('sumarSegundos', () {
    test('conserva la décima', () {
      expect(Ritmo.parse('4:05.3').sumarSegundos(-1), Ritmo.parse('4:04.3'));
      expect(Ritmo.parse('4:59.3').sumarSegundos(1), Ritmo.parse('5:00.3'));
    });

    test('no baja de una décima', () {
      expect(() => Ritmo.parse('0:00.5').sumarSegundos(-1), throwsRangeError);
    });
  });
}
