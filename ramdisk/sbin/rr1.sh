#!/sbin/sh
#############################################################################
#
# Original from hroark (https://github.com/hroark13/lge_f6mt_aosp/commit/1cc37d2dd9d6757534a499c57dbdede9fdc8fad4)
# Adapted to FX3Q and some minor improvements by xdajog.
#
#############################################################################

/sbin/busybox dmesg > /tmp/dmesg.txt

# checking the key presses we are interested in 
# KEY 172 is the home key button but that is not early interceptable so we
# use the volume hardware keys instead
##hkp=`/sbin/busybox grep -cim1 "Touch KEY\[172\] is pressed" /tmp/dmesg.txt`
kp_up=`/sbin/busybox grep -cim1 "Vol_UP KEY PRESS" /tmp/dmesg.txt`
kp_down=`/sbin/busybox grep -cim1 "Vol_DOWN KEY PRESS" /tmp/dmesg.txt`

# this is to be sure to have valid values even when smthg goes completely wrong
[ -z "$kp_up" ] && kp_up=0
[ -z "$kp_down" ] && kp_down=0

# multiply the both detected values and set the property accordingly
hkp=$(expr $kp_up + $kp_down)
# only when the result is 2 the init process will boot into recovery
setprop ro.r.r $hkp
