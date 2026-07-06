#-------------------------------------------------
#
# Project created by QtCreator 2014-08-11T00:35:19
#
# Note: This file is to keep historical .pro file of Dale
# GitHub actions are running on file named DFTFringe.pro
# Both files will be maintained for an extended transition period
#
#-------------------------------------------------

QT += network \
      xml \
      multimedia \
      multimediawidgets \
      widgets
QT += concurrent widgets
QT += charts
qtHaveModule(printsupport): QT += printsupport
QT       += core gui
QT       += opengl widgets

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets
QT += datavisualization
TARGET = DFTFringe
TEMPLATE = app

CONFIG += ``

include($$PWD/DFTFringe_files.pri)

win32 {
      CONFIG( debug, debug|release ) {
        # debug
        LIBS += D:\\qwt-6.1.5\\lib\\qwtd.dll
      } else {
        # release
        LIBS += D:\\qwt-6.1.5\\lib\\qwt.dll
      }
      INCLUDEPATH += D:\\qwt-6.1.5\\src

      #message("using win32")

INCLUDEPATH += D:\armadillo\armadillo-12.6.7\include

INCLUDEPATH += D:\opencv\opencv-3.4.12\build\install\include

LIBS += D:\opencv\opencv-3.4.12\build\bin\libopencv_core3412.dll
LIBS += D:\opencv\opencv-3.4.12\build\bin\libopencv_highgui3412.dll
LIBS += D:\opencv\opencv-3.4.12\build\bin\libopencv_imgcodecs3412.dll
LIBS += D:\opencv\opencv-3.4.12\build\bin\libopencv_imgproc3412.dll
LIBS += D:\opencv\opencv-3.4.12\build\bin\libopencv_features2d3412.dll
LIBS += D:\opencv\opencv-3.4.12\build\bin\libopencv_calib3d3412.dll

#LIBS += D:\armadillo\bin\libarmadillo.dll
LIBS += D:\lapack\build64\bin\liblapack.dll
LIBS += D:\lapack\build64\bin\libblas.dll

LIBS += -ldbghelp # for SetUnhandledExceptionFilter
LIBS += -lz       # zip compression library needed for cnpy.cpp
}



unix {
     INCLUDEPATH += /usr/include/qwt
     INCLUDEPATH += /usr/include/opencv4
     LIBS += -lqwt-qt5
     LIBS += -lopencv_core
     LIBS += -lopencv_imgproc
     LIBS += -lopencv_highgui
     LIBS += -lGLU
     LIBS += -lopencv_calib3d
     LIBS += -lopencv_features2d
     LIBS += -lopencv_imgproc
     LIBS += -lopencv_imgcodecs
     #LIBS += -larmadillo
     message("using linux")
     contains(CONFIG,debug) { message("no extra debug libraries") }
}

OTHER_FILES += \
    todo.txt

RESOURCES += \
    DFTResources.qrc
RC_FILE = DFTFringe.rc
QMAKE_CXXFLAGS += -std=c++11

# The application version
VERSION = Dale7.3.2

# Define the preprocessor macro to get the application version in our application.
DEFINES += APP_VERSION=\\\"$$VERSION\\\"
DEFINES += QAPPLICATION_CLASS=QApplication
DEFINES += DALE_DO_NOT_LOG
DISTFILES += \
    buildingDFTFringe64.txt \
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
    ColorMaps/Perceptually Uniform Sequential_inferno.cmp \
    ColorMaps/Perceptually Uniform Sequential_magma.cmp \
    ColorMaps/Perceptually Uniform Sequential_plasma.cmp \
    ColorMaps/Perceptually Uniform Sequential_viridis.cmp \
    ColorMaps/Qualitative_Accent.cmp \
    ColorMaps/Qualitative_Dark2.cmp \
    ColorMaps/Qualitative_Paired.cmp \
    ColorMaps/Qualitative_Pastel1.cmp \
    ColorMaps/Qualitative_Pastel2.cmp \
    ColorMaps/Qualitative_Set1.cmp \
    ColorMaps/Qualitative_Set2.cmp \
    ColorMaps/Qualitative_Set3.cmp \
    ColorMaps/Sequential (2)_afmhot.cmp \
    ColorMaps/Sequential (2)_autumn.cmp \
    ColorMaps/Sequential (2)_bone.cmp \
    ColorMaps/Sequential (2)_cool.cmp \
    ColorMaps/Sequential (2)_copper.cmp \
    ColorMaps/Sequential (2)_gist_heat.cmp \
    ColorMaps/Sequential (2)_gray.cmp \
    ColorMaps/Sequential (2)_hot.cmp \
    ColorMaps/Sequential (2)_pink.cmp \
    ColorMaps/Sequential (2)_spring.cmp \
    ColorMaps/Sequential (2)_summer.cmp \
    ColorMaps/Sequential (2)_winter.cmp \
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
    RevisionHistory.html \
    README.md \


    TRANSLATIONS    = dftfringe_fr.ts




INCLUDEPATH += $$PWD/../../../../opencv/build-mingw/include
DEPENDPATH += $$PWD/../../../../opencv/build-mingw/include
