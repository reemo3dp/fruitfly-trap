OPENSCAD ?= openscad

.PHONY: all clean


COMBINATIONS := 81OD_40H_4TS 65OD_40H_4TS 52OD_H30_4TS

all: $(foreach combination,$(COMBINATIONS),\
		stls/fruitfly-trap_$(combination).stl)
	$(MAKE) README.md


clean:
	rm -rf stls/

.PHONY: README.md
README.md: stls/*.stl
	@echo "# Fruit Fly Trap" > README.md
	@echo "" >> README.md
	@echo "These are renderings of the fruit fly trap https://www.printables.com/model/501865-turn-any-jar-into-a-fruitfly-trap." >> README.md
	@echo "" >> README.md

stls/fruitfly-trap_%.stl: fruitfly-trap.scad
	@mkdir -p ./stls/.thumbnails/ 2>/dev/null || true

	$(OPENSCAD) -o $@ \
		-o ./stls/.thumbnails/$(basename $(notdir $@)).png \
		--render \
		-D 'outer_thread_diameter=$(subst OD,,$(word 1,$(subst _, ,$*)))' \
		-D 'height=$(subst H,,$(word 2,$(subst _, ,$*)))' \
		-D 'thread_starts=$(subst TS,,$(word 3,$(subst _, ,$*)))' \
		$<