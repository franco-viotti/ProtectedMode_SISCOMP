; start at 16 bits
bits 16
org 0x7c00

start:
    ; enable A20 bit
    mov ax, 0x2401
    int 0x15

    ; set vga to be normal mode
    mov ax, 0x3
    int 0x10

    cli                             ; disable interrupts
    lgdt [gdt_pointer]              ; load GDT

    mov eax, cr0                    ; change last CR0 to 1
    or eax,0x1
    mov cr0, eax
    jmp CODE_SEG:protected_mode

; source: https://github.com/cirosantilli/x86-bare-metal-examples/blob/master/common.h#L135
gdt_start:
    dq 0x0
gdt_code:
    dw 0xffff ; limit
    dw 0x0  ; base (16 bits)
    db 0x0  ; base (8 bits) : (16 + 8 = 24 bits)
    db 0b10011010   ; pres, priv, type, type flags, other flags
    db 0b11001111   ; other flags, limit (last 4 bits, 20 in total)
    db 0x0  ; last 8 bits from base (32 bits)
gdt_data:
    dw 0xFFFF
    dw 0x0
    db 0x0
    db 10010010b
    db 11001111b
    db 0x0
gdt_end:
gdt_pointer:
    dw gdt_end - gdt_start-1    ; size
    dd gdt_start                ; pointer to start of GDT

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

bits 32

protected_mode:
    ; DATA_SEG relative offset of GDT
    mov ax, DATA_SEG
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov esi,msg   ; loads message
    mov ebx,0xb8000 ; writing directly into videoMemory (starts at 0xB8000)

.loop:
    lodsb                           ; loads string from [DS:SI] to AL
    or al,al
    jz halt
    or eax,0x0F00                   ; color = white
    mov word [ebx], ax
    add ebx,2                       ; increase ebx by two bytes (1byte color, 1byte ASCII)
    jmp .loop
halt:
    cli
    hlt
msg: db "Hello. You are now in protected mode!",0

times 510 - ($-$$) db 0
dw 0xaa55