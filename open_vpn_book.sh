#!/bin/bash
clear



green='\033[1;32m'
white='\e[1;37m'
red='\e[1;31m'
reset='\033[0m'


if ! [[ $(whoami) == "root" ]]; then
	sudo $0
fi



############# FUNCTIONS ##############
 trap ctrl_c INT
 function ctrl_c() {
 	clear
 	echo "Killing proccess..."
 	kill -9 $(ps x | grep "openvpn" | head -1 | awk {'printf $1'}) &> /dev/null
       exit 1
}

if ! [[ /usr/sbin/openvpn ]]; then
	echo "you need to install openvpn.. apt install openvpn -y"
	exit 1
fi

if ! [[ /usr/bin/gocr ]]; then
	echo "you need to install gocr.. apt install gocr"
	exit 1
fi
if ! [[ /usr/bin/wget ]]; then
	echo "you need to install wget.. apt install wget -y"
	exit 1
fi
if ! [[ /usr/bin/curl ]]; then
	echo "you need to install curl.. apt install curl -y "
	exit 1
fi
if ! [[ /usr/bin/awk ]]; then
	echo "you need to install awk.. apt install awk -y "
	exit 1
fi
if ! [[ /usr/bin/grep ]]; then
	echo "you need to install grep... apt install grep -y "
	exit 1
fi
if ! [[ /usr/bin/head ]]; then
	echo "you need to install head... apt install head -y "
	exit 1
fi
if ! [[ /usr/bin/tail ]]; then
	echo "you need to install tail... apt install tail -y "
	exit 1
fi
if ! [[ /usr/bin/sed ]]; then
	echo "you need to install sed... apt install sed -y "
	exit 1
fi

if [[ -d /opt/vcon ]]; then
	rm -rf /opt/vcon
fi



	


########################################################################################################################
echo -e "${white}=====\nINFO:\t *_~ \t${red}OPEN_${green}VPN${red}_BOOK${white} \n=====${reset}"
echo "Downloading OVPN files"
cd /opt
mkdir vcon
cd vcon

vpndir='/opt/vcon'

mkdir cryptostorm
cd cryptostorm
wget https://raw.githubusercontent.com/cryptostorm/cryptostorm_client_configuration_files/master/cryptofree/cryptofree_rsa-tcp.ovpn &> /dev/null

cd ..
mkdir cred && cd cred

echo -e "test\ntest" > credentials_cryptofree
cd $vpndir/cryptostorm
sed -i 's/auth-user-pass/auth-user-pass \/usr\/bin\/vcon\/cred\/credentials_cryptofree/g' cryptofree_rsa-tcp.ovpn
echo "Done"
sleep 0.3

########################################################################################################################






cd ../

wget -r -np -l 1 -A zip http://www.vpnbook.com/#openvpn --no-check-certificate 2> /dev/null
mv www.vpnbook.com/free-openvpn-account/ vpnbook
rm -rf www.vpnbook.com/
cd vpnbook/
echo "Extracting files" 
sleep 0.3
num=$(ls -l | grep ^- | wc -l)
{ 
echo $(ls | sed 's/zip*.//g' | sed 's/.*-//g' | tr '.' ' ') > names
sed -i 's/ /\n/g' names 
mkdir $(for ((i=1;i<=$num;i++));do ls | head -$i | tail -1 | sed 's/.zip//g'; done)
ls | grep ".zip" > zips

for ((i=1;i<$num; i++)); do unzip -o $(cat zips | head -$i | tail -1) -d $(cat names | head -$i | tail -1); done
} &> /dev/null
echo  "Extracted Successfully" 
echo "====================="
rm -rf *.zip
rm -rf VPN*
rm -rf zips

	cd ../cred
	
	wget https://www.vpnbook.com/password.php?t=0.46027100%201541523012 -O a.png &> /dev/null && echo -e "vpnbook\n$(gocr a.png)" > credentials_vpnbook && sed -i 's/auth-user-pass/auth-user-pass  \.\.\/cred\/credentials_vpnbook/g' $vpndir/vpnbook/*/*.ovpn
	rm -rf a.png








########################################################################################################################
echo "Downloading Passwords..."
cd $vpndir

