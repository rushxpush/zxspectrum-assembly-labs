  DEVICE ZXSPECTRUM48

  org $8000

  jp start

video_memory = $4000

start:
  ld hl, video_memory 
  ld a, %00001
  ld (hl), a
  ret
  

  ;; Deployment Snapshot ;;
  SAVESNA "01a-draw-pixel-on-screen.sna", start