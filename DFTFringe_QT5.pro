#    ____  _____ _____ _____     _
#   |    \|   __|_   _|   __|___|_|___ ___ ___
#   |  |  |   __| | | |   __|  _| |   | . | -_|
#   |____/|__|    |_| |__|  |_| |_|_|_|_  |___|
#                                     |___|


TARGET = DFTFringe

VERSION = MY_AUTOMATED_VERSION_STRING

DEFINES += APP_VERSION=\\\"$$VERSION\\\"
DEFINES += QAPPLICATION_CLASS=QApplication

TEMPLATE = app

QT += charts concurrent core datavisualization gui multimedia multimediawidgets network opengl widgets xml

qtHaveModule(printsupport): QT += printsupport

QMAKE_CXXFLAGS += -std=c++14

# disable qDebug() in release
CONFIG( release, debug|release ) {
    message("Release build")
    DEFINES += QT_NO_DEBUG_OUTPUT
}

# Below are the three platform specific project configurations for WINDOWS, LINUX and MAC

# WINDOWS ##########
win32 {
    message("Using WINDOWS project configuration.")

    CONFIG( debug, debug|release ) {
        LIBS += -L..\qwt-6.1.6\lib -lqwtd # debug
    } else {
        LIBS += -L..\qwt-6.1.6\lib -lqwt # release
        CONFIG+=force_debug_info # keep debug infos (even in release build) to be able to link stacktrace address to actual function
        CONFIG+=separate_debug_info # separate debug infos into a .exe.debug to not grow the .exe
    }

    # NOTE: RC_FILE is Windows only, breaks Mac (and Linux?) builds if it in their scope.
    RC_FILE = DFTFringe.rc

    INCLUDEPATH += ..\qwt-6.1.6\src
    INCLUDEPATH += ..\build_armadillo\tmp\include
    INCLUDEPATH += ..\build_openCV\install\include

    LIBS += -L..\build_lapack\bin -llibblas
    LIBS += -L..\build_lapack\bin -lliblapack
    LIBS += -L..\build_openCV\install\x64\mingw\bin -llibopencv_calib3d460
    LIBS += -L..\build_openCV\install\x64\mingw\bin -llibopencv_core460
    LIBS += -L..\build_openCV\install\x64\mingw\bin -llibopencv_features2d460
    LIBS += -L..\build_openCV\install\x64\mingw\bin -llibopencv_highgui460
    LIBS += -L..\build_openCV\install\x64\mingw\bin -llibopencv_imgcodecs460
    LIBS += -L..\build_openCV\install\x64\mingw\bin -llibopencv_imgproc460
    LIBS += -ldbghelp # for SetUnhandledExceptionFilter
    LIBS += -lz       # zip compression library needed for cnpy.cpp

    # This is for armadillo to not use wrapper. See https://gitlab.com/conradsnicta/armadillo-code#6-linux-and-macos-compiling-and-linking
    DEFINES += ARMA_DONT_USE_WRAPPER
}

# LINUX ############
unix: !mac {
    message("Using LINUX project configuration.")
    contains( CONFIG,debug ) { message("no extra debug libraries") }

    INCLUDEPATH += /usr/include/opencv4
    INCLUDEPATH += /usr/include/qwt

    LIBS += -larmadillo
    LIBS += -lGLU
    LIBS += -lopencv_calib3d
    LIBS += -lopencv_core
    LIBS += -lopencv_features2d
    LIBS += -lopencv_highgui
    LIBS += -lopencv_imgcodecs
    LIBS += -lopencv_imgproc
    LIBS += -lopencv_imgproc
    LIBS += -lqwt-qt5
    LIBS += -lz       # zip compression library needed for cnpy.cpp

}

