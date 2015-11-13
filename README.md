# What is this?
Root for devices containing MTK SoC

# Hardware required?
Any MTK device (may need to contain user2root hidden app, not tested on others without it)

# How to use this?
Connect your device (be sure to have drivers installed) and launch main.bat

# How does this work?
After decompiling MTK's user2root app in my phone, I found out it issues some shell commands to enable root on ADB interface
So, I plugged my phone to my computer and issued the command:
	adb shell setprop ro.secure 0
In my phone, I disabled USB debugging and turned it back on
And finally:
	platform-tools> adb shell
	* daemon not running. starting it now on port 5037 *
	* daemon started successfully *
	root@LEAGOO:/ #
It worked! Shell was running as root:
	root@LEAGOO:/ # id
	uid=0(root) gid=0(root) context=u:r:init_shell:s0
So, if you want to experiment with the basics of the code, go ahead and try it.