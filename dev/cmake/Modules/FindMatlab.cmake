# - this module looks for Matlab
# Defines:
#  MATLAB_INCLUDE_DIR: include path for mex.h
#  MATLAB_LIBRARIES:   required libraries: libmex, libmx
#  MATLAB_MEX_LIBRARY: path to libmex
#  MATLAB_MX_LIBRARY:  path to libmx

SET(MATLAB_FOUND 0)
IF( "$ENV{MATLAB_ROOT}" STREQUAL "" )
    MESSAGE(STATUS "MATLAB_ROOT environment variable not set." )
    MESSAGE(STATUS "In Linux this can be done in your user .bashrc file by appending the corresponding line, e.g:" )
    MESSAGE(STATUS "export MATLAB_ROOT=/usr/local/MATLAB/R2012b" )
    MESSAGE(STATUS "In Windows this can be done by adding system variable, e.g:" )
    MESSAGE(STATUS "MATLAB_ROOT=D:\\Program Files\\MATLAB\\R2011a" )
ELSE()

        FIND_PATH(MATLAB_INCLUDE_DIR mex.h
                  $ENV{MATLAB_ROOT}/extern/include)

        INCLUDE_DIRECTORIES(${MATLAB_INCLUDE_DIR})

        FIND_LIBRARY( MATLAB_MEX_LIBRARY
                      NAMES libmex mex
                      PATHS $ENV{MATLAB_ROOT}/bin $ENV{MATLAB_ROOT}/extern/lib
                      PATH_SUFFIXES glnxa64 glnx86 win64/microsoft win32/microsoft maci64 maci32
                      NO_DEFAULT_PATH)
        FIND_LIBRARY( MATLAB_MX_LIBRARY
                      NAMES libmx mx
                      PATHS $ENV{MATLAB_ROOT}/bin $ENV{MATLAB_ROOT}/extern/lib
                      PATH_SUFFIXES glnxa64 glnx86 win64/microsoft win32/microsoft maci64 maci32
                      NO_DEFAULT_PATH)
		FIND_LIBRARY( MATLAB_MAT_LIBRARY
                      NAMES libmat mat
                      PATHS $ENV{MATLAB_ROOT}/bin $ENV{MATLAB_ROOT}/extern/lib
                      PATH_SUFFIXES glnxa64 glnx86 win64/microsoft win32/microsoft maci64 maci32
                      NO_DEFAULT_PATH)

ENDIF()

if (MATLAB_MAT_LIBRARY)
SET(MATLAB_LIBRARIES
  ${MATLAB_MEX_LIBRARY}
  ${MATLAB_MX_LIBRARY}
  ${MATLAB_MAT_LIBRARY}
)
else()
SET(MATLAB_LIBRARIES
  ${MATLAB_MEX_LIBRARY}
  ${MATLAB_MX_LIBRARY}
)
endif()

MESSAGE (STATUS "MATLAB_ROOT: $ENV{MATLAB_ROOT}")
MESSAGE (STATUS "MATLAB_INCLUDE_DIR: ${MATLAB_INCLUDE_DIR}")
MESSAGE (STATUS "MATLAB_LIBRARIES: ${MATLAB_LIBRARIES}")
MESSAGE (STATUS "MATLAB_MEX_LIBRARY: ${MATLAB_MEX_LIBRARY}")
MESSAGE (STATUS "MATLAB_MX_LIBRARY: ${MATLAB_MX_LIBRARY}")
MESSAGE (STATUS "MATLAB_MAT_LIBRARY: ${MATLAB_MAT_LIBRARY}")

IF(MATLAB_INCLUDE_DIR AND MATLAB_LIBRARIES)
  SET(MATLAB_FOUND 1)
  MESSAGE(STATUS "Matlab libraries will be used")
ENDIF()

MARK_AS_ADVANCED(
  MATLAB_LIBRARIES
  MATLAB_MEX_LIBRARY
  MATLAB_MX_LIBRARY
  MATLAB_INCLUDE_DIR
  MATLAB_FOUND
  MATLAB_ROOT
)
