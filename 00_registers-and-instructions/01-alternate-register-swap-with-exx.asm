  DEVICE ZXSPECTRUM48

  ;; Alternate Register Swap with exx Opcode ;;

  org $8000 ; defines the starting address of the program
  
  jp start  ; jumps over data definitions to actual code entry point

value_A:
  db "A" ; byte data: character "A" 
value_B:
  db "B" ; byte data: character "B"
value_C:
  db "C" ; byte data: character "C"

value_1:
  db "1" ; byte data: character "1"
value_2:
  db "2" ; byte data: character "2"
value_3:
  db "3" ; byte data: character "3"

start:
  ;; set registers ;;
  ld bc, value_A ; load value_A
  ld de, value_B ; load value_B
  ld hl, value_C ; load value_C
  
  exx ; exchange bc, de, hl values for bc', de' and hl' values

  ;; set registers again ;;
  ld bc, value_1 ; load value_1
  ld de, value_2 ; load value_2
  ld hl, value_3 ; load value_3
  
  exx ; exchange bc, de, hl for bc', de' and hl' values one more time

  ;; check the code with a debugger. The registers should be as follow: ;;
  ;; bc: $8003  | bc': $8006 ;;
  ;; de: $8004  | de': $8007 ;;
  ;; hl: $8005  | hl': $8008 ;;

  ret ; End of program
  
  ;; Deployment: Snapshot ;;
  SAVESNA "01-alternate-register-swap-with-exx.sna", start