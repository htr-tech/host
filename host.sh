# Host V_1.1
# ==============================================
# Created By HTR-TECH @tahmid.rayat
# Instagram : https://instagram.com/tahmid.rayat
# Github : https://github.com/htr-tech/
# ==============================================
# Don't Copy my Work . If you Copy Then Give me credits...
#!/bin/bash

trap 'printf "\n";stop;exit 1' 2

dependencies() {

command -v php > /dev/null 2>&1 || { echo >&2 "PHP is not installed ! Install it."; exit 1; }
command -v curl > /dev/null 2>&1 || { echo >&2 "Curl is not installed ! Install it."; exit 1; }
command -v ssh > /dev/null 2>&1 || { echo >&2 "Openssh is not installed ! Install it"; exit 1; }
command -v unzip > /dev/null 2>&1 || { echo >&2 "Unzip is not installed ! Install it"; exit 1; }

}
stop() {

checkngrok=$(ps aux | grep -o "ngrok" | head -n1)
checkphp=$(ps aux | grep -o "php" | head -n1)
checkssh=$(ps aux | grep -o "ssh" | head -n1)
if [[ $checkngrok == *'ngrok'* ]]; then
pkill -f -2 ngrok > /dev/null 2>&1
killall -2 ngrok > /dev/null 2>&1
fi
if [[ $checkphp == *'php'* ]]; then
pkill -f -2 php > /dev/null 2>&1
killall -2 php > /dev/null 2>&1
fi
if [[ $checkssh == *'ssh'* ]]; then
pkill -f -2 ssh > /dev/null 2>&1
killall ssh > /dev/null 2>&1
fi
if [[ -e linksender ]]; then
rm -rf linksender
fi

}
banner() {

clear
printf " \e[33;1m ooooo   ooooo                            0   \e[0m\n"
printf " \e[33;1m  888     888 \e[0m\e[1;96m  # Expose Your Local \e[0m\e[33;1m     o8   \e[0m\n"
printf " \e[33;1m  888     888        .ooooo.   .oooo.o .o888oo \e[0m\n"
printf " \e[32;1m  888ooooo888       d88   88b d888   8   888   \e[0m\n"
printf " \e[32;1m  888     888 88888 888   888   Y88b     888   \e[0m\n"
printf " \e[32;1m  888     888       888   888 o   888b   888   \e[0m\n"
printf " \e[33;1m o888o   o888o       Y8bod8P  8.:888P     8880 \e[1;97m V_1.1\e[0m\n"
printf " \n"
printf " \e[92m[\e[37;1m+\e[92m]\e[33;1m Created by htr-tech (tahmid.rayat)\e[0m\n"
printf " \n"

}
menu(){
if [[ -e htdocs ]]; then
echo ""
else
mkdir htdocs
fi

printf "\n"
printf " \e[96m[\e[0m\e[1;77m01\e[96m]\e[0m\e[1;93m Localhost\e[0m\n"
printf "\e[0m\n"
printf " \e[96m[\e[0m\e[1;77m02\e[96m]\e[0m\e[1;93m Ngrok.io\e[0m\n"
printf "\e[0m\n"
printf " \e[96m[\e[0m\e[1;77m03\e[96m]\e[0m\e[1;93m Serveo.net\e[0m\n"
printf "\e[0m\n"
printf " \e[96m[\e[0m\e[1;77m04\e[96m]\e[0m\e[1;93m Localhost.run\e[0m\n"
d_o_server="3"
printf "\e[0m\n"
read -p $'\e[96m[\e[0m\e[1;77m~\e[96m]\e[0m\e[1;92m Select A Hosting option: \e[0m\e[1;96m\en' option_server
option_server="${option_server:-${d_o_server}}"
if [[ $option_server == 1 || $option_server == 01 ]]; then
start_l
elif [[ $option_server == 2 || $option_server == 02 ]]; then
start_n
elif [[ $option_server == 3 || $option_server == 03 ]]; then
start_s
elif [[ $option_server == 4 || $option_server == 04 ]]; then
start_local
else
printf "\e[1;93m [!] Invalid option [!]\e[0m\n"
sleep 1
banner
menu
fi

}
start_l() {
def_port="5555"
printf "\e[0m\n"
printf '\e[96m[\e[0m\e[1;77m~\e[96m]\e[0m\e[1;92m Select a Port (Default:\e[0m\e[1;96m %s \e[0m\e[1;92m): \e[0m\e[1;96m' $def_port
read port
port="${port:-${def_port}}"
printf "\e[0m\n"
printf "\e[96m[\e[0m\e[1;77m~\e[96m]\e[0m\e[1;92m Initializing...\e[0m\e[1;92m(\e[0m\e[1;96mlocalhost:$port\e[0m\e[1;92m)\e[0m\n"
cd htdocs && php -S 127.0.0.1:$port > /dev/null 2>&1 & 
sleep 2
printf "\e[0m\n"
printf "\n\e[96m[\e[0m\e[1;77m~\e[96m]\e[0m\e[1;92m Successfully Hosted at :\e[0m\e[1;93m http://localhost:$port\e[0m\n"
found
}
start_n() {
if [[ -e ngrok ]]; then
echo ""
else
printf "\e[0m\n"
printf "\e[96m[\e[0m\e[1;77m~\e[96m]\e[0m\e[1;92m Initializing...\e[0m\e[1;92m(\e[0m\e[1;96mlocalhost:5555\e[0m\e[1;92m)\e[0m\n"
arch=$(uname -a | grep -o 'arm' | head -n1)
arch2=$(uname -a | grep -o 'Android' | head -n1)
if [[ $arch == *'arm'* ]] || [[ $arch2 == *'Android'* ]] ; then
curl -LO https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip > /dev/null 2>&1

if [[ -e ngrok-stable-linux-arm.zip ]]; then
unzip ngrok-stable-linux-arm.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-arm.zip
else
printf "\e[1;96m[\e[1;97m!\e[1;96m]\e[1;93m Error \e[1;96m[\e[1;97m!\e[1;96m]\e[1;96m Please Install All Packges.\e[0m\n"
exit 1
fi



else
curl -LO https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-386.zip > /dev/null 2>&1 
if [[ -e ngrok-stable-linux-386.zip ]]; then
unzip ngrok-stable-linux-386.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-386.zip
else
printf "\e[1;96m[\e[1;97m!\e[1;96m]\e[1;93m Error \e[1;96m[\e[1;97m!\e[1;96m]\e[1;96m Please Install All Packges.\e[0m\n"
exit 1
fi
fi
fi

printf "\e[0m\n"
printf "\e[96m[\e[0m\e[1;77m~\e[96m]\e[0m\e[1;92m Launching Ngrok ..\e[0m\n"
cd htdocs && php -S 127.0.0.1:5555 > /dev/null 2>&1 & 
sleep 2
./ngrok http 5555 > /dev/null 2>&1 &
sleep 7

ngrok_link=$(curl -s -N http://127.0.0.1:4041/api/tunnels | grep -o "https://[0-9a-z]*\.ngrok.io")
printf "\n\e[96m[\e[0m\e[1;77m~\e[96m]\e[0m\e[1;92m Successfully Hosted at :\e[0m\e[1;93m %s \n" $ngrok_link
found
}
start_s() {
def_port="5555"
printf "\e[0m\n"
printf '\e[96m[\e[0m\e[1;77m~\e[96m]\e[0m\e[1;92m Select a Port (Default:\e[0m\e[1;96m %s \e[0m\e[1;92m): \e[0m\e[1;96m' $def_port
read port
port="${port:-${def_port}}"
printf "\e[0m\n"
printf "\e[96m[\e[0m\e[1;77m~\e[96m]\e[0m\e[1;92m Initializing...\e[0m\e[1;92m(\e[0m\e[1;96mlocalhost:$port\e[0m\e[1;92m)\e[0m\n"
cd htdocs && php -S 127.0.0.1:$port > /dev/null 2>&1 & 
sleep 2
printf "\e[0m\n"
printf "\e[96m[\e[0m\e[1;77m~\e[96m]\e[0m\e[1;92m Launching Serveo ..\e[0m\n"
if [[ -e linksender ]]; then
rm -rf linksender
fi
$(which sh) -c 'ssh -o StrictHostKeyChecking=no -o ServerAliveInterval=60 -R 80:localhost:'$port' serveo.net 2> /dev/null > linksender ' &
printf "\n"
sleep 7
send_url=$(grep -o "https://[0-9a-z]*\.serveo.net" linksender)
printf '\n\e[96m[\e[0m\e[1;77m~\e[96m]\e[0m\e[1;92m Successfully Hosted at :\e[0m\e[1;93m %s \n' $send_url
found

}
start_local(){
def_port="5555"
printf "\e[0m\n"
printf '\e[96m[\e[0m\e[1;77m~\e[96m]\e[0m\e[1;92m Select a Port (Default:\e[0m\e[1;96m %s \e[0m\e[1;92m): \e[0m\e[1;96m' $def_port
read port
port="${port:-${def_port}}"
printf "\e[0m\n"
printf "\e[96m[\e[0m\e[1;77m~\e[96m]\e[0m\e[1;92m Initializing...\e[0m\e[1;92m(\e[0m\e[1;96mlocalhost:$port\e[0m\e[1;92m)\e[0m\n"
cd htdocs && php -S 127.0.0.1:$port > /dev/null 2>&1 & 
sleep 2
printf "\e[0m\n"
printf "\e[96m[\e[0m\e[1;77m~\e[96m]\e[0m\e[1;92m Launching LocalHostRun ..\e[0m\n"
printf "\n"
if [[ -e linksender ]]; then
rm -rf linksender
fi
printf "\n\e[96m[\e[0m\e[1;77m~\e[96m]\e[0m\e[1;96m Press Ctrl + C to exit.\e[0m\n"
printf "\e[1;93m\n"
ssh -R 80:localhost:$port ssh.localhost.run 2>&1
printf "\e[0m\n"
}

found() {

printf "\n"
printf "\n\e[96m[\e[0m\e[1;77m~\e[96m]\e[0m\e[1;96m Press Ctrl + C to exit.\e[0m\n"
while [ true ]; do


sleep 0.75


done 

}

banner
dependencies
menu