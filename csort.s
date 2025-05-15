/* -- csort.s */
.text
.global main

main:
    @@@@@@@@@@@@@@@@@ INITIALIZE
    ldr r7, =return
    str lr, [r7]
    mov r6, #0
    ldr r4, =string

input:
    ldr r0, =prompt
    bl puts
    ldr r0, =scanFMT
    ldr r1, =char_read
    bl scanf
    ldr r1, =char_read
    ldrb r1, [r1]        @ Load byte (character)
    cmp r1, #0           @ Null terminator as sentinel
    beq sort_and_print
    add r0, r4, r6       @ No need to shift for bytes
    strb r1, [r0]        @ Store byte
    add r6, r6, #1
    b input

sort_and_print:
    @ Insertion sort (modified for characters)
    mov r2, #1           @ i = 1
i_loop:
    cmp r2, r6
    bge i_loop_end
    
    add r10, r4, r2
    ldrb r10, [r10]      @ temp = string[i]
    sub r3, r2, #1       @ j = i - 1
    
j_loop:
    cmp r3, #0
    blt j_loop_end
    add r9, r4, r3
    ldrb r9, [r9]        @ string[j]
    cmp r10, r9
    bge j_loop_end
    
    add r8, r4, r3
    add r8, r8, #1       @ &string[j+1]
    strb r9, [r8]        @ string[j+1] = string[j]
    sub r3, r3, #1       @ j--
    b j_loop
    
j_loop_end:
    add r3, r3, #1       @ j+1
    add r8, r4, r3
    strb r10, [r8]       @ string[j+1] = temp
    add r2, r2, #1       @ i++
    b i_loop
    
i_loop_end:
    @ Print sorted string
    ldr r0, =result
    bl puts
    mov r0, r4           @ String address
    bl puts
    
exit:
    ldr r1, =return
    ldr lr, [r1]
    bx lr

.data
char_read: .byte 0
string: .space 100
return: .word 0
prompt: .asciz "Input a character (enter for null terminator to quit): "
result: .asciz "Sorted string: "
scanFMT: .asciz "%c"

.global printf
.global scanf
.global puts
