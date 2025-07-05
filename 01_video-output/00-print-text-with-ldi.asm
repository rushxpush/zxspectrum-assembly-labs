  DEVICE ZXSPECTRUM48

  ;; Print Hello Word to Screen using LDI ;;

  org $8000 ; defines the starting address of the program

  jp start  ; jumps over data definitions to actual code entry point

text:
  db "Hello World!"      ; byte data: "H"
TEXT_LENGTH = $ - text   ; Text length = current memory location - start of byte data memory location == 12

start:
  ld hl, text            ; load text memory location
  ld bc, TEXT_LENGTH     ; load 13

loop:
  ld a, (hl)    ; load current value on the memory location pointed by hl
  rst $10       ; print character on screen
  ldi           ; performs:
                ; ld (de), (hl)
                ; inc de
                ; inc hl
                ; dec bc
  ld a, c       ; load decremented c value
  cp $00        ; subtract from $00 from a without updating a
  jr nz, loop   ; jump relative to loop if z is not set
  ret           ; end program
  
  ;; Deployment: Snapshot ;;
  SAVESNA "00-print-text-with-ldi.sna", start