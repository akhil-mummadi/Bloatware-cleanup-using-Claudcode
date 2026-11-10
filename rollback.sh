#!/bin/bash
# Rollback script for uninstalled bloatware
# Run this script to restore the removed packages
adb shell cmd package install-existing com.miui.analytics
adb shell cmd package install-existing com.miui.msa.global
adb shell cmd package install-existing com.xiaomi.mipicks
adb shell cmd package install-existing com.xiaomi.joyose
adb shell cmd package install-existing com.miui.yellowpage
adb shell cmd package install-existing com.miui.cleaner
adb shell cmd package install-existing com.xiaomi.scanner
adb shell cmd package install-existing com.miui.bugreport
adb shell cmd package install-existing com.miui.fm
adb shell cmd package install-existing com.miui.fmservice
adb shell cmd package install-existing com.facebook.services
adb shell cmd package install-existing com.facebook.system
adb shell cmd package install-existing com.facebook.appmanager
adb shell cmd package install-existing com.google.android.apps.subscriptions.red
adb shell cmd package install-existing com.google.android.apps.wellbeing
