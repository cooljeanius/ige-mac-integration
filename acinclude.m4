dnl# -*- mode: autoconf -*-

dnl# THIS IS NOT AVAILABLE ON TIGER, including a copy:
dnl# a macro to check for ability to create python extensions
dnl#  AM_CHECK_PYTHON_HEADERS([ACTION-IF-POSSIBLE],[ACTION-IF-IMPOSSIBLE])
dnl# function also defines PYTHON_INCLUDES
AC_DEFUN([AM_CHECK_PYTHON_HEADERS],
 [
  AC_REQUIRE([AM_PATH_PYTHON])
  AC_MSG_CHECKING([for headers required to compile python extensions])

  dnl# deduce PYTHON_INCLUDES
  py_prefix=`${PYTHON} -c "import sys; print sys.prefix"`
  py_exec_prefix=`${PYTHON} -c "import sys; print sys.exec_prefix"`
  PYTHON_INCLUDES="-I${py_prefix}/include/python${PYTHON_VERSION}"

  if test "x${py_prefix}" != "x${py_exec_prefix}"; then
    PYTHON_INCLUDES="${PYTHON_INCLUDES} -I${py_exec_prefix}/include/python${PYTHON_VERSION}"
  fi
  AC_SUBST([PYTHON_INCLUDES])

  dnl# check if the headers exist:
  save_CPPFLAGS="${CPPFLAGS}"
  CPPFLAGS="${CPPFLAGS} ${PYTHON_INCLUDES}"
AC_PREPROC_IFELSE([AC_LANG_SOURCE([[#include <Python.h>]])],dnl
[AC_MSG_RESULT([found])
$1],dnl
[AC_MSG_RESULT([not found])
$2])
CPPFLAGS="${save_CPPFLAGS}"
])

dnl#
dnl# Check for Python + PyGtk  or Gtk-3.0.gir and setup PyGtk
dnl# bindings variables if it's PyGtk
dnl#
AC_DEFUN([GTK_PYTHON_CHECK],
[
  dnl# for overriding the documentation installation directory
  AC_ARG_WITH([python-dir],
    [AS_HELP_STRING([--with-python-dir=PATH],[path to installed Python extensions])],[],
    [with_python_dir='${datadir}/python/site-packages'])
  PYTHON_DIR="${with_python_dir}"
  AC_SUBST([PYTHON_DIR])

  AC_ARG_ENABLE([python],
    [AS_HELP_STRING([--enable-python=@<:@no/yes/auto@:>@],
                    [build Python bindings [[default=auto]]])],[],
    [enable_python=auto])

  have_python=no

  if test "x${enable_python}" != "xno"; then
    have_python=yes

    dnl# Check for Python
    AM_PATH_PYTHON([2.3.5],[],[AC_MSG_RESULT([Python 2.3.5 or newer is required])])
    AM_CHECK_PYTHON_HEADERS([],[AC_MSG_RESULT([Python headers not found])])
    AS_IF([ test "x${GTK_MAJOR}" = "xgtk-2.0"],
    dnl# Check for PyGTK
      [ PKG_CHECK_MODULES([PYGOBJECT],[pygobject-2.0 >= 2.16.0],[],[have_pygobject=no])
    	if test "x${have_pygobject}" = "xno"; then
      	   AC_MSG_RESULT([PyGObject 2.16.0 or newer])
    	fi
    	PKG_CHECK_MODULES([PYGTK],[pygtk-2.0 >= 2.14.0],[],[have_pygtk=no])
    	if test "x${have_pygtk}" = "xno"; then
      	   AC_MSG_RESULT([PyGTK 2.14.0 or newer])
    	fi

    	AC_PATH_PROG([PYGOBJECT_CODEGEN],[pygobject-codegen-2.0],[no])
    	if test "x${PYGOBJECT_CODEGEN}" = xno; then
      	   have_python=no
      	   AC_MSG_RESULT([pygobject-codegen-2.0 script not found])
    	fi

    	AC_MSG_CHECKING([for pygtk defs])
    	PYGTK_DEFSDIR=`${PKG_CONFIG} --variable=defsdir pygtk-2.0`
    	AC_SUBST([PYGTK_DEFSDIR])
    	AC_MSG_RESULT([${PYGTK_DEFSDIR}])
     ],
     [ test "x${GTK_MAJOR}" = "xgtk+-3.0" ],
dnl# Check that pygobject and gtk-3.0.gir are present
     [ PKG_CHECK_MODULES([PYGOBJECT],[pygobject-2.0 >= 2.28.0],[],[have_pygobject=no])
    	if test "x${have_pygobject}" = "xno"; then
      	   AC_MSG_RESULT([PyGObject 2.28.0 or newer])
    	fi
    	AC_PATH_PROG([PYGOBJECT_CODEGEN],[pygobject-codegen-2.0],[no])
    	if test "x${PYGOBJECT_CODEGEN}" = "xno"; then
      	   have_python=no
      	   AC_MSG_RESULT([pygobject-codegen-2.0 script not found])
    	fi
        if test "x${PREFIX}" != "x" -a "x${PREFIX}" != "xNONE"; then
	   GIR_PATH="${PREFIX}/share/gir-1.0/Gtk-3.0.gir"
        # darn case-sensitivity:
        elif test "x${prefix}" != "x" -a "x${prefix}" != "xNONE"; then
           GIR_PATH="${prefix}/share/gir-1.0/Gtk-3.0.gir"
        elif test "x${exec_prefix}" != "x" -a "x${exec_prefix}" != "xNONE"; then
           GIR_PATH="${exec_prefix}/share/gir-1.0/Gtk-3.0.gir"
        elif test -d /usr/local; then
           GIR_PATH="/usr/local/share/gir-1.0/Gtk-3.0.gir"
        elif test -d /opt/local; then
           GIR_PATH="/opt/local/share/gir-1.0/Gtk-3.0.gir"
        elif test -d /sw; then
           GIR_PATH="/sw/share/gir-1.0/Gtk-3.0.gir"
        fi
	AC_CHECK_FILE([${GIR_PATH}],[],[have_python=no])
     ],[have_python=no])
  fi
  AC_MSG_CHECKING([whether to build Python bindings])

  if test "x${enable_python}" = "xyes"; then
    if test "x${have_python}" != "xyes"; then
      AC_MSG_ERROR([Could NOT find the required Python tools.])
   fi
  fi

  if test "x${have_python}" = "xno"; then
    enable_python=no
  elif test "x${have_python}" = "xyes" -a "x${enable_python}" = "xauto"; then
    enable_python=yes
  fi

  AC_MSG_RESULT([${enable_python}])

  AM_CONDITIONAL([ENABLE_PYTHON],[test "x${enable_python}" = "xyes"])
])
dnl# -----------------------------------------------------------
