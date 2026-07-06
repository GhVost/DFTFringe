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

INCLUDEPATH += ./bezier ./SingleApplication ./zernike ./cnpy ./src

SOURCES += SingleApplication/singleapplication.cpp \
    SingleApplication/singleapplication_p.cpp \
    zernike/zapm.cpp \
    src/annulushelpdlg.cpp \
    src/arbitrarywavefronthelp.cpp \
    src/arbitrarywavwidget.cpp \
    src/astigpolargraph.cpp \
    src/astigscatterplot.cpp \
    src/astigstatsdlg.cpp \
    src/autoinvertdlg.cpp \
    src/averagewavefrontfilesdlg.cpp \
    src/batchigramwizard.cpp \
    src/bathastigdlg.cpp \
    src/camcalibrationreviewdlg.cpp \
    src/cameracalibwizard.cpp \
    src/camwizardpage1.cpp \
    src/ccswappeddlg.cpp \
    src/circlefit.cpp \
    src/circleoutline.cpp \
    cnpy/cnpy.cpp \
    src/colorchannel.cpp \
    src/colorchanneldisplay.cpp \
    src/colormapviewerdlg.cpp \
    src/contourplot.cpp \
    src/contourrulerparams.cpp \
    src/contourtools.cpp \
    src/contourview.cpp \
    src/counterrotationdlg.cpp \
    src/cpoint.cpp \
    src/defocusdlg.cpp \
    src/dftarea.cpp \
    src/dftcolormap.cpp \
    src/dftthumb.cpp \
    src/dfttools.cpp \
    src/edgeplot.cpp \
    src/filteroutlinesdlg.cpp \
    src/foucaultview.cpp \
    src/generatetargetdlg.cpp \
    src/graphicsutilities.cpp \
    src/helpdlg.cpp \
    src/hotkeysdlg.cpp \
    src/igramarea.cpp \
    src/igramintensity.cpp \
    src/imagehisto.cpp \
    src/intensityplot.cpp \
    src/jitteroutlinedlg.cpp \
    src/lensetablemodel.cpp \
    src/main.cpp \
    src/mainwindow.cpp \
    src/messagereceiver.cpp \
    src/metricsdisplay.cpp \
    src/mirrordlg.cpp \
    src/myplotpicker.cpp \
    src/myutils.cpp \
    src/nullmarginhelpdlg.cpp \
    src/nullvariationdlg.cpp \
    src/oglrendered.cpp \
    src/oglview.cpp \
    src/outlinedialog.cpp \
    src/outlinehelpdocwidget.cpp \
    src/outlineplots.cpp \
    src/outlinestatsdlg.cpp \
    src/pdfcalibrationdlg.cpp \
    src/percentcorrectiondlg.cpp \
    src/pixelstats.cpp \
    src/plotcolor.cpp \
    src/profilecurve.cpp \
    src/profileplot.cpp \
    src/profileplotpicker.cpp \
    src/ronchicomparedialog.cpp \
    src/psfplot.cpp \
    src/psi_dlg.cpp \
    src/psiphasedisplay.cpp \
    src/psitiltoptions.cpp \
    src/punwrap.cpp \
    src/regionedittools.cpp \
    src/rejectedwavefrontsdlg.cpp \
    src/reportdlg.cpp \
    src/reviewwindow.cpp \
    src/rmsplot.cpp \
    src/rotationdlg.cpp \
    src/settings2.cpp \
    src/settingsdebug.cpp \
    src/settingsdft.cpp \
    src/settingsGeneral2.cpp \
    src/settingsigram.cpp \
    src/settingsigramimportconfig.cpp \
    src/settingsprofile.cpp \
    src/showaliasdlg.cpp \
    src/showallcontoursdlg.cpp \
    src/simigramdlg.cpp \
    src/simulationsview.cpp \
    src/standastigwizard.cpp \
    src/startestmoviedlg.cpp \
    src/statsview.cpp \
    src/subtractwavefronatsdlg.cpp \
    src/surface3dcontrolsdlg.cpp \
    src/surfaceanalysistools.cpp \
    src/surfacegraph.cpp \
    src/surfacelightingproxy.cpp \
    src/surfacemanager.cpp \
    src/wavefrontloaderworker.cpp \
    src/transformwavefrontdlg.cpp \
    src/unwraperrorsview.cpp \
    src/usercolormapdlg.cpp \
    src/userdrawnprofiledlg.cpp \
    src/utils.cpp \
    src/vortexdebug.cpp \
    src/wavefront.cpp \
    src/wavefrontaveragefilterdlg.cpp \
    src/wavefrontfilterdlg.cpp \
    src/wftexaminer.cpp \
    src/wftstats.cpp \
    src/zernikedlg.cpp \
    src/zernikeeditdlg.cpp \
    src/zernikepolar.cpp \
    src/zernikeprocess.cpp \
    src/zernikes.cpp \
    src/zernikesmoothingdlg.cpp

