<?php
$address = 0;
$last_address = 65535;
while($address <= $last_address ){
    
    echo 
        $address.chr(9)."0x".str_pad(dechex($address),4,"0",STR_PAD_LEFT).chr(9).str_pad(decbin($address),16,"0",STR_PAD_LEFT).chr(9);
    switch($address){
        case 0:
            echo "0000 - 00ff = RAM [Zero Page]".chr(9); 
            // 0x0000 - 0x00ff = RAM [Zero Page]
            break;
        case ($address >= 0 and $address <= 255): 
            // 0x0000 - 0x00ff = RAM [Zero Page]
            echo "0000 - 00ff = RAM [Zero Page]".chr(9);
            break;

        case ($address >= 256 and $address <= 511):
            // 0x0100 - 0x01ff = RAM [Stack Pointer]
            echo "0100 - 01ff = RAM [Stack Pointer]".chr(9);
            break;    
        case ($address >= 512 and $address <= 16383):
            // 0x0200 - 0x3fff = RAM
            echo "0200 - 3fff = RAM".chr(9);
            break; 
        case ($address >= 16384 and $address <= 24575):  
            // 0x4000 - 0x5fff = Open Bus (Invalid Memory Addresses)
            echo "4000 - 5fff = Open Bus".chr(9);
            break;
        case 24576:
            echo "6000 = I/O Register B".chr(9);
            // 0x6000 = I/O Register B
            break;
        case 24577:
            echo "6001 = I/O Register A".chr(9);
            // 0x6001 = I/O Register A
            break;    
        case 24578:
            echo "6002 = T1 Low Order Latches/Counter".chr(9);
            // 0x6002 = Data Direction Register B
            break;
        case 24579:
            echo "6003 = T1 High Order Counter".chr(9);
            // 0x6003 = Data Direction Register A
            break;
        case 24580:
            echo "6004 = T1 Low Order Latches".chr(9);
            // 0x6004 = T1 Low Order Latches/Counter
            break;
        case 24581:
            echo "6005 = T1 High Order Counter".chr(9);
            // 0x6005 = T1 High Order Counter
            break;
        case 24582:
            echo "6006 = T1 Low Order Latches".chr(9);
            // 0x6006 = T1 Low Order Latches
            break;
        case 24583:
            echo "6007 = T1 High Order Latches".chr(9);
            // 0x6007 = T1 High Order Latches
            break;
        case 24584:
            echo "6008 = T2 Low Order Latches/Counter".chr(9);
            // 0x6008 = T2 Low Order Latches/Counter
            break;
        case 24585:
            echo "6009 = T2 High Order Counter".chr(9);
            // 0x6009 = T2 High Order Counter
            break;    
        case 24586:
            echo "600a = Shift Register".chr(9);
            // 0x600a = Shift Register
            break;
        case 24587:
            echo "600b = Auxiliary Control Register".chr(9);
            // 0x600b = Auxiliary Control Register
            break;
        case 24588:
            echo "600c = Peripheral Control Register".chr(9);
            // 0x600c = Peripheral Control Register
            break;
        case 24589:
            echo "600d = Interrupt Flag Register".chr(9);
            // 0x600d = Interrupt Flag Register
            break;
        case 24590:
            echo "600e = Interrupt Enable Register".chr(9);
            // 0x600e = Interrupt Enable Register
            break;
        case 24591:
            echo "600f = I/O Register A sans Handshake".chr(9);
            // 0x600f = I/O Register A sans Handshake
            break;
        case ($address >= 24592 and $address <= 32767):  
            // 0x6010 - 0x7fff - Mirrors of the sixteen VIA registers
            echo "6010 - 7fff - Mirrors of the sixteen VIA registers".chr(9);
            break;
        case ($address >= 32768 and $address <= 65529):  
            // 0x8000 - 0xfff9 = ROM
            echo "8000 - fff9 = ROM".chr(9);
            break;
        case ($address >= 65530 and $address <= 65531):  
            // 0xfffa - 0xfffb = ROM [NMI Vector]
            echo "fffa - fffb = ROM [NMI Vector]".chr(9);
            break;
        case ($address >= 65532 and $address <= 65533):  
            // 0xfffc - 0xfffd = ROM [Reset Vector]
            echo "fffc - fffd = ROM [Reset Vector]".chr(9);
            break;
        case ($address >= 65534 and $address <= 65535):  
            // 0xfffe - 0xffff = ROM [IRQ/BRK Vector]
            echo "fffe - ffff = ROM [IRQ/BRK Vector]".chr(9);
            break;
    }
    echo PHP_EOL;
    $address ++;
}
?>