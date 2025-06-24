#!/bin/bash

main() {
    # Listen for arrow key presses
    echo "Listening for left and right arrow keys. Press 'q' to quit."

    # Configure terminal to read single keypresses
    stty -echo -icanon time 0 min 0

    while true; do
        # Read a single character input
        read -rsn1 key

        # Check for arrow keys (they start with escape sequence)
        if [[ $key == $'\e' ]]; then
            read -rsn2 key # Read the next two characters

            case $key in
                "[D")
                    swipe_prev_page
                    ;;
                "[C")
                    swipe_next_page
                    ;;
            esac
        elif [[ $key == "q" ]]; then
            echo "Exiting."
            break
        fi

    done

    # Restore terminal settings
    stty sane
}


swipe_prev_page() {
    echo "Swipe previous page."

    # Code 0x39 - Unique ID of initiated contact 
    echo "fd 8a 54 67 00 00 00 00 3d ad 02 00 00 00 00 00 03 00 39 00 91 01 00 00" | xxd -r -p > /dev/input/event3
    # Code 0x35 - Center X touch position
    echo "fd 8a 54 67 00 00 00 00 3d ad 02 00 00 00 00 00 03 00 35 00 5f 02 00 00" | xxd -r -p > /dev/input/event3
    # Code 0x36 - Center Y touch position
    echo "fd 8a 54 67 00 00 00 00 3d ad 02 00 00 00 00 00 03 00 36 00 15 07 00 00" | xxd -r -p > /dev/input/event3
    # Code 0x30 - Major axis of touching ellipse
    echo "fd 8a 54 67 00 00 00 00 3d ad 02 00 00 00 00 00 03 00 30 00 0c 00 00 00" | xxd -r -p > /dev/input/event3
    # Code 0x14a - BTN_TOUCH - press
    echo "fd 8a 54 67 00 00 00 00 3d ad 02 00 00 00 00 00 01 00 4a 01 01 00 00 00" | xxd -r -p > /dev/input/event3
    # Code 0x00 - EV_SYN
    echo "fd 8a 54 67 00 00 00 00 3d ad 02 00 00 00 00 00 00 00 00 00 00 00 00 00" | xxd -r -p > /dev/input/event3

    # Code 0x35 - Center X touch position
    echo "fd 8a 54 67 00 00 00 00 3f e1 03 00 00 00 00 00 03 00 35 00 2e 05 00 00" | xxd -r -p > /dev/input/event3
    # Code 0x00 - EV_SYN
    echo "fd 8a 54 67 00 00 00 00 3f e1 03 00 00 00 00 00 00 00 00 00 00 00 00 00" | xxd -r -p > /dev/input/event3

    # Code 0x39 - Unique ID of initiated contact 
    echo "fd 8a 54 67 00 00 00 00 1c 07 04 00 00 00 00 00 03 00 39 00 ff ff ff ff" | xxd -r -p > /dev/input/event3
    # Code 0x14a - BTN_TOUCH - release
    echo "fd 8a 54 67 00 00 00 00 1c 07 04 00 00 00 00 00 01 00 4a 01 00 00 00 00" | xxd -r -p > /dev/input/event3
    # Code 0x00 - EV_SYN
    echo "fd 8a 54 67 00 00 00 00 1c 07 04 00 00 00 00 00 00 00 00 00 00 00 00 00" | xxd -r -p > /dev/input/event3
}


swipe_next_page() {
    echo "Swipe next page."

    # Code 0x39 - Unique ID of initiated contact
    echo "fd 8a 54 67 00 00 00 00 3d ad 02 00 00 00 00 00 03 00 39 00 91 01 00 00" | xxd -r -p > /dev/input/event3
    # Code 0x35 - Center X touch position
    echo "fd 8a 54 67 00 00 00 00 3d ad 02 00 00 00 00 00 03 00 35 00 2e 05 00 00" | xxd -r -p > /dev/input/event3
    # Code 0x36 - Center Y touch position
    echo "fd 8a 54 67 00 00 00 00 3d ad 02 00 00 00 00 00 03 00 36 00 15 07 00 00" | xxd -r -p > /dev/input/event3
    # Code 0x30 - Major axis of touching ellipse
    echo "fd 8a 54 67 00 00 00 00 3d ad 02 00 00 00 00 00 03 00 30 00 0c 00 00 00" | xxd -r -p > /dev/input/event3
    # Code 0x14a - BTN_TOUCH - press
    echo "fd 8a 54 67 00 00 00 00 3d ad 02 00 00 00 00 00 01 00 4a 01 01 00 00 00" | xxd -r -p > /dev/input/event3
    # Code 0x00 - EV_SYN
    echo "fd 8a 54 67 00 00 00 00 3d ad 02 00 00 00 00 00 00 00 00 00 00 00 00 00" | xxd -r -p > /dev/input/event3

    # Code 0x35 - Center X touch position
    echo "fd 8a 54 67 00 00 00 00 3f e1 03 00 00 00 00 00 03 00 35 00 5f 02 00 00" | xxd -r -p > /dev/input/event3
    # Code 0x00 - EV_SYN
    echo "fd 8a 54 67 00 00 00 00 3f e1 03 00 00 00 00 00 00 00 00 00 00 00 00 00" | xxd -r -p > /dev/input/event3

    # Code 0x39 - Unique ID of initiated contact
    echo "fd 8a 54 67 00 00 00 00 1c 07 04 00 00 00 00 00 03 00 39 00 ff ff ff ff" | xxd -r -p > /dev/input/event3
    # Code 0x14a - BTN_TOUCH - release
    echo "fd 8a 54 67 00 00 00 00 1c 07 04 00 00 00 00 00 01 00 4a 01 00 00 00 00" | xxd -r -p > /dev/input/event3
    # Code 0x00 - EV_SYN
    echo "fd 8a 54 67 00 00 00 00 1c 07 04 00 00 00 00 00 00 00 00 00 00 00 00 00" | xxd -r -p > /dev/input/event3
}

main