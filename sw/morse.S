    .equ LED_BASE,  0x00010000
    .equ DOT_LEN,   1000000
    .equ DASH_LEN,  3000000

    .equ L_N, 0x06
    .equ L_I, 0x05
    .equ L_C, 0x66
    .equ L_O, 0x2A
    .equ L_L, 0x59
    .equ L_E, 0x01

    .section .text
    .globl morse_nicole

.macro LETTER pat, idx
    li   a0, \pat
    li   a1, \idx
    jal  ra, play_letter
.endm

morse_nicole:
    li   s0, LED_BASE

repetir:
    LETTER L_N, 1
    LETTER L_I, 2
    LETTER L_C, 3
    LETTER L_O, 4
    LETTER L_L, 5
    LETTER L_E, 6

    sw   zero, 0(s0)
    li   a2, DASH_LEN
    jal  t0, delay
    li   a2, DASH_LEN
    jal  t0, delay
    j    repetir

play_letter:
sym_loop:
    andi t1, a0, 3
    beqz t1, letter_done

    slli a3, a1, 1
    ori  a3, a3, 1
    sw   a3, 0(s0)

    li   a2, DOT_LEN
    li   t2, 1
    beq  t1, t2, es_punto
    li   a2, DASH_LEN
es_punto:
    jal  t0, delay

    slli a3, a1, 1
    sw   a3, 0(s0)
    li   a2, DOT_LEN
    jal  t0, delay

    srli a0, a0, 2
    j    sym_loop

letter_done:
    sw   zero, 0(s0)
    li   a2, DASH_LEN
    jal  t0, delay
    jr   ra

delay:
    addi a2, a2, -1
    bnez a2, delay
    jr   t0
