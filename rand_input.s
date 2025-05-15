/* -- rand_input.s */
.text
.global main

main:
    ldr r1, =return
    str lr, [r1]
    
    @ Get seed from user
    ldr r0, =seed_prompt
    bl printf
    ldr r0, =scanFMT
    ldr r1, =seed
    bl scanf
    ldr r0, [r1]        @ Load seed
    
    mov r4, #0x7e
    mov r4, r4, LSL #8
    add r4, r4, #0xbd   @ a = 32445
    
    mov r5, #0xFF
    mov r5, r5, LSL #8
    add r5, r5, #0xFF   @ mask = 0xFFFF
    
    mov r6, #100        @ counter for 100 numbers
    
Loop:
    mul r0, r0, r4      @ X = a*X
    add r0, r0, #1      @ X = a*X + c
    and r0, r0, r5      @ X mod m
    
    @ Print the number
    ldr r1, =number
    str r0, [r1]
    ldr r0, =printFMT
    ldr r1, =number
    ldr r1, [r1]
    bl printf
    
    subs r6, r6, #1     @ decrement counter
    bne Loop
    
Exit:
    ldr lr, =return
    ldr lr, [lr]
    bx lr

.data
seed: .word 0
number: .word 0
return: .word 0
seed_prompt: .asciz "Enter seed value: "
scanFMT: .asciz "%d"
printFMT: .asciz "%d\n"

.global printf
.global scanf
