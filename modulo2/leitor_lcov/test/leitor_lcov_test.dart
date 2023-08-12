import 'package:leitor_lcov/leitor_lcov.dart';
import 'package:leitor_lcov/line_report.dart';
import 'package:test/test.dart';

void main() {
  test('deve pegar porcentagem de cobertura', () {
    final result = coverage('./coverage/lcov.info');
    expect(result, '100%');
  });

  test('deve calcular a porcentagem em 50%', () {
    final result = calculatePercent([
      LineReport(sourceFile: '', lineFound: 18, lineHit: 9),
      LineReport(sourceFile: 'ds', lineFound: 10, lineHit: 5),
    ]);
    expect(result, 50);
  });
}
