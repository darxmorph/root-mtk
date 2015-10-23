#!/system/bin/sh

# Launches SuperSU in daemon mode only on Android 4.3+.
# Nothing will happen on 4.2.x or older, unless SELinux+Enforcing.

/system/xbin/busybox nohup /system/xbin/daemonsu --auto-daemon
