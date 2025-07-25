  DEVICE ZXSPECTRUM48

  org $8000

  jp start

video_memory = $4000
line = %11111111

start:
  ld a, line 
  ld b, 7

loop:
  ld hl, video_memory
  ld (hl), a
  inc h
  dec b
  djnz loop

  ret
  

  ;; Deployment Snapshot ;;
  SAVESNA "01c-draw-block-on-screen.sna", start