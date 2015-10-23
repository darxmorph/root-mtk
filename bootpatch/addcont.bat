@echo off
adb pull /dev/bootimg boot.img
bootimg.exe --unpack-bootimg
echo service daemonsu /system/xbin/su --daemon>> initrd\init.rc
echo 	class main>> initrd\init.rc
echo 	user root>> initrd\init.rc
echo 	oneshot>> initrd\init.rc
bootimg.exe --repack-bootimg
adb push boot-new.img /dev/bootimg