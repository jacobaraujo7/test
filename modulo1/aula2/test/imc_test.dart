import 'package:imc/imc.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  setUp(() => null);
  tearDown(() => null);
  setUpAll(() => null);
  tearDownAll(() => null);

  test('Deve efetuar o calculo do IMC', () {
    // arrange
    final peso = 64.0;
    final altura = 1.78;
    // act
    final result = calcIMC(altura, peso);
    // assert
    expect(result, equals(20.199469763918696));
    expect(result, isA<double>());
    expect(result, greaterThan(20));
    expect(result, isPositive);
    expect(result.toString(), matches(RegExp(r'\d')));
  });

  group('Excessões de parametros |', () {
    test('Deve lançar uma excessão se altura for menor que 1', () {
      expect(() => calcIMC(0, 64), throwsA(isA<Exception>()));
    });
    test('Deve lançar uma excessão se peso for menor que 1', () {
      expect(() => calcIMC(1.78, 0), throwsA(isA<Exception>()));
    });
  });
}
