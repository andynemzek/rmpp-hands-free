# Introduction

This is an approach for using a bluetooth page turning pedal with the Remarkable Paper Pro. As a musician, I wanted a way to turn pages on my RMPP hands-free while I was playing.

The RMPP does not officially support bluetooth or usb peripherals. While some have reported getting peripherals to work, I have found it to be very difficult, unreliable, and ill-documented.  This makes it very difficult to use something like a page turning pedal with the RMPP.  The following is an approach that has been successful for me and I use it regularly.  While it is somewhat involved, it is relatively straight forward and only uses officially supported techniques.

While RMPP does not support bluetooth or usb peripherals, it DOES support wifi/SSH. The following goes through the steps to setup a relay device that connects to your RMPP via wifi/SSH and forwards keystrokes from a peripheral connected to the relay (ex: a bluetooth page turning pedal).

The relay device can theoretically be any device that has the capability to both SSH to your RMPP and also connect to your peripheral. A phone is a good option and is what I use. A raspberry Pi could be another, though I have not tried this.

The "secret sauce" of this approach is the swipe_simulator.sh script in this repo. This script translates left/right arrow key presses into simulated swipe gestures that are fed into the RMPP's linux display device as input events. This allows you to turn pages with the arrow keys.

## Instructions
- Activate [developer mode on your RMPP](https://support.remarkable.com/s/article/Developer-mode)
- SSH into RMPP from your computer
- Copy the swipe_simulator.sh script (in this repo) to the device
- Make the script executable `chmod +x /path/to/script`
- Test the script:
    - While ssh'd, run the script on the device via a terminal
    - Open a multi-page doc on the RMPP
    - Use the arrow keys on the device your are ssh'ing from and observe that the pages of the open doc on the RMPP change
    - Press "q" to quit the script
- Determine what will be your "relay" device (ex: a phone)
- Connect your peripheral (ex: a bluetooth pedal or really any peripheral that can send left/right arrow keys) to your relay device
- SSH from your relay device to the RMPP
- Run swipe_simulator.sh on the RMPP via the relay device's SSH terminal
- With the relay device's terminal in the foreground, try using your peripheral to turn pages on your RMPP

## Other Considerations
- When I use my phone as the relay, I usually have its hotspot active and have the remarkable connect to that. The advantage of this is that the RMPP's IP address is more predictable and rarely changes. 
- The Termius app works well for SSH'ing to the RMPP and you can also configure it to easily run scripts
- You may not always want to have your wifi, bluetooth, hotspot, etc active on your phone. I found that the Automate App is great for automating turning these things on and off. For example, I have an Automate shortcut that puts my phone into "Pedal Mode".
- When using your peripheral, you must keep your terminal session on your relay device in the foreground, or it will not receive and forward the keystrokes to swipe_simulator.sh. This does likely mean that you need to have your phone screen on and unlocked when using this approach.