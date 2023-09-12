.data
fibonacci_series: .space 40  # Espacio para almacenar los primeros 10 números de Fibonacci
message: .asciiz "Los primeros 10 números de Fibonacci son: "

.text
.globl main

main:
    # Imprime un mensaje antes de la serie de Fibonacci
    li $v0, 4
    la $a0, message
    syscall

    # Inicializa los primeros dos números de la serie de Fibonacci
    li $t0, 0  # $t0 = a
    li $t1, 1  # $t1 = b

    # Inicializa el índice del siguiente número en la serie
    li $t2, 0  # $t2 = índice

    # Inicializa la dirección base para la serie de Fibonacci
    la $t4, fibonacci_series

    # Entra en el bucle para calcular la serie de Fibonacci
    loop:
        # Calcula el siguiente número en la serie
        add $t3, $t0, $t1  # $t3 = $t0 + $t1

        # Calcula la dirección de memoria para almacenar el siguiente número
        mul $t5, $t2, 4  # $t5 = $t2 * 4
        add $t6, $t4, $t5  # $t6 = $t4 + $t5

        # Almacena el siguiente número en la serie
        sw $t3, ($t6)

        # Imprime el número calculado
        li $v0, 1
        move $a0, $t3
        syscall

        # Actualiza los valores de a y b
        move $t0, $t1     # $t0 = $t1
        move $t1, $t3     # $t1 = $t3

        # Incrementa el índice
        addi $t2, $t2, 1

        # Comprueba si hemos alcanzado el límite de 10 elementos
        li $t9, 10
        bge $t2, $t9, end_program  # Sal del bucle si $t2 >= 10

        j loop  # Vuelve al inicio del bucle

    end_program:
    # Termina el programa
    li $v0, 10
    syscall
