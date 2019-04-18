PYTHON := python
MD5 := md5sum -c --quiet

2bpp     := $(PYTHON) extras/pokemontools/gfx.py 2bpp
1bpp     := $(PYTHON) extras/pokemontools/gfx.py 1bpp
pic      := $(PYTHON) extras/pokemontools/pic.py compress
includes := $(PYTHON) extras/pokemontools/scan_includes.py

LetsGoEeveeGB_obj := audio_red.o main_red.o text_red.o wram_red.o
LetsGoPikachuGB_obj := audio_blue.o main_blue.o text_blue.o wram_blue.o

.SUFFIXES:
.SUFFIXES: .asm .o .gbc .png .2bpp .1bpp .pic
.SECONDEXPANSION:
# Suppress annoying intermediate file deletion messages.
.PRECIOUS: %.2bpp
.PHONY: all clean red blue compare

roms := LetsGoEeveeGB.gbc LetsGoPikachuGB.gbc

all: $(roms)
red: LetsGoEeveeGB.gbc
blue: LetsGoPikachuGB.gbc

# For contributors to make sure a change didn't affect the contents of the rom.
compare: red blue
	@$(MD5) roms.md5

clean:
	rm -f $(roms) $(LetsGoEeveeGB_obj) $(LetsGoPikachuGB_obj) $(roms:.gbc=.sym)
	find . \( -iname '*.1bpp' -o -iname '*.2bpp' -o -iname '*.pic' \) -exec rm {} +

%.asm: ;

%_red.o: dep = $(shell $(includes) $(@D)/$*.asm)
$(LetsGoEeveeGB_obj): %_red.o: %.asm $$(dep)
	rgbasm -D _RED -h -o $@ $*.asm

%_blue.o: dep = $(shell $(includes) $(@D)/$*.asm)
$(LetsGoPikachuGB_obj): %_blue.o: %.asm $$(dep)
	rgbasm -D _BLUE -h -o $@ $*.asm

LetsGoEeveeGB_opt  = -jsv -k 01 -l 0x33 -m 0x13 -p 0 -r 03 -t "LETSGOGBEEVEE"
LetsGoPikachuGB_opt = -jsv -k 01 -l 0x33 -m 0x13 -p 0 -r 03 -t "LETSGOGBPIKA"

%.gbc: $$(%_obj)
	rgblink -n $*.sym -l pokered.link -o $@ $^
	rgbfix $($*_opt) $@
	sort $*.sym -o $*.sym

%.png:  ;
%.2bpp: %.png  ; @$(2bpp) $<
%.1bpp: %.png  ; @$(1bpp) $<
%.pic:  %.2bpp ; @$(pic)  $<
