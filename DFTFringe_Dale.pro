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

SOURCES += src/main.cpp \
    src/annulushelpdlg.cpp \
    src/arbitrarywavefronthelp.cpp \
    src/arbitrarywavwidget.cpp \
    src/astigpolargraph.cpp \
	src/autoinvertdlg.cpp \
    src/cpoint.cpp \
    src/defocusdlg.cpp \
    src/edgeplot.cpp \
    src/hotkeysdlg.cpp \
    src/mainwindow.cpp \
    src/igramarea.cpp \
    src/circleoutline.cpp \
    cnpy/cnpy.cpp \
    src/graphicsutilities.cpp \
    src/dfttools.cpp \
    src/dftarea.cpp \
    src/oglrendered.cpp \
    src/pdfcalibrationdlg.cpp \
    src/percentcorrectiondlg.cpp \
    src/profilecurve.cpp \
    src/profileplot.cpp \
    src/profileplotpicker.cpp \
    src/ronchicomparedialog.cpp \
    src/settingsigramimportconfig.cpp \
    src/startestmoviedlg.cpp \
    src/surface3dcontrolsdlg.cpp \
    src/surfacegraph.cpp \
    src/surfacelightingproxy.cpp \
    src/userdrawnprofiledlg.cpp \
    src/wavefront.cpp \
    src/contourplot.cpp \
    src/contourtools.cpp \
    src/dftcolormap.cpp \
    src/surfaceanalysistools.cpp \
    src/surfacemanager.cpp \
    src/wavefrontloaderworker.cpp \
    src/zernikedlg.cpp \
    src/zernikepolar.cpp \
    src/zernikeprocess.cpp \
    src/mirrordlg.cpp \
    src/zernikes.cpp \
    src/metricsdisplay.cpp \
    src/reviewwindow.cpp \
    src/rotationdlg.cpp \
    src/wftstats.cpp \
    src/imagehisto.cpp \
    src/colorchanneldisplay.cpp \
    src/intensityplot.cpp \
    src/igramintensity.cpp \
    src/dftthumb.cpp \
    src/vortexdebug.cpp \
    src/simigramdlg.cpp \
    src/punwrap.cpp \
    src/wftexaminer.cpp \
    src/usercolormapdlg.cpp \
    src/colormapviewerdlg.cpp \
    src/oglview.cpp \
    src/settingsigram.cpp \
    src/settings2.cpp \
    src/settingsdft.cpp \
    src/settingsdebug.cpp \
    src/contourview.cpp \
    src/simulationsview.cpp \
    src/psfplot.cpp \
    src/standastigwizard.cpp \
    src/counterrotationdlg.cpp \
    src/subtractwavefronatsdlg.cpp \
    src/helpdlg.cpp \
    src/settingsprofile.cpp \
    src/batchigramwizard.cpp \
    src/outlinehelpdocwidget.cpp \
    src/statsview.cpp \
    src/jitteroutlinedlg.cpp \
    src/nullvariationdlg.cpp \
    src/ccswappeddlg.cpp \
    src/foucaultview.cpp \
    src/bathastigdlg.cpp \
    src/zernikeeditdlg.cpp \
    src/settingsGeneral2.cpp \
    src/nullmarginhelpdlg.cpp \
    src/plotcolor.cpp \
    src/cameracalibwizard.cpp \
    src/camwizardpage1.cpp \
    src/camcalibrationreviewdlg.cpp \
    src/generatetargetdlg.cpp \
    src/lensetablemodel.cpp \
    src/unwraperrorsview.cpp \
    src/messagereceiver.cpp \
    src/myutils.cpp \
    src/pixelstats.cpp \
    src/utils.cpp \
    src/circlefit.cpp \
    src/astigstatsdlg.cpp \
    src/averagewavefrontfilesdlg.cpp \
    src/astigscatterplot.cpp \
    src/wavefrontfilterdlg.cpp \
    src/myplotpicker.cpp \
    src/rmsplot.cpp \
    src/regionedittools.cpp \
    src/reportdlg.cpp \
    src/showaliasdlg.cpp \
    src/colorchannel.cpp \
    src/wavefrontaveragefilterdlg.cpp \
    src/rejectedwavefrontsdlg.cpp \
    src/outlinestatsdlg.cpp \
    src/filteroutlinesdlg.cpp \
    src/outlineplots.cpp \
    src/transformwavefrontdlg.cpp \
    src/showallcontoursdlg.cpp \
    src/psi_dlg.cpp \
    src/psiphasedisplay.cpp \
    src/outlinedialog.cpp \
    src/psitiltoptions.cpp \
    src/contourrulerparams.cpp \
    src/zernikesmoothingdlg.cpp \
    zernike/zapm.cpp \
    SingleApplication/singleapplication.cpp \
    SingleApplication/singleapplication_p.cpp

