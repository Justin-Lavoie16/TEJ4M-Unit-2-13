/* -- rand.s - corrected version */
.text
.global main

main:
    ldr r1, =return
    str lr, [r1]
    
    mov r6, #10        @ Generate 10 numbers
    ldr r0, =seed      @ Load seed address
    ldr r0, [r0]       @ Load seed value
    
loop:
    ldr r4, =multiplier
    ldr r4, [r4]       @ Load multiplier
    mov r5, r0         @ Copy seed to temp register
    mul r0, r5, r4     @ Multiply (now with different registers)
    add r0, r0, #1     @ Increment
    
    @ Print the number
    ldr r1, =number
    str r0, [r1]
    ldr r0, =format
    ldr r1, =number
    ldr r1, [r1]
    bl printf
    
    subs r6, r6, #1
    bne loop
    
    ldr lr, =return
    ldr lr, [lr]
    bx lr

.data
seed: .word 31416
multiplier: .word 32445
number: .word 0
return: .word 0
format: .asciz "%d\n"

.global printf
