ACLOCAL_AMFLAGS = -I m4 --install

SUBDIRS = src data bindings docs strings

EXTRA_DIST = gtk-doc.make

DISTCHECK_CONFIGURE_FLAGS = --enable-gtk-doc

WARN_CFLAGS = -Wall -Wextra

WARN_CXXFLAGS = $(WARN_CFLAGS) -Wno-deprecated

AM_CFLAGS = $(WARN_CFLAGS)

AM_CXXFLAGS = $(WARN_CXXFLAGS)

DISTCLEANFILES = *~ .DS_Store autoscan.log

distclean-local:
	-rm -rf autom4te.cache || rmdir autom4te.cache
.PHONY: distclean-local