# MAC ##############
macx {
    message("Using MACOS project configuration.")
    message( ................................ )
    message("..........PRO FILE: $$_PRO_FILE_")
    message("......PRO FILE PWD: $$_PRO_FILE_PWD_")
    message( ................... )

    CONFIG += app_bundle
    CONFIG += sdk_no_version_check
    CONFIG += link_pkgconfig
    CONFIG += silent

    QMAKE_FULL_VERSION=APP_VERSION
    QMAKE_MACOSX_DEPLOYMENT_TARGET = 11.0
    QMAKE_APPLE_DEVICE_ARCHS = x86_64 arm64

    CONFIG( debug, debug|release )   { DESTDIR = build/debug }
    CONFIG( release, debug|release ) { DESTDIR = build/release }

    MOC_DIR = $$DESTDIR/.moc
    OBJECTS_DIR = $$DESTDIR/.obj #these change between build and release.
    RCC_DIR = $$DESTDIR/.qrc
    UI_DIR = $$DESTDIR/.ui
    QMAKE_MKDIR = /usr/local/bin/mkdir # This tells QMAKE which mkdir command to use.
    QMAKE_PKG_CONFIG = /opt/homebrew/bin/pkg-config # This tells QMAKE which pkg-config executable to use.
    PKG_CONFIG_PATH = $$[QT_INSTALL_LIBS]/pkgconfig
    INCLUDEPATH += -I$$[QT_INSTALL_PLUGINS]
    LIBS += -L$$[QT_INSTALL_PLUGINS]
    PKGCONFIG += armadillo opencv Qt5Qwt6

    message(........QT_VERSION: $$[QT_VERSION])
    message(.QT_INSTALL_PREFIX: $$[QT_INSTALL_PREFIX])
    message(QT_INSTALL_HEADERS: $$[QT_INSTALL_HEADERS])
    message(...QT_INSTALL_LIBS: $$[QT_INSTALL_LIBS])
    message(QT_INSTALL_PLUGINS: $$[QT_INSTALL_PLUGINS])
    message(...................)
    message(...........DESTDIR: $$DESTDIR)
    message(...........MOC_DIR: $$MOC_DIR)
    message(.......OBJECTS_DIR: $$OBJECTS_DIR)
    message(...........RCC_DIR: $$RCC_DIR)
    message(............UI_DIR: $$UI_DIR)
    message(...................)
    message(.......QMAKE_MKDIR: $$QMAKE_MKDIR)
    message(..QMAKE_PKG_CONFIG: $$QMAKE_PKG_CONFIG)
    message(...PKG_CONFIG_PATH: $$PKG_CONFIG_PATH)
    message(.......INCLUDEPATH: $$INCLUDEPATH)
    message(..............LIBS: $$LIBS)
    message(.........PKGCONFIG: $$PKGCONFIG)
    message(............CONFIG: $$CONFIG)
}

# Below are the includes for source files and other resources, sorted alphabetically. ##################################
# If a filename contains spaces it will need quoting.


RESOURCES += DFTResources.qrc

TRANSLATIONS += dftfringe_fr.ts

include($$PWD/DFTFringe_files.pri)

