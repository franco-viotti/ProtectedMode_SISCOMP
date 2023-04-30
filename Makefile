make:
	nasm -f bin protected_mode.asm -o protected_mode.img
	qemu-system-x86_64 -hda protected_mode.img
clean:
	rm *.img

