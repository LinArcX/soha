/****************************************************************************
**
** Copyright (C) 2017 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the FOO module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:GPL-EXCEPT$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3 as published by the Free Software
** Foundation with exceptions as appearing in the file LICENSE.GPL3-EXCEPT
** included in the packaging of this file. Please review the following
** information to ensure the GNU General Public License requirements will
** be met: https://www.gnu.org/licenses/gpl-3.0.html.
**
** $QT_END_LICENSE$
**
****************************************************************************/

function Component()
{
    // constructor
    component.loaded.connect(this, Component.prototype.loaded);
    if (!installer.addWizardPage(component, "Page", QInstaller.TargetDirectory))
        console.log("Could not add the dynamic page.");
    //installer.installationFinished.connect(this, Component.prototype.installationFinishedPageIsShown);
    //installer.uninstallationFinished.connect(this, Component.prototype.uninstallationFinishedPageIsShown);
}

/*
Component.prototype.installationFinishedPageIsShown = function()
{
    try {
        if (installer.isInstaller() && installer.status == QInstaller.Success) {
            installer.executeDetached("setx path", "%PATH%; @TargetDir@;");
        }
    } catch(e) {
        console.log(e);
    }
}

Component.prototype.uninstallationFinishedPageIsShown = function()
{
    try {
        if (installer.isUninstaller() && installer.status == QInstaller.Success) {
            //installer.executeDetached("set", "PATH=%PATH:;@TargetDir@=%");   setx path "%PATH:D:\Documents;=%"
            installer.executeDetached("setx path", "%PATH:@TargetDir@;=%");
        }
    } catch(e) {
        console.log(e);
    }
}
*/

Component.prototype.isDefault = function()
{
    // select the component by default
    return true;
}

Component.prototype.createOperations = function()
{
    try {
        // call the base create operations function
        component.createOperations();
    } catch (e) {
        console.log(e);
    }
    if (installer.value("os") === "win")
    {
        component.addOperation("CreateShortcut", "@TargetDir@/Taghvim.exe", "@DesktopDir@/Taghvim.lnk");
        //component.addOperation("Execute", "setx path", "%PATH%; @TargetDir@;")
        //component.addOperation("EnvironmentVariable", "TAGHVIM", "@TargetDir@", true, true);
    }
}

Component.prototype.loaded = function ()
{
    var page = gui.pageByObjectName("DynamicPage");
    if (page != null) {
        console.log("Connecting the dynamic page entered signal.");
        page.entered.connect(Component.prototype.dynamicPageEntered);
    }
}

Component.prototype.dynamicPageEntered = function ()
{
    var pageWidget = gui.pageWidgetByObjectName("DynamicPage");
    if (pageWidget != null) {
        console.log("Setting the widgets label text.")
        pageWidget.m_pageLabel.text = "This is a dynamically created page.";
    }
}