HEADERS += bezier/bezier.h \
    SingleApplication/singleapplication_p.h \
    SingleApplication/singleapplication.h \
    zernike/zapm_interface.h \
    src/annulushelpdlg.h \
    src/arbitrarywavefronthelp.h \
    src/astigpolargraph.h \
    src/arbitrarywavwidget.h \
    src/astigscatterplot.h \
    src/astigstatsdlg.h \
    src/autoinvertdlg.h \
    src/averagewavefrontfilesdlg.h \
    src/batchigramwizard.h \
    src/bathastigdlg.h \
    src/camcalibrationreviewdlg.h \
    src/cameracalibwizard.h \
    src/camwizardpage1.h \
    src/ccswappeddlg.h \
    src/circle.h \
    src/circleoutline.h \
    src/circleutils.h \
    cnpy/cnpy.h \
    src/colorchannel.h \
    src/colorchanneldisplay.h \
    src/colormapviewerdlg.h \
    src/contourplot.h \
    src/contourrulerparams.h \
    src/contourtools.h \
    src/contourview.h \
    src/counterrotationdlg.h \
    src/cpoint.h \
    src/defocusdlg.h \
    src/dftarea.h \
    src/dftcolormap.h \
    src/dftthumb.h \
    src/dfttools.h \
    src/edgeplot.h \
    src/filteroutlinesdlg.h \
    src/foucaultview.h \
    src/generatetargetdlg.h \
    src/graphicsutilities.h \
    src/helpdlg.h \
    src/hotkeysdlg.h \
    src/IgramArea.h \
    src/igramintensity.h \
    src/imagehisto.h \
    src/intensityplot.h \
    src/jitteroutlinedlg.h \
    src/lensetablemodel.h \
    src/mainwindow.h \
    src/messagereceiver.h \
    src/metricsdisplay.h \
    src/mirrordlg.h \
    src/myplotpicker.h \
    src/myutils.h \
    src/nullmarginhelpdlg.h \
    src/nullvariationdlg.h \
    src/oglrendered.h \
    src/oglview.h \
    src/outlinedialog.h \
    src/outlinehelpdocwidget.h \
    src/outlineplots.h \
    src/outlinestatsdlg.h \
    src/pdfcalibrationdlg.h \
    src/percentcorrectiondlg.h \
    src/percentCorrectionSurface.h \
    src/pixelstats.h \
    src/plotcolor.h \
    src/profilecurve.h \
    src/profileplot.h \
    src/profileplotpicker.h \
    src/ronchicomparedialog.h \
    src/psfplot.h \
    src/psi_dlg.h \
    src/psiphasedisplay.h \
    src/psitiltoptions.h \
    src/punwrap.h \
    src/regionedittools.h \
    src/rejectedwavefrontsdlg.h \
    src/reportdlg.h \
    src/reviewwindow.h \
    src/rmsplot.h \
    src/rotationdlg.h \
    src/settings2.h \
    src/settingsdebug.h \
    src/settingsdft.h \
    src/settingsGeneral2.h \
    src/settingsigram.h \
    src/settingsigramimportconfig.h \
    src/settingsprofile.h \
    src/showaliasdlg.h \
    src/showallcontoursdlg.h \
    src/simigramdlg.h \
    src/simulationsview.h \
    src/standastigwizard.h \
    src/startestmoviedlg.h \
    src/statsview.h \
    src/subtractwavefronatsdlg.h \
    src/surface3dcontrolsdlg.h \
    src/surfaceanalysistools.h \
    src/surfacegraph.h \
    src/surfacelightingproxy.h \
    src/surfacemanager.h \
    src/wavefrontloaderworker.h \
    src/transformwavefrontdlg.h \
    src/unwraperrorsview.h \
    src/usercolormapdlg.h \
    src/userdrawnprofiledlg.h \
    src/utils.h \
    src/vortexdebug.h \
    src/wavefront.h \
    src/wavefrontaveragefilterdlg.h \
    src/wavefrontfilterdlg.h \
    src/wftexaminer.h \
    src/wftstats.h \
    src/zernikedlg.h \
    src/zernikeeditdlg.h \
    src/zernikepolar.h \
    src/zernikeprocess.h \
    src/zernikes.h \
    src/zernikesmoothingdlg.h

