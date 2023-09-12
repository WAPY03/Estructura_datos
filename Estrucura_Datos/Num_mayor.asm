.data
numbers: .word 5, 8, 2, 12, 7, 6, 1, 9, 4, 3
max_number: .word 0

.text
.globl main

main:
    la $t0, numbers   # Carga la dirección de inicio de la lista en $t0
    lw $t1, max_number   # Carga la variable max_number en $t1

    loop:
        lw $t2, 0($t0)   # Carga el número actual en $t2
        ble $t2, $t1, not_larger   # Si el número no es mayor, salta a not_larger
        move $t1, $t2   # Actualiza el máximo si se encuentra un número mayor

        not_larger:
        addi $t0, $t0, 4   # Avanza al siguiente número
        bnez $t2, loop   # Si no hemos llegado al final de la lista, vuelve a loop

    # Al final, $t1 contendrá el número mayor
    # Imprime el mensaje y el número mayor
    li $v0, 4
    la $a0, max_msg
    syscall

    li $v0, 1
    move $a0, $t1
    syscall

    # Termina el programa
    li $v0, 10
    syscall

.data
max_msg: .asciiz "El numero mayor es: "

