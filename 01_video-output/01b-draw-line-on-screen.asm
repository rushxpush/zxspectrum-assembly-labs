  DEVICE ZXSPECTRUM48

  org $8000

  jp start

video_memory = $4000

start:
  ld hl, video_memory 
  ld a, %111111
  ld (hl), a
  ret
  

  ;; Deployment Snapshot ;;
  SAVESNA "01b-draw-line-on-screen.sna", start