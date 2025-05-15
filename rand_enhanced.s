/* -- rand_enhanced.s */
.text
.global main

main:
    ldr r7, =return
    str lr, [r7]
    
    @ Get parameters from user
    ldr r0, =seed_prompt
    bl printf
    ldr r0, =scanFMT
    ldr r1, =seed
    bl scanf
    
    ldr r0, =count_prompt
    bl printf
    ldr r0, =scanFMT
    ldr r1, =count
    bl scanf
    
    ldr r0, =range_prompt
    bl printf
    ldr r0, =scanFMT
    ldr r1, =range
    bl scanf
    
    @ Initialize
    ldr r0, [r1]        @ range
    ldr r6, =count
    ldr r6, [r6]        @ count
    ldr r4, =seed
    ldr r4, [r4]        @ seed
    
    mov r5, #0x7e
    mov r5, r5, LSL #8
    add r5, r5, #0xbd   @ a = 32445
    
    mov r8, #0xFF
    mov r8, r8, LSL #8
    add r8, r8, #0xFF   @ mask = 0xFFFF
    
Loop:
    mul r4, r4, r5      @ X = a*X
    add r4, r4, #1      @ X = a*X + c
    and r4, r4, r8      @ X mod m
    
    @ Scale to desired range
    udiv r9, r4, r8     @ r9 = X / MAX
    mul r9, r9, r0      @ r9 = (X / MAX) * range
    mov r9, r9, LSR #16 @ Adjust for fixed-point
    
    @ Print the number
    ldr r1, =number
    str r9, [r1]
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
count: .word 0
range: .word 0
number: .word 0
return: .word 0
seed_prompt: .asciz "Enter seed value: "
count_prompt: .asciz "Enter number of values to generate: "
range_prompt: .asciz "Enter maximum value (exclusive): "
scanFMT: .asciz "%d"
printFMT: .asciz "%d\n"

.global printf
.global scanf
