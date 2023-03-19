
# 6502

This is my Ben Eater (https://eater.net/6502) inspired 6502 breadboard project.  This is a hobby project, my interests are learning how the 65c02 hardware works and learning some assembly programming.

Some of my divergences from the BE6502 project to date include:
* Clock speed 3Mhz.
* 4-Bit mode for the 1602A LCD Module.
* Using W65C22 T1 timer to add delay for LCD module setup time.

---
Abbreviated Memory Map

    Decimal     Hex     Binary                      Desc
    0           0x0000	0000000000000000        0000 - 00ff = RAM [Zero Page]
    ..	        ..	    ..	                ..
    255         0x00ff	0000000011111111	0000 - 00ff = RAM [Zero Page]
    256         0x0100	0000000100000000	0100 - 01ff = RAM [Stack Pointer]
    ..	        ..	    ..	                ..
    511         0x01ff	0000000111111111	0100 - 01ff = RAM [Stack Pointer]
    512         0x0200	0000001000000000	0200 - 3fff = RAM
    ..	        ..	    ..	                ..
    16383	    0x3fff	0011111111111111	0200 - 3fff = RAM
    16384	    0x4000	0100000000000000	4000 - 5fff = Open Bus
    ..	        ..	    ..	                ..
    24575	    0x5fff	0101111111111111	4000 - 5fff = Open Bus
    24576	    0x6000	0110000000000000	6000 = I/O Register B
    24577	    0x6001	0110000000000001	6001 = I/O Register A
    24578	    0x6002	0110000000000010	6002 = T1 Low Order Latches/Counter
    24579	    0x6003	0110000000000011	6003 = T1 High Order Counter
    24580	    0x6004	0110000000000100	6004 = T1 Low Order Latches
    24581	    0x6005	0110000000000101	6005 = T1 High Order Counter
    24582	    0x6006	0110000000000110	6006 = T1 Low Order Latches
    24583	    0x6007	0110000000000111	6007 = T1 High Order Latches
    24584	    0x6008	0110000000001000	6008 = T2 Low Order Latches/Counter
    24585	    0x6009	0110000000001001	6009 = T2 High Order Counter
    24586	    0x600a	0110000000001010	600a = Shift Register
    24587	    0x600b	0110000000001011	600b = Auxiliary Control Register
    24588	    0x600c	0110000000001100	600c = Peripheral Control Register
    24589	    0x600d	0110000000001101	600d = Interrupt Flag Register
    24590	    0x600e	0110000000001110	600e = Interrupt Enable Register
    24591	    0x600f	0110000000001111	600f = I/O Register A sans Handshake
    24592	    0x6010	0110000000010000	6010 - 7fff - Mirrors of the sixteen VIA registers
    ..	        ..	    ..	                ..
    32767	    0x7fff	0111111111111111	6010 - 7fff - Mirrors of the sixteen VIA registers
    32768	    0x8000	1000000000000000	8000 - fff9 = ROM
    ..	        ..	    ..	                ..
    65529	    0xfff9	1111111111111000	8000 - fff9 = ROM
    65530	    0xfffa	1111111111111010	fffa - fffb = ROM [NMI Vector]
    65531	    0xfffb	1111111111111010	fffa - fffb = ROM [NMI Vector]
    65532       0xfffc	1111111111111100	fffc - fffd = ROM [Reset Vector]
    65533	    0xfffd	1111111111111100	fffc - fffd = ROM [Reset Vector]
    65534	    0xfffe	1111111111111110	fffe - ffff = ROM [IRQ/BRK Vector]
    65535	    0xffff	1111111111111110	fffe - ffff = ROM [IRQ/BRK Vector]
