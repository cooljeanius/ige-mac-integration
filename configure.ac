#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.52])

AC_INIT([ige-mac-integration],[0.9.8],[mitch@imendio.com])
AC_CONFIG_SRCDIR([src/ige-mac-menu.c])
AC_CONFIG_MACRO_DIR([m4])
AC_CANONICAL_TARGET dnl# also checks the "_BUILD" and "_HOST" versions
AC_SEARCH_LIBS([strerror],[cposix]) dnl# used to be AC\_ISC\_POSIX
AC_USE_SYSTEM_EXTENSIONS
AM_INIT_AUTOMAKE([1.11 gnits])
AM_MAINTAINER_MODE
AM_SANITY_CHECK
AC_CONFIG_HEADERS([config.h])

m4_ifdef([AM_PROG_AR],[
AM_PROG_AR
],[
AC_CHECK_TOOLS([AR],[ar lib "link -lib"],[false])
: ${AR=ar}
])
AC_DISABLE_STATIC([])
LT_INIT([dlopen disable-static])
AC_MSG_CHECKING([Bitness])
AC_PREPROC_IFELSE(
    [AC_LANG_PROGRAM([[]],[[
#ifndef __x86_64__
# error we are not on x86_64
#endif /* !__x86_64__ */
	]])],
    [AC_MSG_RESULT([64-BIT])
     sixty_four_bit=yes],
    [AC_MSG_RESULT([32-Bit])
     sixty_four_bit=no])
AM_CONDITIONAL([SIXTY_FOUR_BIT],[test "x${sixty_four_bit}" = "xyes"])

# Checks for programs.
m4_ifdef([AM_PROG_CC_C_O],[
AM_PROG_CC_C_O
],[:])
AC_PROG_CPP
AC_PROG_CXX
AC_PROG_OBJC
AC_PROG_INSTALL
AC_PROG_LN_S
AC_PROG_RANLIB
m4_ifdef([AM_PROG_VALAC],[
AM_PROG_VALAC
],[
AC_PATH_PROG([VALAC],[valac],[valac])
])
EBG_MACOSX_OPTIONS

# Checks for libraries.
AC_CHECK_LIB([objc],[sel_getName])
AC_CHECK_LIB([c],[printf])
AC_CHECK_LIB([m],[sqrt])
LT_LIB_M
AC_CHECK_LIB([resolv],[res_init])
# FIXME: Replace `main' with a function in `-lfreetype':
AC_CHECK_LIB([freetype],[main])
# FIXME: Replace `main' with a function in `-lfontconfig':
AC_CHECK_LIB([fontconfig],[main])
# FIXME: Replace `main' with a function in `-lcairo':
AC_CHECK_LIB([cairo],[main])
# FIXME: Replace `main' with a function in `-lpango':
AC_CHECK_LIB([pango],[main])
# FIXME: Replace `main' with a function in `-lpangocairo':
AC_CHECK_LIB([pangocairo], [main])
AC_CHECK_LIB([intl],[gettext],[:],[
  AC_CHECK_LIB([intl],[main])
])
# FIXME: Replace `main' with a function in `-lpng':
AC_CHECK_LIB([png],[main])
# FIXME: Replace `main' with a function in `-lgdk-quartz':
AC_CHECK_LIB([gdk-quartz],[main])
# FIXME: Replace `main' with a function in `-latk':
AC_CHECK_LIB([atk],[main])
# FIXME: Replace `main' with a function in `-licule':
AC_CHECK_LIB([icule],[main])
# FIXME: Replace `main' with a function in `-licuuc':
AC_CHECK_LIB([icuuc],[main])
# FIXME: Replace `main' with a function in `-licudata':
AC_CHECK_LIB([icudata],[main])
AM_PATH_GLIB_2_0
AC_CHECK_LIB([glib],[g_thread_init],[:],[
  AC_SEARCH_LIBS([g_thread_init],[glib glib-2.0 glib-1.0 gio gio-2.0 \
                                  gio-1.0 gobject gobject-2.0 gobject-1.0 \
                                  gnu gtk-3 gdk-3 gtk-2 gdk-2 gtk-1 gdk-1 \
                                  gtk gdk])
])

GTK_DOC_CHECK([1.11],[--flavour no-tmpl])

AC_ARG_WITH([gtk],
	[AS_HELP_STRING([--with-gtk],
		[select gtk+-3.0 or gtk+-2.0. @<:@default=check@:>@])],
	[],
	[with_gtk=check])
dnl# gtk_major=

AS_ECHO(["Specified Gtk Version ${with_gtk}"])

AS_IF([test "x${with_gtk}" = "xgtk+-3.0"],
      [PKG_CHECK_MODULES([MAC],[gtk+-3.0 >= 2.90],[GTK_MAJOR="gtk+-3.0"],
           [AC_MSG_ERROR([GTK+-3.0 specified but not found])])],
      [test "x${with_gtk}" = "xgtk+-2.0"],
      [PKG_CHECK_MODULES([MAC],[gtk+-2.0 >= 2.10],[GTK_MAJOR="gtk+-2.0"],
           [AC_MSG_ERROR([GTK+-2.0 specified but not found])])],
      [PKG_CHECK_MODULES([MAC],[gtk+-3.0 >= 2.90],[GTK_MAJOR="gtk+-3.0"],
        [PKG_CHECK_MODULES([MAC],[gtk+-2.0 >= 2.10],[GTK_MAJOR="gtk+-2.0"],
            [AC_MSG_ERROR([GTK+-2.0 Wersion 2.10 or higher or GTK+-3.0 Version 2.90.0 or higher is required to build ige-mac-integration])
        ])
      ])
])

AC_MSG_CHECKING([GTK+ Version])

GTK_VERSION=`${PKG_CONFIG} --modversion ${GTK_MAJOR}`
AC_SUBST([GTK_MAJOR])
AC_SUBST([GTK_VERSION])
AC_MSG_RESULT(["${GTK_VERSION}"])
AM_CONDITIONAL([INTROSPECTION],[test "x${GTK_MAJOR}" = "xgtk+-3.0"])

GTK_PYTHON_CHECK

# This will cause the automake generated makefiles to pass the correct
# flags to aclocal.
ACLOCAL_AMFLAGS="\${ACLOCAL_FLAGS}"
AC_SUBST([ACLOCAL_AMFLAGS])
AC_DEFINE_UNQUOTED([PREFIX],["${prefix}"],[Installation prefix (for making filenames)])

# Checks for header files.
AC_HEADER_STDBOOL dnl# also "_CHECK"s it
AC_PATH_X
AC_PATH_XTRA
AC_CHECK_HEADERS([sys/param.h])

# Checks for typedefs, structures, and compiler characteristics.
AC_C_CONST
AC_C_PROTOTYPES

# Checks for library functions.
AC_CHECK_FUNCS([g_thread_init strdup])

AC_CONFIG_FILES([
	Makefile
	src/Makefile
        bindings/Makefile
        bindings/python/Makefile
	bindings/python/igemacintegration/Makefile
	bindings/python/gtk_osxapplication/Makefile
	bindings/python/gtk3_osxapplication/Makefile
        data/Makefile
        data/ige-mac-integration.pc
	docs/Makefile
	docs/reference/Makefile
	strings/Makefile
])

AC_OUTPUT

echo ""
echo "Prefix         : ${prefix}"
echo "Python bindings: ${enable_python}"
echo ""
