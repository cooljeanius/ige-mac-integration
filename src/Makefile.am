WARN_CFLAGS = -Wall -Wextra

WARN_CXXFLAGS = $(WARN_CFLAGS) -Wno-deprecated

AM_CFLAGS = $(WARN_CFLAGS)

AM_CXXFLAGS = $(WARN_CXXFLAGS)

AM_CPPFLAGS = -I$(top_srcdir) $(WARN_CFLAGS)

DISTCLEANFILES = .DS_Store

lib_LTLIBRARIES = libigemacintegration.la

libigemacintegration_la_SOURCES =			\
	GtkApplicationDelegate.h			\
	GtkApplicationDelegate.c			\
	GtkApplicationNotify.h				\
	GtkApplicationNotify.c				\
	GNSMenuBar.h					\
	GNSMenuBar.c					\
	GNSMenuItem.h					\
	GNSMenuItem.c					\
	getlabel.h					\
	getlabel.c					\
	cocoa_menu.h					\
	cocoa_menu.c					\
	cocoa_menu_item.h				\
	cocoa_menu_item.c				\
	gtkosxapplication_quartz.c				\
	gtkosxapplication.c				\
	gtkosxapplicationprivate.h				\
	ige-mac-dock.c					\
	ige-mac-bundle.c				\
	ige-mac-menu.c					\
	ige-mac-image-utils.c				\
	ige-mac-image-utils.h				\
	ige-mac-private.h				\
	$(integration_HEADERS)

libigemacintegration_la_CFLAGS = $(MAC_CFLAGS) -xobjective-c
libigemacintegration_la_OBJCFLAGS = $(MAC_CFLAGS)
libigemacintegration_la_LIBADD =  $(MAC_LIBS) -lobjc
libigemacintegration_la_LDFLAGS = -framework Carbon -framework ApplicationServices

integration_includedir = $(includedir)/igemacintegration
integration_include_HEADERS =				\
	ige-mac-integration.h				\
	gtkosxapplication.h				\
	ige-mac-menu.h					\
	ige-mac-dock.h					\
	ige-mac-bundle.h

# Test application
noinst_PROGRAMS = test-integration
test_integration_SOURCES = test-integration.c
test_integration_CFLAGS = $(MAC_CFLAGS)
test_integration_LDADD =  $(MAC_LIBS) libigemacintegration.la