HEADERS  += src/mainwindow.h \
    src/annulushelpdlg.h \
    src/arbitrarywavefronthelp.h \
    src/arbitrarywavwidget.h \
    src/astigpolargraph.h \
	src/autoinvertdlg.h \
    src/cpoint.h \
    src/defocusdlg.h \
    src/edgeplot.h \
    src/IgramArea.h \
    src/circleoutline.h \
    cnpy/cnpy.h \
    src/graphicsutilities.h \
    src/dfttools.h \
    src/dftarea.h \
    src/hotkeysdlg.h \
    src/oglrendered.h \
    src/pdfcalibrationdlg.h \
    src/percentCorrectionSurface.h \
    src/percentcorrectiondlg.h \
    src/profilecurve.h \
    src/profileplot.h \
    src/profileplotpicker.h \
    src/ronchicomparedialog.h \
    src/settingsigramimportconfig.h \
    src/startestmoviedlg.h \
    src/surface3dcontrolsdlg.h \
    src/surfacegraph.h \
    src/surfacelightingproxy.h \
    src/userdrawnprofiledlg.h \
    src/wavefront.h \
    src/contourplot.h \
    src/contourtools.h \
    src/dftcolormap.h \
    src/surfaceanalysistools.h \
    src/surfacemanager.h \
    src/wavefrontloaderworker.h \
    src/zernikedlg.h \
    src/zernikepolar.h \
    src/zernikeprocess.h \
    src/mirrordlg.h \
    src/zernikes.h \
    src/metricsdisplay.h \
    src/reviewwindow.h \
    src/rotationdlg.h \
    src/wftstats.h \
    src/punwrap.h \
    src/imagehisto.h \
    src/colorchanneldisplay.h \
    src/intensityplot.h \
    src/igramintensity.h \
    src/dftthumb.h \
    src/vortexdebug.h \
    src/simigramdlg.h \
    src/wftexaminer.h \
    src/usercolormapdlg.h \
    src/colormapviewerdlg.h \
    src/oglview.h \
    src/settingsigram.h \
    src/settings2.h \
    src/settingsdft.h \
    src/settingsdebug.h \
    src/contourview.h \
    src/simulationsview.h \
    src/psfplot.h \
    src/standastigwizard.h \
    src/counterrotationdlg.h \
    src/subtractwavefronatsdlg.h \
    src/helpdlg.h \
    src/settingsprofile.h \
    src/batchigramwizard.h \
    src/outlinehelpdocwidget.h \
    src/statsview.h \
    src/jitteroutlinedlg.h \
    src/nullvariationdlg.h \
    src/ccswappeddlg.h \
    src/foucaultview.h \
    src/bathastigdlg.h \
    src/zernikeeditdlg.h \
    src/settingsGeneral2.h \
    src/nullmarginhelpdlg.h \
    src/plotcolor.h \
    src/cameracalibwizard.h \
    src/camwizardpage1.h \
    src/camcalibrationreviewdlg.h \
    src/generatetargetdlg.h \
    src/lensetablemodel.h \
    src/unwraperrorsview.h \
    src/messagereceiver.h \
    src/myutils.h \
    src/pixelstats.h \
    src/utils.h \
    src/circleutils.h \
    src/circle.h \
    src/astigstatsdlg.h \
    src/averagewavefrontfilesdlg.h \
    src/astigscatterplot.h \
    src/wavefrontfilterdlg.h \
    src/myplotpicker.h \
    src/rmsplot.h \
    src/regionedittools.h \
    src/reportdlg.h \
    src/showaliasdlg.h \
    src/colorchannel.h \
    src/wavefrontaveragefilterdlg.h \
    src/rejectedwavefrontsdlg.h \
    src/outlinestatsdlg.h \
    src/filteroutlinesdlg.h \
    src/outlineplots.h \
    src/transformwavefrontdlg.h \
    src/showallcontoursdlg.h \
    src/psi_dlg.h \
    src/psiphasedisplay.h \
    src/outlinedialog.h \
    src/psitiltoptions.h \
    src/contourrulerparams.h \
    src/zernikesmoothingdlg.h \
    bezier/bezier.h \
    zernike/zapm_interface.h \
    SingleApplication/singleapplication.h \
    SingleApplication/singleapplication_p.h

