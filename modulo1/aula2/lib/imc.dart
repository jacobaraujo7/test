import 'dart:math';

double calcIMC(double altura, double peso) {
  if (altura < 1) {
    throw Exception('Altura não pode ser menor que 1');
  }

  if (peso < 1) {
    throw Exception('Peso não pode ser menor que 1');
  }

  return peso / pow(altura, 2);
}
