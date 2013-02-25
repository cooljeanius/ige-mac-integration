AC_PREREQ([2.52])

AC_INIT([ige-mac-integration], [0.9.8],[mitch@imendio.com])
AC_CONFIG_SRCDIR([src/ige-mac-menu.c])
AC_CONFIG_MACRO_DIR([m4])
AC_CANONICAL_HOST
AC_CANONICAL_TARGET
AC_USE_SYSTEM_EXTENSIONS
AM_INIT_AUTOMAKE
AM_MAINTAINER_MODE
AM_SANITY_CHECK
AC_CONFIG_HEADERS([config.h])

AM_DISABLE_STATIC
AM_PROG_LIBTOOL
AC_MSG_CHECKING([Bitness])
AC_PREPROC_IFELSE(
    [AC_LANG_PROGRAM([[]],[[#ifndef __x86_64__
#error
#endif
	]])],
    [AC_MSG_RESULT([64-BIT])
     sixty_four_bit=yes],
    [AC_MSG_RESULT([32-Bit])
     sixty_four_bit=no])
AM_CONDITIONAL([SIXTY_FOUR_BIT], [test x$sixty_four_bit = xyes])

# Checks for programs.
AC_ISC_POSIX
AC_PROG_CC
AC_PROG_CPP
AC_PROG_CXX
AC_PROG_OBJC
AM_PROG_CC_C_O
AC_PROG_INSTALL
AC_PROG_LN_S
AC_PROG_MAKE_SET
AC_PROG_RANLIB
AM_PATH_PYTHON
AM_PROG_VALAC
EBG_MACOSX_OPTIONS
PKG_PROG_PKG_CONFIG

# Checks for libraries.
# FIXME: Replace `main' with a function in `-lobjc':
AC_CHECK_LIB([objc], [main])
# FIXME: Replace `main' with a function in `-lc':
AC_CHECK_LIB([c], [main])
# FIXME: Replace `main' with a function in `-lm':
AC_CHECK_LIB([m], [main])
# FIXME: Replace `main' with a function in `-lresolv':
AC_CHECK_LIB([resolv], [main])
# FIXME: Replace `main' with a function in `-lfreetype':
AC_CHECK_LIB([freetype], [main])
# FIXME: Replace `main' with a function in `-lfontconfig':
AC_CHECK_LIB([fontconfig], [main])
# FIXME: Replace `main' with a function in `-lcairo':
AC_CHECK_LIB([cairo], [main])
# FIXME: Replace `main' with a function in `-lpango':
AC_CHECK_LIB([pango], [main])
# FIXME: Replace `main' with a function in `-lpangocairo':
AC_CHECK_LIB([pangocairo], [main])
# FIXME: Replace `main' with a function in `-lintl':
AC_CHECK_LIB([intl], [main])
# FIXME: Replace `main' with a function in `-lpng':
AC_CHECK_LIB([png], [main])
# FIXME: Replace `main' with a function in `-lgdk-quartz':
AC_CHECK_LIB([gdk-quartz], [main])
# FIXME: Replace `main' with a function in `-latk':
AC_CHECK_LIB([atk], [main])
# FIXME: Replace `main' with a function in `-licule':
AC_CHECK_LIB([icule], [main])
# FIXME: Replace `main' with a function in `-licuuc':
AC_CHECK_LIB([icuuc], [main])
# FIXME: Replace `main' with a function in `-licudata':
AC_CHECK_LIB([icudata], [main])
AM_PATH_GLIB_2_0

GTK_DOC_CHECK([1.11], [--flavour no-tmpl])

AC_ARG_WITH([gtk],
	[AS_HELP_STRING([--with-gtk],
		[select gtk+-3.0 or gtk+-2.0. @<:@default=check@:>@])],
	[],
	[with_gtk=check])
dnl gtk_major=

AS_ECHO(["Specified Gtk Version $with_gtk"])

AS_IF([test "x$with_gtk" = xgtk+-3.0],
         [PKG_CHECK_MODULES(MAC, [gtk+-3.0 >= 2.90], GTK_MAJOR="gtk+-3.0",
           AC_MSG_ERROR([GTK+-3.0 specified but not found]))],
      [test "x$with_gtk" = xgtk+-2.0],
         [PKG_CHECK_MODULES(MAC, [gtk+-2.0 >= 2.10], GTK_MAJOR="gtk+-2.0",
           AC_MSG_ERROR([GTK+-2.0 specified but not found]))],
      [PKG_CHECK_MODULES(MAC, [gtk+-3.0 >= 2.90],GTK_MAJOR="gtk+-3.0",
         PKG_CHECK_MODULES(MAC, [gtk+-2.0 >= 2.10], GTK_MAJOR="gtk+-2.0",
	    AC_MSG_ERROR([GTK+-2.0 Wersion 2.10 or higher or GTK+-3.0 Version 2.90.0 or higher is required to build ige-mac-integration])))])

AC_MSG_CHECKING([GTK+ Version])

GTK_VERSION=`$PKG_CONFIG --modversion ${GTK_MAJOR}`
AC_SUBST(GTK_MAJOR)
AC_SUBST(GTK_VERSION)
AC_MSG_RESULT("$GTK_VERSION")
AM_CONDITIONAL([INTROSPECTION], [test x$GTK_MAJOR = "xgtk+-3.0"])

GTK_PYTHON_CHECK

# This will cause the automake generated makefiles to pass the correct
# flags to aclocal.
ACLOCAL_AMFLAGS="\${ACLOCAL_FLAGS}"
AC_SUBST(ACLOCAL_AMFLAGS)
AC_DEFINE_UNQUOTED([PREFIX],["$prefix"], [Installation prefix (for making filenames)])

# Checks for header files.
AC_HEADER_STDC
AC_PATH_X
AC_CHECK_HEADERS([sys/param.h])

# Checks for typedefs, structures, and compiler characteristics.
AC_CHECK_HEADER_STDBOOL

# Checks for library functions.
AC_CHECK_FUNCS([strdup])

AC_CONFIG_FILES(
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
)

AC_OUTPUT

echo
echo "Prefix         : $prefix"
echo "Python bindings: $enable_python"
echo
