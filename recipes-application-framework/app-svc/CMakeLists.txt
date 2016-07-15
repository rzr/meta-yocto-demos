CMAKE_MINIMUM_REQUIRED(VERSION 2.6)
SET(CMAKE_ALLOW_LOOSE_LOOP_CONSTRUCTS true)

PROJECT(appsvc C)
SET(VERSION_MAJOR 0)
SET(VERSION "${VERSION_MAJOR}.1.0")

### Global setting ###

SET(PREFIX ${CMAKE_INSTALL_PREFIX})
SET(EXEC_PREFIX "\${prefix}")
SET(LIBDIR ${LIB_INSTALL_DIR})
SET(INCLUDEDIR "\${prefix}/include/appsvc")

# Build type : Release
IF("${CMAKE_BUILD_TYPE}" STREQUAL "")
	SET(CMAKE_BUILD_TYPE "Release")
ENDIF()
MESSAGE("Build type: ${CMAKE_BUILD_TYPE}")


# Set required packages
INCLUDE(FindPkgConfig)

SET(APPSVC_PKGS_CHECK_MODULES dlog ecore libprivilege-control aul)
SET(APPSVC_LIBPKGS_CHECK_MODULES dlog bundle dbus-glib-1 ail xdgmime aul glib-2.0 ecore libsoup-2.4 iniparser pkgmgr-info libtzplatform-config)

IF (with_x)
pkg_check_modules(pkgs REQUIRED ${APPSVC_PKGS_CHECK_MODULES} x11)
pkg_check_modules(libpkgs REQUIRED ${APPSVC_LIBPKGS_CHECK_MODULES} ecore-x)
ENDIF(with_x)

IF (with_wayland)
ADD_DEFINITIONS("-DWAYLAND")
pkg_check_modules(pkgs REQUIRED ${APPSVC_PKGS_CHECK_MODULES})
pkg_check_modules(libpkgs REQUIRED ${APPSVC_LIBPKGS_CHECK_MODULES})
ENDIF (with_wayland)

FOREACH(flag ${libpkgs_CFLAGS})
	SET(EXTRA_CFLAGS "${EXTRA_CFLAGS} ${flag}")
ENDFOREACH(flag)

FOREACH(flag ${pkgs_CFLAGS})
	SET(TEST_CFLAGS "${TEST_CFLAGS} ${flag}")
ENDFOREACH(flag)
message("#####" ${EXTRA_CFLAGS})
# Compiler flags
INCLUDE_DIRECTORIES(${CMAKE_SOURCE_DIR}/include)
INCLUDE_DIRECTORIES(${CMAKE_SOURCE_DIR}/legacy)
SET(EXTRA_CFLAGS "${EXTRA_CFLAGS} -Wl,-zdefs" )
SET(EXTRA_CFLAGS "${EXTRA_CFLAGS} -fvisibility=hidden")
SET(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${EXTRA_CFLAGS}")
SET(CMAKE_C_FLAGS_DEBUG "-O0 -g")
SET(CMAKE_C_FLAGS_RELEASE "-O2")

SET(CMAKE_SKIP_BUILD_RPATH true)

# Get uname value to set 'TARGET' definition 
# TODO: Is this needed?
FIND_PROGRAM(UNAME NAMES uname)
EXEC_PROGRAM("${UNAME}" ARGS "-m" OUTPUT_VARIABLE "ARCH")
IF("${ARCH}" STREQUAL "arm")
	ADD_DEFINITIONS("-DTARGET")
	MESSAGE("add -DTARGET")
ENDIF("${ARCH}" STREQUAL "arm")

ADD_DEFINITIONS("-DPREFIX=\"${CMAKE_INSTALL_PREFIX}\"")
ADD_DEFINITIONS("-DRW_DATA_PREFIX=\"/opt/share\"")

# Linker flags
SET(CMAKE_EXE_LINKER_FLAGS "-Wl,--as-needed")


### Build ###


# aul
add_library(appsvc SHARED
		src/appsvc.c
		src/appsvc_db.c
		)
target_link_libraries(appsvc ${libpkgs_LDFLAGS})
SET_TARGET_PROPERTIES(appsvc PROPERTIES SOVERSION ${VERSION_MAJOR})
SET_TARGET_PROPERTIES(appsvc PROPERTIES VERSION ${VERSION})

# pkgconfig file
CONFIGURE_FILE(appsvc.pc.in appsvc.pc @ONLY)


### Install ###
INSTALL(TARGETS appsvc DESTINATION ${LIB_INSTALL_DIR} COMPONENT RuntimeLibraries)
INSTALL(TARGETS ${AVATAR_NAME} DESTINATION bin)

INSTALL(FILES ${CMAKE_CURRENT_SOURCE_DIR}/include/appsvc.h DESTINATION include/appsvc)
INSTALL(FILES ${CMAKE_CURRENT_BINARY_DIR}/appsvc.pc DESTINATION ${LIB_INSTALL_DIR}/pkgconfig)

# test
add_subdirectory(test)

