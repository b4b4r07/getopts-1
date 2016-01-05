XDG_CONFIG_HOME ?= $$HOME/.config
FISH_HOME = $(XDG_CONFIG_HOME)/fish
FUNC_HOME = $(FISH_HOME)/functions
GETOPTS = getopts.fish

$(FUNC_HOME)/$(GETOPTS): $(GETOPTS) $(FUNC_HOME)
	cp $< $@

$(FUNC_HOME):
	mkdir -p $@
