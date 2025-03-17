.data
    prompt: .asciiz "Cuantos numeros de la serie Fibonacci desea generar? "
    result: .asciiz "Los numeros de Fibonacci son: "
    sum_msg: .asciiz "La suma es: "
    newline: .asciiz "\n"   # Cadena para salto de línea  

.text
    main:
        # Pedir la cantidad de números de Fibonacci
        li $v0, 4
        la $a0, prompt
        syscall

        li $v0, 5
        syscall
        move $t0, $v0      # Guardar la cantidad en $t0

        # Inicializar los primeros dos términos
        li $t1, 0          # t1 = 0
        li $t2, 1          # t2 = 1
        li $t3, 0          # t3 = suma acumulada

        # Mostrar la serie Fibonacci
        li $v0, 4
        la $a0, result
        syscall

    fibonacci_loop:
        # Mostrar el número
        li $v0, 1
        move $a0, $t1
        syscall
        
        # Imprimir salto de línea
        li $v0, 4
        la $a0, newline
        syscall

        # Sumar al acumulado
        add $t3, $t3, $t1

        # Calcular el siguiente término
        add $t4, $t1, $t2  # t4 = t1 + t2
        move $t1, $t2      # t1 = t2
        move $t2, $t4      # t2 = t4

        # Decrementar el contador
        sub $t0, $t0, 1
        bgtz $t0, fibonacci_loop

        # Imprimir la suma
        li $v0, 4
        la $a0, sum_msg
        syscall
        li $v0, 1
        move $a0, $t3
        syscall

        # Imprimir salto de línea
        li $v0, 4
        la $a0, newline
        syscall

        # Fin del programa
        li $v0, 10
        syscall
