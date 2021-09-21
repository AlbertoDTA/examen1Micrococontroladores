#include "p16F628a.inc" ;incluir librerias relacionadas con el dispositivo
__CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF
;configuración del dispositivotodo en OFF y la frecuencia de oscilador
;es la del "reloj del oscilador interno" (INTOSCCLK)
RES_VECT CODE 0x0000 ; processor reset vector
GOTO START ; go to beginning of program
; TODO ADD INTERRUPTS HERE IF USED
MAIN_PROG CODE ; let linker place main program
;variables para el contador:
i equ 0x30
j equ 0x31
k equ 0x32
m equ 0x33

w equ 0x34
x equ 0x35
y equ 0x36
z equ 0x37
;inicio del programa:
START
MOVLW 0x07 ;Apagar comparadores
MOVWF CMCON
BCF STATUS, RP1 ;Cambiar al banco 1
BSF STATUS, RP0
CLRF PORTB
MOVLW b'00000000' ;Establecer puerto B como salida (los 8 bits del puerto)
MOVWF TRISB
BCF STATUS, RP0 ;Regresar al banco 0

INICIO
inicio:
CLRw PORTB
bcf PORTB,0 ;poner el puerto B0 (bit 0 del puerto B) en 0
;ESTADO 1: ALTO: 457 ms
    call tiempoA ;llamar a la rutina de tiempo
     nop;NOPs de relleno (ajuste de tiempo
     nop
    MOVLW b'11000111'
    MOVWF w
    MOVFW w
    MOVWF PORTB
;ESTADO 2: BAJO: 543 ms
    call tiempoB ;llamar a la rutina de tiempo
    nop ;NOPs de relleno (ajuste de tiempo
    nop
    nop
    CLRW PORTB
    MOVLW b'11111000'
    MOVWF m
    MOVFW m
    MOVWF PORTB
;NOPs de relleno (ajuste de tiempo)
goto inicio ;regresar y repetir
  
;rutina de tiempo
tiempoA:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
movlw d'138' ;establecer valor de la variable k
movwf m
mloop:
decfsz m,f
goto mloop
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
movlw d'43' ;establecer valor de la variable i
movwf i
iloop:
;NOPs de relleno (ajuste de tiempo)
movlw d'87' ;establecer valor de la variable j
movwf j
jloop:
nop ;NOPs de relleno (ajuste de tiempo)
movlw d'39' ;establecer valor de la variable k
movwf k
kloop:
decfsz k,f
goto kloop
decfsz j,f
goto jloop
decfsz i,f
goto iloop
return ;salir de la rutina de tiempo y regresar al
;valor de contador de programa
    
    
;rutina de tiempo
tiempoB:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
movlw d'46' ;establecer valor de la variable k
movwf w  
wloop:
decfsz w,f  
goto wloop
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
movlw d'51' ;establecer valor de la variable i
movwf x
xloop:
;NOPs de relleno (ajuste de tiempo)
movlw d'76' ;establecer valor de la variable j
movwf y
yloop:
nop ;NOPs de relleno (ajuste de tiempo)
movlw d'45' ;establecer valor de la variable k
movwf z
zloop:
decfsz z,f
goto zloop
decfsz y,f
goto yloop
decfsz x,f
goto xloop
return ;salir de la rutina de tiempo y regresar al
;valor de contador de programa
END