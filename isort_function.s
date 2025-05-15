/* -- isort_function.s */
.text
.global main
.global insertion_sort

main:
    @@@@@@@@@@@@@@@@@ INITIALIZE
    ldr r7, =return
    str lr, [r7]
    mov r6, #0
    ldr r4, =array

input:
    ldr r0, =prompt
    bl puts
    ldr r0, =scanFMT
    ldr r1, =number
    bl scanf
    ldr r1, =number
    ldr r1, [r1]
    cmp r1, #0
    blt sort_and_print
    add r0, r4, r6, LSL #2
    str r1, [r0]
    add r6, r6, #1
    b input

sort_and_print:
    @ Call insertion sort function
    mov r0, r4        @ array address
    mov r1, r6        @ array length
    bl insertion_sort
    
    @ Print results
    ldr r0, =result
    bl puts
    mov r5, #0

print_loop:
    cmp r6, r5
    ble exit
    add r3, r4, r5, LSL #2
    ldr r1, [r3]
    ldr r0, =printFMT
    bl printf
    add r5, r5, #1
    b print_loop

exit:
    mov r0, r6
    ldr r1, =return
    ldr lr, [r1]
    bx lr

@ Insertion sort function
@ Parameters:
@   r0 - array address
@   r1 - array length
insertion_sort:
    push {r4-r10, lr}    @ Save registers
    
    mov r4, r0           @ r4 = array address
    mov r5, r1           @ r5 = array length
    
    mov r2, #1           @ i = 1
i_loop:
    cmp r2, r5
    bge i_loop_end
    
    add r10, r4, r2, LSL #2
    ldr r10, [r10]       @ temp = array[i]
    sub r3, r2, #1       @ j = i - 1
    
j_loop:
    cmp r3, #0
    blt j_loop_end
    add r9, r4, r3, LSL #2
    ldr r9, [r9]         @ array[j]
    cmp r10, r9
    bge j_loop_end
    
    add r8, r4, r3, LSL #2
    add r8, r8, #4       @ &array[j+1]
    str r9, [r8]         @ array[j+1] = array[j]
    sub r3, r3, #1       @ j--
    b j_loop
    
j_loop_end:
    add r3, r3, #1       @ j+1
    add r8, r4, r3, LSL #2
    str r10, [r8]        @ array[j+1] = temp
    add r2, r2, #1       @ i++
    b i_loop
    
i_loop_end:
    pop {r4-r10, pc}     @ Restore registers and return

.data
number: .word 0
array: .space 100
return: .word 0
prompt: .asciz "Input a positive integer (negative to quit): "
result: .asciz "Sorted, those integers are: \n"
scanFMT: .asciz "%d"
printFMT: .asciz " %d\n"

.global printf
.global scanf
.global puts
