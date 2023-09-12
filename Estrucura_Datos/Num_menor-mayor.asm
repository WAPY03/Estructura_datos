.data
fibonacci_series: .space 90  # Espacio para almacenar los primeros 10 números de Fibonacci

.text
.globl main

main:
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

        # Actualiza los valores de a y b
        move $t0, $t1     # $t0 = $t1
        move $t1, $t3     # $t1 = $t3

        # Incrementa el índice
        addi $t2, $t2, 1

        # Comprueba si hemos alcanzado el límite de 10 elementos
        li $t9, 10
        bge $t2, $t9, print_results  # Sale del bucle si $t2 >= 10

        j loop  # Vuelve al inicio del bucle

    print_results:
        # Imprime los primeros 10 números de la serie de Fibonacci
        li $v0, 4
        la $a0, fibonacci_series
        li $a1, 80  # Imprimir los primeros 10 números (10 elementos * 4 bytes cada uno)
        syscall

        # Busca el número mayor y menor en la serie
        li $t5, 0  # $t5 = min_fibonacci
        li $t6, 0  # $t6 = max_fibonacci
        li $t2, 0  # Reinicia el índice

        find_min_max:
            lw $t7, ($t4)  # Carga el elemento actual de la serie

            # Compara con el mínimo actual
            blt $t7, $t5, update_min

            # Compara con el máximo actual
            bgt $t7, $t6, update_max

            j next_iteration

            update_min:
                move $t5, $t7
                j next_iteration

            update_max:
                move $t6, $t7

            next_iteration:
                addi $t2, $t2, 1
                addi $t4, $t4, 4
                bge $t2, $t9, print_min_max

                j find_min_max

        print_min_max:
            # Imprime el número menor y el número mayor
            li $v0, 4
            la $a0, min_max_msg
            syscall

            # Imprime el número menor
            li $v0, 1
            move $a0, $t5
            syscall

            # Imprime una coma y un espacio
            li $v0, 4
            la $a0, comma_space_msg
            syscall

            # Imprime el número mayor
            li $v0, 1
            move $a0, $t6
            syscall

            # Termina el programa
            li $v0, 10
            syscall

.data
min_max_msg: .asciiz "Número menor y mayor en la serie: "
comma_space_msg: .asciiz ", "

