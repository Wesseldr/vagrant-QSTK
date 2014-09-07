#!/bin/bash
#
# Script to set the default Launcher icons
# (c) Wessel de Roode, 2014

. ./discover_session_bus_address.sh unity

#
# After how long are we going to lock the desktop 0 means never
#
gsettings set org.gnome.desktop.session idle-delay 0

#
# Setup the quick launch 
#
gsettings set com.canonical.Unity.Launcher favorites "['application://ubiquity.desktop', 'application://nautilus.desktop', 'application://gnome-terminal.desktop', 'application://gvim.desktop', 'application://geany.desktop', 'application://meld.desktop', 'application://pgadmin3.desktop', 'mysql-workbench.desktop', 'application://chromium-browser.desktop', 'application://firefox.desktop', 'application://ubuntu-software-center.desktop', 'application://unity-control-center.desktop', 'unity://running-apps', 'unity://expo-icon', 'unity://devices']"
