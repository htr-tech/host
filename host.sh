#!/bin/bash

##   Host 	    : 	Expose your Localhost :) Temporary File hosting using Ngrok
##   Author 	: 	TAHMID RAYAT
##   Version 	: 	2.1
##   Github 	: 	https://github.com/htr-tech

## If you Copy Then Give the credits :)

##                   GNU GENERAL PUBLIC LICENSE
##                    Version 3, 29 June 2007
##
##    Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
##    Everyone is permitted to copy and distribute verbatim copies
##    of this license document, but changing it is not allowed.
##
##                         Preamble
##
##    The GNU General Public License is a free, copyleft license for
##    software and other kinds of works.
##
##    The licenses for most software and other practical works are designed
##    to take away your freedom to share and change the works.  By contrast,
##    the GNU General Public License is intended to guarantee your freedom to
##    share and change all versions of a program--to make sure it remains free
##    software for all its users.  We, the Free Software Foundation, use the
##    GNU General Public License for most of our software; it applies also to
##    any other work released this way by its authors.  You can apply it to
##    your programs, too.
##
##    When we speak of free software, we are referring to freedom, not
##    price.  Our General Public Licenses are designed to make sure that you
##    have the freedom to distribute copies of free software (and charge for
##    them if you wish), that you receive source code or can get it if you
##    want it, that you can change the software or use pieces of it in new
##    free programs, and that you know you can do these things.
##
##    To protect your rights, we need to prevent others from denying you
##    these rights or asking you to surrender the rights.  Therefore, you have
##    certain responsibilities if you distribute copies of the software, or if
##    you modify it: responsibilities to respect the freedom of others.
##
##    For example, if you distribute copies of such a program, whether
##    gratis or for a fee, you must pass on to the recipients the same
##    freedoms that you received.  You must make sure that they, too, receive
##    or can get the source code.  And you must show them these terms so they
##    know their rights.
##
##    Developers that use the GNU GPL protect your rights with two steps:
##    (1) assert copyright on the software, and (2) offer you this License
##    giving you legal permission to copy, distribute and/or modify it.
##
##    For the developers' and authors' protection, the GPL clearly explains
##    that there is no warranty for this free software.  For both users' and
##    authors' sake, the GPL requires that modified versions be marked as
##    changed, so that their problems will not be attributed erroneously to
##    authors of previous versions.
##
##    Some devices are designed to deny users access to install or run
##    modified versions of the software inside them, although the manufacturer
##    can do so.  This is fundamentally incompatible with the aim of
##    protecting users' freedom to change the software.  The systematic
##    pattern of such abuse occurs in the area of products for individuals to
##    use, which is precisely where it is most unacceptable.  Therefore, we
##    have designed this version of the GPL to prohibit the practice for those
##    products.  If such problems arise substantially in other domains, we
##    stand ready to extend this provision to those domains in future versions
##    of the GPL, as needed to protect the freedom of users.
##
##    Finally, every program is threatened constantly by software patents.
##    States should not allow patents to restrict development and use of
##    software on general-purpose computers, but in those that do, we wish to
##    avoid the special danger that patents applied to a free program could
##    make it effectively proprietary.  To prevent this, the GPL assures that
##    patents cannot be used to render the program non-free.
##
##    The precise terms and conditions for copying, distribution and
##    modification follow.
##
##      Copyright (C) 2021  HTR-TECH (https://github.com/htr-tech)
##

# Deafult Port
def_port='8080'

# Color Codes
CR=$'\e[1;31m' CG=$'\e[1;32m' CY=$'\e[1;33m' CB=$'\e[1;34m' CC=$'\e[1;36m' CW=$'\e[1;37m' RS=$'\e[1;0m'

architecture=`uname -m`

# Terminate Program
terminated() {
    printf "\n\n${RS} ${CR}[${CW}!${CR}]${CY} Program Interrupted ${CR}[${CW}!${CR}]${RS}\n"
    exit 1
}

trap terminated SIGTERM
trap terminated SIGINT

kill_pid() {
	if [[ `pidof php` ]]; then
		killall php > /dev/null 2>&1
	fi
	if [[ `pidof ngrok` ]]; then
		killall ngrok > /dev/null 2>&1
	fi
}


# Host Banner
logo(){

clear
echo "${CY}     _    _           _
${CY}    | |  | |  ${CC}V${CB}-${CG}2.1${CY}  | |
${CG}    | |__| | ___  ___| |_
${CG}    |  __  |/ _ \/ __| __|
${CY}    | |  | | (_) \__ \ |_
${CY}    |_|  |_|\___/|___/\__|
${RS}
${CR} [${CW}~${CR}]${CY} Created By HTR-TECH ${CG}(${CC}Tahmid Rayat${CG})${RS}"

}

path(){

    printf "\n${RS} ${CR}[${CW}1${CR}]${CY} Use Current Path [host/htdocs]"
    printf "\n${RS} ${CR}[${CW}2${CR}]${CY} Setup a Path"
    printf "\n${RS}"
    printf "\n${RS} ${CR}[${CW}-${CR}]${CG} Select A Hosting option: ${CC}"
    read red_path

    if [[ $red_path == 1 || $red_path == 01 ]]; then
        path=$'./htdocs'
    elif [[ $red_path == 2 || $red_path == 02 ]]; then
        printf "\n${RS} ${CC}Enter File Path [Example : /home/tahmid/htdocs]"
        printf "\n${RS}"
        printf "\n${RS} ${CR}>>${CG} ${CC}"
        read path
    else
        printf "\n${RS} ${CR}[${CW}!${CR}]${CY} Invalid option ${CR}[${CW}!${CR}]${RS}\n"
        sleep 2 ; logo ; path
    fi

    if [[ ! -d "$path" ]]; then
	    mkdir -p "$path"
    fi

    menu

}

