/* load_test.s */
.text
.global main

main:
    /* Example 1 */
    mov r1, #0x12
    mov r1, r1, LSL #8
    add r1, r1, #0x34
    
    /* Example 2 */
    mvn r2, #49
    
    /* Example 3 */
    mov r3, #0xFF
    mov r3, r3, LSL #16
    
    bx lr
