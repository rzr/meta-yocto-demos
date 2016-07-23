#! /usr/bin/make -f

%: GNUmakefile
	${MAKE} ${@}

-include rules/01-global.mk
-include rules/30-default.mk
-include rules/40-implicit.mk
-include rules/50-tasks.mk
