.data
numbers: .word 5,8,9,0,7,1,6,2,4
min_number_msg: .asciiz "El número menor es: "

.text
.globl main

main:
    la $t0, numbers   # Carga la dirección base de la lista en $t0
    lw $t1, ($t0)     # Carga el primer número en $t1 (asumimos que hay al menos un número)
    move $t2, $t1     # Inicializa $t2 con el valor actual mínimo

    loop:
        lw $t3, ($t0)  # Carga el número actual en $t3
        blt $t3, $t2, update_min  # Si el número es menor, salta a update_min

        update_min:
        move $t2, $t3  # Actualiza $t2 si encontramos un número menor

        addi $t0, $t0, 4  # Avanza al siguiente número
        bnez $t3, loop  # Si no hemos llegado al final de la lista, vuelve a loop

    # Imprime el mensaje y el número menor
    li $v0, 4
    la $a0, min_number_msg
    syscall

    li $v0, 1
    move $a0, $t2
    syscall

    # Termina el programa
    li $v0, 10
    syscall