wget https://freevpn.me/FreeVPN.me-OpenVPN-Bundle.zip &> /dev/null
unzip FreeVPN.me-OpenVPN-Bundle.zip &> /dev/null
cd FreeVPN.me-OpenVPN-Bundle/
ls | grep "Fr*" > dom
sed -i 's/.*\.//g' dom
for ((i=1;i<=$(cat dom | wc -l);i++));do mv $i* $(cat dom|head -$i | tail -1);done
cd be 

echo -e "freevpnbe\n$(curl -s https://freevpn.be/accounts/ | grep "<li>" | grep -o -P 'rd:</b>.{0,13}' | head -1 |awk {'printf $2'})" > ../../cred/credential_FreeVPN_be
sed -i 's/auth-user-pass/auth-user-pass \.\.\/cred\/credential_FreeVPN_be/g' *.ovpn
sleep 1
cd ..
cd im
echo -e "freevpnim\n$(curl -s https://freevpn.im/accounts/ | grep "<li>" | grep -o -P 'rd:</b>.{0,13}' | head -1 |awk {'printf $2'})" > ../../cred/credential_FreeVPN_im
sed -i 's/auth-user-pass/auth-user-pass \.\.\/cred\/credential_FreeVPN_im/g' *.ovpn
cd ..
cd it 
echo -e "freevpnit\n$(curl -s https://freevpn.it/accounts/ | grep "<li>" | grep -o -P 'rd:</b>.{0,13}' | head -1 |awk {'printf $2'})" > ../../cred/credential_FreeVPN_it
sed -i 's/auth-user-pass/auth-user-pass \.\.\/cred\/credential_FreeVPN_it/g' *.ovpn
cd ..
cd me 
echo -e "freevpnme\n$(curl -s https://freevpn.me/accounts/ | grep "<li>" | grep -o -P 'rd:</b>.{0,13}' | head -1 |awk {'printf $2'})" > ../../cred/credential_FreeVPN_me
sed -i 's/auth-user-pass/auth-user-pass \.\.\/cred\/credential_FreeVPN_me/g' *.ovpn
cd ..
cd se
echo -e "freevpnse\n$(curl -s https://freevpn.se/accounts/ | grep "<li>" | grep -o -P 'rd:</b>.{0,13}' | head -1 |awk {'printf $2'})" > ../../cred/credential_FreeVPN_se
sed -i 's/auth-user-pass/auth-user-pass \.\.\/cred\/credential_FreeVPN_se/g' *.ovpn
cd ..
cd uk 
echo -e "freevpncouk\n$(curl -s https://freevpn.co.uk/accounts/ | grep "<li>" | grep -o -P 'rd:</b>.{0,13}' | head -1 |awk {'printf $2'})" > ../../cred/credential_FreeVPN_uk
sed -i 's/auth-user-pass/auth-user-pass \.\.\/cred\/credential_FreeVPN_uk/g' *.ovpn


cd ../../


rm -rf *.zip




cd $vpndir
echo "Collecting available service names together..."
sleep 0.3
ls cryptostorm/ | tail -1 >> av.list
cd Free*
for ((i=1;i<=6;i++)); do ls "$(cat dom | head -$i | tail -1)" | grep "ovpn" >> ../av.list;done
cd ../vpnbook
for ((i=1;i<=5;i++)); do ls "$(cat names| head -$i | tail -1)" | grep "ovpn" >> ../av.list;done








totalnum=$(cd $vpndir && cat -b av.list | tail -1 | awk {'printf $1'})
	random=$(($(echo $[$RANDOM % $totalnum])+1))
	

clear




cd $vpndir
mkdir con
cd cry*
cp * ../con/
cd ../Free*
rm -rf dom
cp */* ../con/
cd ../vpnb*
cp */* ../con
cd ../con/..
rm -rf cryptostorm FreeVPN.me-OpenVPN-Bundle vpnbook
cd con



if [[ $1 == "-v" ]] || [[ $1 == "--verbose" ]]; then
  openvpn --config $(cat -b $vpndir/av.list | head -$random | tail -1 | awk {'printf $2'}) # &> /dev/null
else 
	echo -e "${white}*_~ \t${red}OPEN_${green}VPN${red}_BOOK${reset}\n   ${green}Service Started${reset}"
	openvpn --config $(cat -b $vpndir/av.list | head -$random | tail -1 | awk {'printf $2'}) &> /dev/null
fi

