
/sys/bus/platform/drivers/ci_hdrc
/sys/module/ulpi/holders/ci_hdrc
/sys/module/usbcore/holders/ci_hdrc
/sys/module/ehci_hcd/holders/ci_hdrc
/sys/module/ci_hdrc

/sys/bus/platform/drivers/ci_hdrc/ci_hdrc.0/role
/sys/class/usb_role/ci_hdrc.0-role-switch/role

===========
To use keyboard:

Set the following in /etc/modprobe.d/options:
options usbcore use_both_schemes=y

Plug in device

Perform this command:
echo "host" > /sys/bus/platform/drivers/ci_hdrc/ci_hdrc.0/role

===========

cat /sys/kernel/config/usb_gadget/g_ether/UDC 
ci_hdrc.0


# Replay:
xxd -r power-off.hex > /dev/input/event0

# Capture power button
cat /dev/input/event0 | xxd
# Capture touch
cat /dev/input/event3 | xxd
# inspect device events
evtest
input-events
evemu-record / evemu-play



# blog:
https://www.codyhiar.com/blog/linux-keylogger-how-to-read-linux-keyboard-buffer/

# Event format (24 bytes):
                                             Code
                                         Type  |
|----- seconds ---| |---- useconds ---|   |    |  |-Value-|
0000 0000 0000 0000 0000 0000 0000 0000 0001 001e 0000 0001
       64 bits             64 bits      16b  16b   32 bits   ==  24 bytes total

# Command to parse on 64bit system - doesn't work on remarkable
sudo cat /dev/input/event3 | hexdump -e '2/8 "%010u " 2/2 " %04x" 1/4 " %08x" "\n"'

# Works on remarkable. hexdump can't seem to read more than 4 bytes on busybox
# so the timestamp has to be broken into 4 chunks of 4 bytes
cat /dev/input/event3 | hexdump -e '4/4 " %010u" 2/2 " %04x" 1/4 " %08x" "\n"'

# Command to convert binary events into human readable format with 1 event per line
cat file.bin | hexdump -e '4/4 " %010u" 2/2 " %04x" 1/4 " %08x" "\n"'

# Command to convert binary events into a clean hex format, with 1 event per line
cat file.bin | hexdump -e '24/1 "%02x " "\n"'

# Command that will reverse the above hexdump into binary again
cat file.hex | xxd -r -p


# Linux event mappings:
https://github.com/torvalds/linux/blob/master/include/uapi/linux/input-event-codes.h

# Event types:
# EV_SYN	0x00 *USED*
# EV_KEY	0x01 *USED*
# EV_REL	0x02
# EV_ABS	0x03 *USED*
# EV_MSC	0x04

# Event Codes:
# ABS_MT_TOUCH_MAJOR    0x30	Major axis of touching ellipse   *USED*
# ABS_MT_TOUCH_MINOR    0x31	Minor axis (omit if circular)  
# ABS_MT_WIDTH_MAJOR    0x32	Major axis of approaching ellipse  
# ABS_MT_WIDTH_MINOR    0x33	Minor axis (omit if circular)  
# ABS_MT_ORIENTATION    0x34	Ellipse orientation  
# ABS_MT_POSITION_X     0x35	Center X touch position   *USED*
# ABS_MT_POSITION_Y     0x36	Center Y touch position   *USED*
# ABS_MT_TOOL_TYPE      0x37	Type of touching device  
# ABS_MT_BLOB_ID    	0x38	Group a set of packets as a blob  
# ABS_MT_TRACKING_ID    0x39	Unique ID of initiated contact   *USED*
# BTN_TOUCH             0x14a