INCLUDEPATH += ./bezier ./SingleApplication ./zernike ./cnpy ./src

FORMS    += src/mainwindow.ui \
    src/annulushelpdlg.ui \
    src/arbitrarywavefronthelp.ui \
    src/astigpolargraph.ui \
	src/autoinvertdlg.ui \
    src/defocusdlg.ui \
    src/dfttools.ui \
    src/dftarea.ui \
    src/edgeplot.ui \
    src/hotkeysdlg.ui \
    src/oglrendered.ui \
    src/pdfcalibrationdlg.ui \
    src/percentcorrectiondlg.ui \
    src/profileplot.ui \
    src/contourtools.ui \
    src/settingsigramimportconfig.ui \
    src/startestmoviedlg.ui \
    src/surface3dcontrolsdlg.ui \
    src/surfaceanalysistools.ui \
    src/metricsdisplay.ui \
    src/userdrawnprofiledlg.ui \
    src/zernikedlg.ui \
    src/mirrordlg.ui \
    src/reviewwindow.ui \
    src/rotationdlg.ui \
    src/colorchanneldisplay.ui \
    src/igramintensity.ui \
    src/dftthumb.ui \
    src/vortexdebug.ui \
    src/simigramdlg.ui \
    src/wftexaminer.ui \
    src/usercolormapdlg.ui \
    src/colormapviewerdlg.ui \
    src/settingsigram.ui \
    src/settings2.ui \
    src/settingsdft.ui \
    src/settingsdebug.ui \
    src/contourview.ui \
    src/simulationsview.ui \
    src/psfplot.ui \
    src/standastigwizard.ui \
    src/counterrotationdlg.ui \
    src/subtractwavefronatsdlg.ui \
    src/helpdlg.ui \
    src/settingsprofile.ui \
    src/batchigramwizard.ui \
    src/outlinehelpdocwidget.ui \
    src/statsview.ui \
    src/jitteroutlinedlg.ui \
    src/nullvariationdlg.ui \
    src/ccswappeddlg.ui \
    src/foucaultview.ui \
    src/bathastigdlg.ui \
    src/zernikeeditdlg.ui \
    src/settingsGeneral2.ui \
    src/nullmarginhelpdlg.ui \
    src/cameracalibwizard.ui \
    src/camwizardpage1.ui \
    src/camcalibrationreviewdlg.ui \
    src/generatetargetdlg.ui \
    src/unwraperrorsview.ui \
    src/pixelstats.ui \
    src/astigstatsdlg.ui \
    src/averagewavefrontfilesdlg.ui \
    src/wavefrontfilterdlg.ui \
    src/regionedittools.ui \
    src/reportdlg.ui \
    src/showaliasdlg.ui \
    src/wavefrontaveragefilterdlg.ui \
    src/rejectedwavefrontsdlg.ui \
    src/outlinestatsdlg.ui \
    src/filteroutlinesdlg.ui \
    src/outlineplots.ui \
    src/transformwavefrontdlg.ui \
    src/showallcontoursdlg.ui \
    src/psi_dlg.ui \
    src/psiphasedisplay.ui \
    src/outlinedialog.ui \
    src/psitiltoptions.ui \
    src/contourrulerparams.ui \
    src/zernikesmoothingdlg.ui

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
