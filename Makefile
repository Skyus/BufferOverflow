FLAGS = -fno-stack-protector -D_FORTIFY_SOURCE=0 -Wno-everything
CC_FLAGS = -Wl,-allow_stack_execute -Wl,-no_pie 

.PHONY: target attack assembly attack_assembly clean

target: target.c
	cc $(CC_FLAGS) $(FLAGS) target.c -o target

attack:
	cc $(FLAGS) -masm=intel -c attack.S -o attack.o

assembly:
	cc $(CC_FLAGS) $(FLAGS) -g target.c -o mix
	objdump -disassemble -source -x86-asm-syntax=intel -no-show-raw-insn mix > target.mix.c
	rm -f mix

attack_assembly:
	cc $(FLAGS) -masm=intel -c attack.S
	objdump -disassemble -x86-asm-syntax=intel attack.o

clean:
	rm -rf *.dSYM/
	rm -f *.mix.c
	rm -f *.o
	rm -f target_detector
	rm -f target
	rm -f mix