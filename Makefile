# Makefile for building my love game

LUAFILES=main.lua conf.lua src src/*
ZIPFILE=lpong.love
EXEFILE=lbreakout

all: $(ZIPFILE)

$(ZIPFILE): $(LUAFILES)
	zip $(ZIPFILE) $(LUAFILES)

exe: all
	cat /usr/bin/love $(ZIPFILE) > $(EXEFILE)
	chmod +x $(EXEFILE)

love: all
	love $(ZIPFILE)