package(){

	printf "\n${RS} ${CR}[${CW}-${CR}]${CG} Setting up Environment..${RS}"

    if [[ -d "/data/data/com.termux/files/home" ]]; then
        if [[ `command -v proot` ]]; then
            printf ''
        else
			printf "\n${RS} ${CR}[${CW}-${CR}]${CG} Installing ${CY}Proot${RS}\n"
            pkg install proot resolv-conf -y
        fi
    fi

    if [[ `command -v curl` && `command -v php` && `command -v wget` && `command -v unzip` ]]; then
        printf "\n${RS} ${CR}[${CW}-${CR}]${CG} Environment Setup Completed !${RS}"
    else
        repr=(curl php wget unzip)
        for i in "${repr[@]}"; do
            type -p "$i" &>/dev/null ||
                {
                    printf "\n${RS} ${CR}[${CW}-${CR}]${CG} Installing ${CY}${i}${RS}\n"

                    if [[ `command -v apt` ]]; then
                        apt install "$i" -y
                    elif [[ `command -v apt-get` ]]; then
                        apt-get install "$i" -y
                    elif [[ `command -v pkg` ]]; then
                        pkg install "$i" -y
                    elif [[ `command -v dnf` ]]; then
                        sudo dnf -y install "$i"
                    else
                        printf "\n${RS} ${CR}[${CW}!${CR}]${CY} Unfamiliar Distro ${CR}[${CW}!${CR}]${RS}\n"
                        exit 1
                    fi
                }
        done
    fi

}

localhost() {

    printf "\n${RS} ${CR}[${CW}-${CR}]${CY} Input Port [default:${def_port}]: ${CC}"
    read port
    port="${port:-${def_port}}"
    printf "\n${RS} ${CR}[${CW}-${CR}]${CG} Starting PHP Server on Port ${CY}${port}${RS}\n"
    cd "$path" && php -S 127.0.0.1:"$port" > /dev/null 2>&1 &
    sleep 2
    printf "\n${RS} ${CR}[${CW}-${CR}]${CG} Successfully Hosted at : ${CY}http://127.0.0.1:$port ${RS}"
    printf "\n\n ${CR}[${CW}-${CR}]${CC} Press Ctrl + C to exit.${RS}\n"
    while [ true ]; do
        sleep 0.75
    done

}

install_ngrok() {

    if [[ -e "ngrok" ]]; then
		printf "\n${RS} ${CR}[${CW}-${CR}]${CG} Ngrok already installed.${RS}"
	else
		printf "\n${RS} ${CR}[${CW}-${CR}]${CC} Installing ngrok...${RS}"

		if [[ ("$architecture" == *'arm'*) || ("$architecture" == *'Android'*) ]]; then
			ngrok_file='https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip'
		elif [[ "$architecture" == *'aarch64'* ]]; then
			ngrok_file='https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm64.zip'
		elif [[ "$architecture" == *'x86_64'* ]]; then
			ngrok_file='https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip'
		else
			ngrok_file='https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-386.zip'
		fi

        wget "$ngrok_file" --no-check-certificate > /dev/null 2>&1
        ngrok_deb=`basename $ngrok_file`

    	if [[ -e "$ngrok_deb" ]]; then
		    unzip "$ngrok_deb" > /dev/null 2>&1
		    rm -rf "$ngrok_deb" > /dev/null 2>&1
		    chmod +x ./ngrok > /dev/null 2>&1
        else
            echo -e "\n${RS} ${CR}[${CW}!${CR}]${CY} Error occured, Install Ngrok manually.${RS}"
            exit 1
        fi
    fi

}

ngrok() {

    printf "\n${RS} ${CR}[${CW}-${CR}]${CG} Starting PHP Server on Port ${CY}${def_port}${RS}\n"
    cd "$path" && php -S 127.0.0.1:"$def_port" > /dev/null 2>&1 &
    sleep 1
    printf "\n${RS} ${CR}[${CW}-${CR}]${CG} Launching Ngrok on Port ${CY}${def_port}${RS}"

    if [[ `command -v termux-chroot` ]]; then
        sleep 2 && termux-chroot ./ngrok http 127.0.0.1:"$def_port" > /dev/null 2>&1 &
    else
        sleep 2 && ./ngrok http 127.0.0.1:"$def_port" > /dev/null 2>&1 &
    fi

    sleep 8
    ngrok_url=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9a-z]*\.ngrok.io")
    printf "\n\n${RS} ${CR}[${CW}-${CR}]${CG} Successfully Hosted at : ${CY}${ngrok_url}${RS}"
    printf "\n\n ${CR}[${CW}-${CR}]${CC} Press Ctrl + C to exit.${RS}\n"
    while [ true ]; do
        sleep 0.75
    done

}

menu() {

    echo -e "\n${CR} [${CW}01${CR}]${CG} Localhost ${CR}[${CC}For Devs${CR}]"
	echo -e "${CR} [${CW}02${CR}]${CG} Ngrok.io  ${CR}[${CC}Best${CR}]"

	printf "\n${RS} ${CR}[${CW}-${CR}]${CG} Select an Option: ${CB}"
    read MEW

    if [[ "$MEW" == 1 || "$MEW" == 01 ]]; then
		localhost
	elif [[ "$MEW" == 2 || "$MEW" == 02 ]]; then
        ngrok
	else
		printf "\n${RS} ${CR}[${CW}!${CR}]${CY} Invalid option ${CR}[${CW}!${CR}]${RS}\n"
		sleep 2 ; logo ; path
	fi

}


kill_pid ; package ; install_ngrok ; logo ; path


