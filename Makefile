DESTDIR ?=
PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin
BASHCOMPDIR ?= $(shell pkg-config bash-completion --variable=completionsdir || echo "/usr/share/bash-completion/completions")

install:
	install -Dm755 dotfiles $(DESTDIR)$(BINDIR)/dotfiles
	install -Dm644 completion/dotfiles.bash $(DESTDIR)$(BASHCOMPDIR)/dotfiles

uninstall:
	rm -f $(DESTDIR)$(BINDIR)/dotfiles
	rm -f $(DESTDIR)$(BASHCOMPDIR)/dotfiles
