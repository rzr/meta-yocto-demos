#! /usr/bin/make -f
include rules/01-global.mk
include rules/09-local-config.mk
include rules/10-config.mk
include rules/30-default.mk
include rules/50-tasks.mk
include rules/51-repo.mk
include rules/53-bitbake.mk
include rules/60-aliases.mk
include rules/70-extra.mk
include rules/80-phony.mk
include rules/90-overides.mk
include rules/99-local.mk
