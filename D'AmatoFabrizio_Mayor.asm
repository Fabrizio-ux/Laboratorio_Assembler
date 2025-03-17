.data
    mensajeCantidad: .asciiz "Ingrese la cantidad de números (3 a 5): "
    mensajeNumero: .asciiz "Ingrese un número: "
    resultadoMayor: .asciiz "El número mayor es: "
    saltoLinea: .asciiz "\n"

.text
.globl main

main:
    # Pedir la cantidad de números
    li $v0, 4
    la $a0, mensajeCantidad
    syscall

    # Leer la cantidad
    li $v0, 5
    syscall
    move $t0, $v0   # Guardamos la cantidad en $t0

    # Validar que esté entre 3 y 5
    li $t1, 3       # Límite inferior
    li $t2, 5       # Límite superior
    blt $t0, $t1, main  # Si es menor a 3, pedir de nuevo
    bgt $t0, $t2, main  # Si es mayor a 5, pedir de nuevo

    # Ingresar los números
    li $t3, 0  # Contador
    li $t4, -2147483648  # Variable para el número mayor (mínimo posible en 32 bits)

loop:
    beq $t3, $t0, fin  # Si ya ingresamos la cantidad necesaria, salir

    # Pedir un número
    li $v0, 4
    la $a0, mensajeNumero
    syscall

    # Leer el número
    li $v0, 5
    syscall
    move $t5, $v0  # Guardar número en $t5

    # Comparar con el mayor actual
    ble $t5, $t4, continuar
    move $t4, $t5  # Si es mayor, actualizar

continuar:
    addi $t3, $t3, 1  # Incrementar contador
    j loop

fin:
    # Mostrar el número mayor
    li $v0, 4
    la $a0, resultadoMayor
    syscall

    li $v0, 1
    move $a0, $t4
    syscall

    # Salto de línea
    li $v0, 4
    la $a0, saltoLinea
    syscall

    # Salir del programa
    li $v0, 10
    syscall
