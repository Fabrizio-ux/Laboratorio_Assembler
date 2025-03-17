.data
    mensajeCantidad: .asciiz "Ingrese la cantidad de n�meros (3 a 5): "
    mensajeNumero: .asciiz "Ingrese un n�mero: "
    resultadoMenor: .asciiz "El n�mero menor es: "
    saltoLinea: .asciiz "\n"

.text
.globl main

main:
    # Pedir la cantidad de n�meros
    li $v0, 4
    la $a0, mensajeCantidad
    syscall

    # Leer la cantidad
    li $v0, 5
    syscall
    move $t0, $v0

    # Validar que est� entre 3 y 5
    li $t1, 3
    li $t2, 5
    blt $t0, $t1, main
    bgt $t0, $t2, main

    # Ingresar los n�meros
    li $t3, 0
    li $t4, 2147483647  # Variable para el n�mero menor (m�ximo posible en 32 bits)

loop:
    beq $t3, $t0, fin  # Si ya ingresamos la cantidad necesaria, salir

    # Pedir un n�mero
    li $v0, 4
    la $a0, mensajeNumero
    syscall

    # Leer el n�mero
    li $v0, 5
    syscall
    move $t5, $v0

    # Comparar con el menor actual
    bge $t5, $t4, continuar
    move $t4, $t5  # Si es menor, actualizar

continuar:
    addi $t3, $t3, 1
    j loop

fin:
    # Mostrar el n�mero menor
    li $v0, 4
    la $a0, resultadoMenor
    syscall

    li $v0, 1
    move $a0, $t4
    syscall

    # Salto de l�nea
    li $v0, 4
    la $a0, saltoLinea
    syscall

    # Salir del programa
    li $v0, 10
    syscall
