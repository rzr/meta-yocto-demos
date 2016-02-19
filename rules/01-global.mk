SHELL=/bin/bash
V=1

default: GNUmakefile
	${MAKE} rule/done/help rule/done/all

%: rule/help

