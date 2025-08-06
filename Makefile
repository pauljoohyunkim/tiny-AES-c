#CC           = avr-gcc
#CFLAGS       = -Wall -mmcu=atmega16 -Os -Wl,-Map,test.map
#OBJCOPY      = avr-objcopy
CC           = gcc
PPCGCC		 = C:\SPC5Studio-6.0\eclipse\plugins\com.st.tools.spc5.tools.gnu.gcc.ppcvle.win32_4.9.4.20200908161514\toolchain\bin\ppc-freevle-eabi-gcc.exe
LD           = gcc
AR           = ar
ARFLAGS      = rcs
CFLAGS       = -Wall -Os -c
LDFLAGS      = -Wall -Os -Wl,-Map,test.map

OBJCOPYFLAGS = -j .text -O ihex
OBJCOPY      = objcopy

# include path to AVR library
INCLUDE_PATH = /usr/lib/avr/include
# splint static check
SPLINT       = splint test.c aes.c -I$(INCLUDE_PATH) +charindex -unrecog

default: aes.o

.SILENT:
.PHONY:  lint clean

test.hex : test.elf
	echo copy object-code to new image and format in hex
	$(OBJCOPY) ${OBJCOPYFLAGS} $< $@

test.o : test.c aes.h aes.o
	echo [CC] $@ $(CFLAGS)
	$(CC) $(CFLAGS) -o  $@ $<

aes.o : aes.c aes.h
	echo [CC] $@ $(CFLAGS)
	$(CC) $(CFLAGS) -o $@ $<
	size $@

# SBOX is now not hardcoded, but computed.
# CSBOX: Computing SBOX
aes.csbox.o : aes.c aes.h
	echo [CC] $@ $(CFLAGS) OHMYGOD-EDITION
	$(CC) $(CFLAGS) -DSBOXCOMPUTE=1 -o $@ $<
	size $@

aes.spc5.o: aes.c aes.h
	$(PPCGCC) -Wall -Os -c aes.c -o $@
	size $@

aes.spc5.csbox.o: aes.c aes.h
	$(PPCGCC) -Wall -Os -DSBOXCOMPUTE=1 -c aes.c -o $@
	size $@

test.elf : aes.o test.o
	echo [LD] $@
	$(LD) $(LDFLAGS) -o $@ $^

aes.a : aes.o
	echo [AR] $@
	$(AR) $(ARFLAGS) $@ $^

aes.csbox.a: aes.csbox.o
	echo [AR] $@
	$(AR) $(ARFLAGS) $@ $^

lib : aes.a

debug: clean test.elf
	echo [DEBUG] $>
	$(CC) -g -Wall aes.c test.c -o test.elf

clean:
	rm -f *.OBJ *.LST *.o *.gch *.out *.hex *.map *.elf *.a

test: test.elf
	make test.elf && ./test.elf
#	make clean && make AES192=1 && ./test.elf
#	make clean && make AES256=1 && ./test.elf

lint:
	$(call SPLINT)