DISTFILES += buildingDFTFringe64.txt \
    ColorMaps/Dale1.cmp \
    ColorMaps/Dale2.cmp \
    ColorMaps/Dale3.cmp \
    ColorMaps/Diverging_BrBG.cmp \
    ColorMaps/Diverging_bwr.cmp \
    ColorMaps/Diverging_coolwarm.cmp \
    ColorMaps/Diverging_PiYG.cmp \
    ColorMaps/Diverging_PRGn.cmp \
    ColorMaps/Diverging_PuOr.cmp \
    ColorMaps/Diverging_RdBu.cmp \
    ColorMaps/Diverging_RdGy.cmp \
    ColorMaps/Diverging_RdYlBu.cmp \
    ColorMaps/Diverging_RdYlGn.cmp \
    ColorMaps/Diverging_seismic.cmp \
    ColorMaps/Diverging_Spectral.cmp \
    ColorMaps/Miscellaneous_brg.cmp \
    ColorMaps/Miscellaneous_CMRmap.cmp \
    ColorMaps/Miscellaneous_cubehelix.cmp \
    ColorMaps/Miscellaneous_flag.cmp \
    ColorMaps/Miscellaneous_gist_earth.cmp \
    ColorMaps/Miscellaneous_gist_ncar.cmp \
    ColorMaps/Miscellaneous_gist_rainbow.cmp \
    ColorMaps/Miscellaneous_gist_stern.cmp \
    ColorMaps/Miscellaneous_gnuplot.cmp \
    ColorMaps/Miscellaneous_gnuplot2.cmp \
    ColorMaps/Miscellaneous_hsv.cmp \
    ColorMaps/Miscellaneous_jet.cmp \
    ColorMaps/Miscellaneous_nipy_spectral.cmp \
    ColorMaps/Miscellaneous_ocean.cmp \
    ColorMaps/Miscellaneous_prism.cmp \
    ColorMaps/Miscellaneous_rainbow.cmp \
    ColorMaps/Miscellaneous_terrain.cmp \
    "ColorMaps/Perceptually Uniform Sequential_inferno.cmp" \
    "ColorMaps/Perceptually Uniform Sequential_magma.cmp" \
    "ColorMaps/Perceptually Uniform Sequential_plasma.cmp" \
    "ColorMaps/Perceptually Uniform Sequential_viridis.cmp" \
    ColorMaps/Qualitative_Accent.cmp \
    ColorMaps/Qualitative_Dark2.cmp \
    ColorMaps/Qualitative_Paired.cmp \
    ColorMaps/Qualitative_Pastel1.cmp \
    ColorMaps/Qualitative_Pastel2.cmp \
    ColorMaps/Qualitative_Set1.cmp \
    ColorMaps/Qualitative_Set2.cmp \
    ColorMaps/Qualitative_Set3.cmp \
    "ColorMaps/Sequential (2)_afmhot.cmp" \
    "ColorMaps/Sequential (2)_autumn.cmp" \
    "ColorMaps/Sequential (2)_bone.cmp" \
    "ColorMaps/Sequential (2)_cool.cmp" \
    "ColorMaps/Sequential (2)_copper.cmp" \
    "ColorMaps/Sequential (2)_gist_heat.cmp" \
    "ColorMaps/Sequential (2)_gray.cmp" \
    "ColorMaps/Sequential (2)_hot.cmp" \
    "ColorMaps/Sequential (2)_pink.cmp" \
    "ColorMaps/Sequential (2)_spring.cmp" \
    "ColorMaps/Sequential (2)_summer.cmp" \
    "ColorMaps/Sequential (2)_winter.cmp" \
    ColorMaps/Sequential_Blues.cmp \
    ColorMaps/Sequential_BuGn.cmp \
    ColorMaps/Sequential_BuPu.cmp \
    ColorMaps/Sequential_GnBu.cmp \
    ColorMaps/Sequential_Greens.cmp \
    ColorMaps/Sequential_Greys.cmp \
    ColorMaps/Sequential_Oranges.cmp \
    ColorMaps/Sequential_OrRd.cmp \
    ColorMaps/Sequential_PuBu.cmp \
    ColorMaps/Sequential_PuBuGn.cmp \
    ColorMaps/Sequential_PuRd.cmp \
    ColorMaps/Sequential_Purples.cmp \
    ColorMaps/Sequential_RdPu.cmp \
    ColorMaps/Sequential_Reds.cmp \
    ColorMaps/Sequential_YlGn.cmp \
    ColorMaps/Sequential_YlGnBu.cmp \
    ColorMaps/Sequential_YlOrBr.cmp \
    ColorMaps/Sequential_YlOrRd.cmp \
    ColorMaps/spring.cmp \
    COPYING.LESSER.txt \
    COPYING.txt \
    README.md \
    RevisionHistory.html




