#####
##
## Copyright (C) 2012, 2013 by the deal.II authors
##
## This file is part of the deal.II library.
##
## <TODO: Full License information>
## This file is dual licensed under QPL 1.0 and LGPL 2.1 or any later
## version of the LGPL license.
##
## Author: Matthias Maier <matthias.maier@iwr.uni-heidelberg.de>
##
#####

#
# Configuration for the umfpack library:
#

#
# We depend on LAPACK to have a sane BLAS/LAPACK installation for bundled
# packages...
#
SET(FEATURE_UMFPACK_DEPENDS DEAL_II_WITH_LAPACK)


MACRO(FEATURE_UMFPACK_CONFIGURE_EXTERNAL var)

  INCLUDE_DIRECTORIES(${UMFPACK_INCLUDE_DIRS})
  LIST(APPEND DEAL_II_EXTERNAL_LIBRARIES ${UMFPACK_LIBRARIES})
  ADD_FLAGS(CMAKE_SHARED_LINKER_FLAGS "${UMFPACK_LINKER_FLAGS}")

  SET(HAVE_LIBUMFPACK TRUE)

  SET(${var} TRUE)
ENDMACRO()


MACRO(FEATURE_UMFPACK_CONFIGURE_BUNDLED var)

  LIST(APPEND DEAL_II_EXTERNAL_LIBRARIES ${BLAS_LIBRARIES})
  ADD_FLAGS(CMAKE_SHARED_LINKER_FLAGS "${BLAS_LINKER_FLAGS}")

  INCLUDE_DIRECTORIES(
    ${UMFPACK_FOLDER}/UMFPACK/Include
    ${UMFPACK_FOLDER}/AMD/Include
    )

  SET(HAVE_LIBUMFPACK TRUE)

  SET(${var} TRUE)
ENDMACRO()


MACRO(FEATURE_UMFPACK_ERROR_MESSAGE)
  MESSAGE(FATAL_ERROR "\n"
    "Could not find the umfpack and amd libraries!\n"
    "Please ensure that the libraries are installed on your computer.\n"
    "If the libraries are not at a default location, either provide some hints\n"
    "for the autodetection:\n"
    "    $ UMFPACK_DIR=\"...\" cmake <...>\n"
    "    $ cmake -DUMFPACK_DIR=\"...\" <...>\n"
    "or set the relevant variables by hand in ccmake.\n"
    "Relevant hints for UMFPACK are SUITESPARSE_DIR, UMFPACK_DIR\n"
    "(AMD_DIR, CHOLMOD_DIR, COLAMD_DIR, SUITESPARSECONFIG_DIR.)\n"
    "Alternatively you may choose to compile the bundled libraries\n"
    "by setting DEAL_II_ALLOW_BUNDLED=ON or DEAL_II_FORCE_BUNDLED_UMFPACK=ON.\n"
    "(BLAS and LAPACK have to be installed for bundled UMFPACK to be available)\n\n"
    )
ENDMACRO()


CONFIGURE_FEATURE(UMFPACK)
