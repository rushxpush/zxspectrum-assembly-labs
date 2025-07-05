  DEVICE ZXSPECTRUM48

  ;; Register Swap With ex Opcode ;;
  
  org $8000 ; defines the starting address of the program

  jp start  ; jumps over data definitions to actual code entry point

  ;; inserts a byte of data into the program ;;
value_A: 
  db "A"    ; byte data: character A

  ;; another byte of data inserted into the program ;;
value_B: 
  db "B"    ; byte data: character B

start:
  ;; load values to the de and hl registers ;;
  ld de, value_A    ; load value_A address
  ld hl, value_B    ; load value_B address

  ;; print values to screen: AB ;;
  ld a, (de)        ; load value_A
  rst $10           ; print value_A to screen
  ld a, (hl)        ; load value B
  rst $10           ; print value_B to screen

  ;; exchange values from the de register to the hl register and vice-versa ;;
  ex de, hl 

  ; print values to screen: BA
  ld a, (de)        ; load value_B
  rst $10           ; print value_B to screen
  ld a, (hl)        ; load value_A
  rst $10           ; print value_A to screen

  ;; The screen should have the following characters printed: ;;
  ;; ABBA                                                     ;;
  ret

  ;; Deployment: Snapshot ;;
  SAVESNA "01-register-swap-with-ex.sna", start