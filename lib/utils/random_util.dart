import 'dart:math';

class RandomUtil {
  static getRandomIntBetween(int min, int max) {
    // Crear una instancia de la clase Random
    Random random = Random();

    // Generar un número aleatorio dentro del rango específico
    int randomNumber = min + random.nextInt(max - min + 1);

    return randomNumber;
  }
}
