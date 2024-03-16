[bits 16]
[org 0x7C00]

; stack
mov bp, 0x0500
mov sp, bp

; save boot ID
mov byte[boot_drive], dl

; print msg
mov bx, msg
call print_str

; load second sector
mov bx, 0x0002
mov cx, 0x0001

; store new sector
mov dx, 0x7E00

; load new sectors
call load_bios

mov bx, loaded_msg
call print_str

%include "src/real_mode/print.asm"
%include "src/real_mode/load.asm"
%include "src/real_mode/gdt.asm"

msg:  db `\r\nHello\r\n`, 0
boot_drive: db 0x00

boot_hold:
    jmp $

; Pad boot sector for magic number
times 510 - ($ - $$) db 0x00

; Magic number
dw 0xAA55

bootsector_extended:

    loaded_msg: db `\r\nNow reading from the next sector!`, 0
    
    ; Fill with zeros to the end of the sector
    times 512 - ($ - bootsector_extended) db 0x00
bu: