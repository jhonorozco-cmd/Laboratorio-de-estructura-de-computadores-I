# Laboratorio: Estructura de Computadores
# Actividad: Optimización de Pipeline en Procesadores MIPS
# Objetivo: Calcular Y[i] = A * X[i] + B

.data
    vector_x: .word 1, 2, 3, 4, 5, 6, 7, 8
    vector_y: .space 32          # Espacio para 8 enteros (8 * 4 bytes)
    const_a:  .word 3
    const_b:  .word 5
    tamano:   .word 8

.text
.globl main

main:
    # --- Inicialización ---
    la   $s0, vector_x     # Puntero a X
    la   $s1, vector_y     # Puntero a Y
    lw   $t0, const_a      # Constante A
    lw   $t1, const_b      # Constante B
    lw   $t2, tamano       # Tamaño del vector
    li   $t3, 0            # i = 0

loop:
    beq  $t3, $t2, fin     # Si i == tamaño, salir

    lw   $t6, 0($s0)       # X[i]
    mul  $t7, $t6, $t0     # X[i] * A
    addu $t8, $t7, $t1     # + B
    sw   $t8, 0($s1)       # Guardar en Y[i]

    addi $s0, $s0, 4       # Avanzar puntero X
    addi $s1, $s1, 4       # Avanzar puntero Y
    addi $t3, $t3, 1       # i++
    j    loop

fin:
    li   $v0, 10           # Syscall: terminar
    syscall
