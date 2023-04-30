# ProtectedMode_SISCOMP

Este código es un programa de arranque que cambia el procesador de la computadora del modo real al modo protegido. Primero, habilita el bit A20 y establece el modo VGA en modo normal. Luego deshabilita las interrupciones y carga la Tabla de Descriptores Global (GDT) en el registro GDTR. Después de eso, cambia el último bit del registro CR0 a 1 para activar el modo protegido y salta a la etiqueta “protected_mode”. En este punto, el código cambia a 32 bits y se establecen los registros de segmento con el valor de DATA_SEG. Luego, se carga un mensaje en ESI y se escribe directamente en la memoria de video para mostrarlo en la pantalla. Finalmente, el programa entra en un bucle infinito y se detiene.

## Requisitos

-   El compilador NASM (The Netwide Assembler) instalado en el sistema.
-   Un emulador de x86, como QEMU, para ejecutar el código en modo protegido.

## Ejecución

Para compilar y ejecutar el código en modo protegido, seguir los siguientes pasos:

1.  Clonar o descargar el repositorio en el equipo.
2.  Acceder a la carpeta del repositorio en la terminal.
3.  Ejecutar el comando `make`. Esto compilará el código, generando el archivo binario: `protected_mode.img`. Luego, correrá la máquina virtual desde el archivo binario utilizando **qemu**. 
4.  El programa cambiará al modo protegido y mostrará un mensaje en la pantalla indicando que se ha cambiado correctamente. 

## Archivos

-   `protected_mode.asm`: código en modo protegido.
-   `README.md`: archivo de explicación del contenido del repositorio y formas de ejecución del código que contiene.
-   `makefile`: archivo de make para compilar el código.
