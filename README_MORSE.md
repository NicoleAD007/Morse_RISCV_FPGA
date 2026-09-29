# NICOLE en código Morse — Ensamblador RISC-V sobre FPGA

Programa bare-metal en ensamblador RISC-V que transmite el nombre
"NICOLE" en código Morse usando los LEDs de la Tang Primer 20K,
ejecutándose sobre el procesador FemtoRV32 del SoC.

**Autora:** Nicole Aguilera — naguilerad@unal.edu.co
Universidad Nacional de Colombia

## Cómo funciona

- **LED0:** parpadea el mensaje en Morse (destello corto = punto, largo = raya)
- **LED3:1:** muestran en binario el número de la letra actual (1 a 6)

Las letras se codifican con 2 bits por símbolo (01 = punto, 10 = raya,
00 = fin de letra), leídos desde el bit menos significativo. Los LEDs se
controlan por MMIO escribiendo en la dirección `0x00010000`.

## Archivos propios

- `sw/morse.S` — programa en ensamblador RISC-V
- `sw/main.c` — punto de entrada que invoca la rutina
- `CMakeLists.txt` — modificado para incluir archivos `.S` en el build

## Créditos

Desarrollado sobre [Femto_Risc-V_SoC](https://github.com/Sbustamantem/Femto_Risc-V_SoC)
de Santiago Bustamante (@Sbustamantem), que aporta el SoC completo
(núcleo FemtoRV32, BRAM, UART, periférico de LEDs), el toolchain de
código abierto y el sistema de compilación.

El núcleo RISC-V proviene de [FemtoRV](https://github.com/BrunoLevy/learn-fpga)
de Bruno Levy. Las herramientas de síntesis son de
[OSS CAD Suite](https://github.com/YosysHQ/oss-cad-suite-build) (YosysHQ).

## Compilar y cargar

```bash
cmake -B build -G Ninja
cmake --build build
sudo openFPGALoader -b tangprimer20k -m build/bitstream.fs
```
