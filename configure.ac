#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.


AC_PREREQ(2.61)

m4_define([required_apertium_version], [3.3.0])

AC_INIT([apertium-en-fr],[0.0.1],[joregan@gmail.com])
AM_INIT_AUTOMAKE([apertium-en-fr], [0.0.1], no-define)
AC_PROG_LN_S
AC_PROG_AWK

PKG_CHECK_MODULES(APERTIUM,   apertium >= required_apertium_version, [], [PKG_CHECK_MODULES(APERTIUM,   apertium-3.2 >= required_apertium_version)])
  
AP_MKINCLUDE

AC_CONFIG_FILES([Makefile])
AC_OUTPUT