FORMS += src/arbitrarywavefronthelp.ui \
    src/annulushelpdlg.ui \
    src/astigpolargraph.ui \
    src/astigstatsdlg.ui \
    src/autoinvertdlg.ui \
    src/averagewavefrontfilesdlg.ui \
    src/batchigramwizard.ui \
    src/bathastigdlg.ui \
    src/camcalibrationreviewdlg.ui \
    src/cameracalibwizard.ui \
    src/camwizardpage1.ui \
    src/ccswappeddlg.ui \
    src/colorchanneldisplay.ui \
    src/colormapviewerdlg.ui \
    src/contourrulerparams.ui \
    src/contourtools.ui \
    src/contourview.ui \
    src/counterrotationdlg.ui \
    src/defocusdlg.ui \
    src/dftarea.ui \
    src/dftthumb.ui \
    src/dfttools.ui \
    src/edgeplot.ui \
    src/filteroutlinesdlg.ui \
    src/foucaultview.ui \
    src/generatetargetdlg.ui \
    src/helpdlg.ui \
    src/hotkeysdlg.ui \
    src/igramintensity.ui \
    src/jitteroutlinedlg.ui \
    src/mainwindow.ui \
    src/metricsdisplay.ui \
    src/mirrordlg.ui \
    src/nullmarginhelpdlg.ui \
    src/nullvariationdlg.ui \
    src/oglrendered.ui \
    src/outlinedialog.ui \
    src/outlinehelpdocwidget.ui \
    src/outlineplots.ui \
    src/outlinestatsdlg.ui \
    src/pdfcalibrationdlg.ui \
    src/percentcorrectiondlg.ui \
    src/pixelstats.ui \
    src/profileplot.ui \
    src/psfplot.ui \
    src/psi_dlg.ui \
    src/psiphasedisplay.ui \
    src/psitiltoptions.ui \
    src/regionedittools.ui \
    src/rejectedwavefrontsdlg.ui \
    src/reportdlg.ui \
    src/reviewwindow.ui \
    src/rotationdlg.ui \
    src/settings2.ui \
    src/settingsdebug.ui \
    src/settingsdft.ui \
    src/settingsGeneral2.ui \
    src/settingsigram.ui \
    src/settingsigramimportconfig.ui \
    src/settingsprofile.ui \
    src/showaliasdlg.ui \
    src/showallcontoursdlg.ui \
    src/simigramdlg.ui \
    src/simulationsview.ui \
    src/standastigwizard.ui \
    src/startestmoviedlg.ui \
    src/statsview.ui \
    src/subtractwavefronatsdlg.ui \
    src/surface3dcontrolsdlg.ui \
    src/surfaceanalysistools.ui \
    src/transformwavefrontdlg.ui \
    src/unwraperrorsview.ui \
    src/usercolormapdlg.ui \
    src/userdrawnprofiledlg.ui \
    src/vortexdebug.ui \
    src/wavefrontaveragefilterdlg.ui \
    src/wavefrontfilterdlg.ui \
    src/wftexaminer.ui \
    src/zernikedlg.ui \
    src/zernikeeditdlg.ui \
    src/zernikesmoothingdlg.ui

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




