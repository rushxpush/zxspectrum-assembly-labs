# 01-draw-pixel-on-screen

## Some questions:
- What is the command to blit **(what is blit?)** a pixel to screen? Does blit exists on zxspectrum?
- Where is the memory location that controls the pixels on the screen?
- How the (x,y) position works on the memory?

## Objetive:
I want to draw a pixel on the screen **without following a tutorial**. My goal understand how the zxspectrum hardware handles pixel drawing at the lowest level.

## Steps/TODO:
- ✅ **Find where the video memory starts. Response: ($4000)**
- ✅ **Experiment some different byte values on $4000**
- ✅ **Draw pixel on screen**
- ✅ **Draw line on screen**
- ✅ **Draw block on screen**

## Notes
I used chat gpt to recomend me some material regarding the ZXSpectrum video memory layout: [ZXSpectrum Video Memory Layout](http://www.breakintoprogram.co.uk/hardware/computers/zx-spectrum/screen-memory-layout)

## Outcome
Originally, this nanolab was meant to draw a pixel.
But I naturally extended it to draw a full horizontal line and then a block

## Devlog

### 📅 2025-07-24
- First thing I decided not to search for a tutorial on how to draw a pixel on screen. Hardcore baby!
- The first step is to find where the ZXSpectrum memory map starts
- I used chat gpt to recomend me some material regarding the ZXSpectrum video memory layout
It gave me this: [ZXSpectrum Video Memory Layout](http://www.breakintoprogram.co.uk/hardware/computers/zx-spectrum/screen-memory-layout)
- Confirmed that screen memory map starts at location $4000.
- I wrote `%000000001` to `$4000`. Got a pixel on screen. Good start!
- I wrote `%11111111` to `$4000` then. A full line is shown. Interesting!
- So, probably every address on the screen memory controls eight pixels horizontally. 
- Does the same idea hold vertically? Let's test.
- I wrote `%11111111` to `$4001`. It didn't draw the line under the other one. The memory map is probably unconventional.
- I wrote `%11111111` to some locations between `$4001`and `$4020`. `$401f`prints the line at the right side of the screen
- I then wrote `%11111111` to `$4020` and it didn't draw the line under the line at `$4000`, I has drawn some pixels under it! How curious!
- I wrote `%11111111`to `$4100`and now it worked!. The second line is one pixel under the first line.
- So I just have to write a loop from `$4000` to `$4700` and the block will be drawn on screen. 
- I don't remember how to do a loop though. Let me think first.
- I noticed that the code starts at `#8000` with a `JP #8003`. I figured it's because `JP` takes 3 bytes (I looked on SpecEmu debugger), so the actual program starts at `#8003`. Good to remember!

- Then I was wondering about my `video_memory_1`, `video_memory_2`, etc:
```asm
video_memory_1 = $4000
video_memory_2 = $4100
video_memory_3 = $4200
# etc...
```

- they don’t show up in the debugger, only addresses like `$4000`, `$4100`… I realized those labels are just symbols the assembler replaces with real addresses. They're not actual data in memory. 
- At that point, analyzing the adresses it hit me: I can load `$4000` into `HL`, then increment `H` to go through $4100, $4200… up to $4700. Using `B` as a counter from 8 down to 0, with `DJNZ`, I get a clean loop! Now I remember! I studied this sometime last month, so the memory is returning...
- The block is now printed on screen. Next lab, I'll move the pixel, then the line, then the block.

## Signature
// Field notes by Rafael Garcia - rushxpush

// ReverseOps.Z80

// ZX Spectrum Microlab · Sector: Video Memory I/O

// Memory range: $4000-$47FF | Lab temp: 10ºC

// Timestamp: [2025-07-24 | UTC-3]

// Performed on: sjasmplus + SpecEmu

// Purpose: Mapping video RAM through manual byte injection