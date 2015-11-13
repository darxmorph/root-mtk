@echo off
rem This launches SU daemon from kernel (so install-recovery.sh isn't needed)
rem TODO: get boot.img from device (pulling /dev/bootimg doesn't work)
rem TODO: add an option in main so user can choose this option
adb pull /dev/bootimg boot.img
bootimg.exe --unpack-bootimg
echo service daemonsu /system/xbin/su --daemon>> initrd\init.rc
echo 	class main>> initrd\init.rc
echo 	user root>> initrd\init.rc
echo 	oneshot>> initrd\init.rc
bootimg.exe --repack-bootimg
adb push boot-new.img /dev/bootimg