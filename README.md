# Taller raster

## Propósito

Comprender algunos aspectos fundamentales del paradigma de rasterización.

## Tareas

Emplee coordenadas baricéntricas para:

1. Rasterizar un triángulo;
2. Implementar un algoritmo de anti-aliasing para sus aristas; y,
3. Hacer shading sobre su superficie.

Implemente la función ```triangleRaster()``` del sketch adjunto para tal efecto, requiere la librería [frames](https://github.com/VisualComputing/framesjs/releases).

## Integrantes

Máximo 3.

Complete la tabla:

| Integrante | github nick |
|------------|-------------|
| Degly Sebastián Pava | DglyP |
| Carlos Arturo López | caralopezromUN |

## Discusión

Mediante la utilización de la librería frames pudimos realizar el raster del triangulo utilizando las coordenadas baricéntricas. Para la implementación del algoritmo de anti-aliasing identificamos mediante la información encontrada en https://www.scratchapixel.com/lessons/3d-basic-rendering/rasterization-practical-implementation/rasterization-stage, los puntos que se encontraban en los bordes (aristas) del triangulo y los coloreabamos teniendo en cuenta los valores de RGBA que se encontraban en el triangulo.

Finalmente, para la realización del shading tuvimos que definir a cuales  iban a ser los colores de los pixeles que se encontraban en el triangulo. Se colorean teniendo en cuenta 3 puntos, 3 colores y 3 normales.

Las siguientes teclas activan cada una de las funciones:

1. Tecla '1' : Rasterizar el triangulo
2. Tecla '2' : AntiAliasing
3. Tecla '3' : Shading

Se investigaron las siguientes técnicas:

Anti Aliasing: 
- OverSampling
- UnderSampling
- MSAA
- Spatial AntiAliasing

Shading:
- Smooth shading
- Analytical shading
- Aspect-Based shading

Tuvimos dificultades al entender las coordenadas baricéntricas pero gracias a la documentación logramos entender la forma de identificar los bordes y la forma de pintar el triangulo. La capacidad computacional afectó en el desarrollo al utilizar un grid muy pequeño, sin embargo, se logró llegar al punto óptimo para demostrar cada una de las tareas.

## Entrega

* Modo de entrega: [Fork](https://help.github.com/articles/fork-a-repo/) la plantilla en las cuentas de los integrantes (de las que se tomará una al azar).
* Plazo: 1/4/18 a las 24h.
