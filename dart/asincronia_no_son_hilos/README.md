# Asincronía no es multi-hilos

Existe el malentendido de que la asincronía significa trabajar con hilos. Esto no es cierto, pues la asincronía es un solo hilo.

Vamos a explorar un ejemplo que demuestra esto, mientras revisamos algunos de conceptos de Dart.

## Temas a ver

- Duration: [code](duration.dart) - [video](https://youtu.be/nirhpSFvynQ)
- DateTime: [code](datetime.dart) - [video](https://youtu.be/n8w3qVEmiGo)
- Intro a Futuros: [code](futures.dart) - [video](https://youtu.be/6ffqqXlynE8)
- Sintaxis async/await: [code](async_await.dart) - [video](https://youtu.be/Kr0pYnSgtbQ)
- Asincrononía no usa hilos: [code](no_threads.dart) - [video](https://youtu.be/QqPI7E2Gxi8)

## Disclaimer

- La asincronía es mucho más que `Future`, pero este tutorial es para demostrar que no son hilos. En un `futuro` tutorial (chiste intencional, `Future<Tutorial>`) ahondaremos en más cosas sobre la asincronía.
- Este tutorial podría ser hecho con JS o Python que soportan asincronía, pero Dart nos permite leer el código, por lo que podemos sacar mayor provecho educativo.
