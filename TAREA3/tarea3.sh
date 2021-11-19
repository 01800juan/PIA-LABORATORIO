#!/bin/bash
TODAY=$(date +"Today is  %A, %d  %B of %Y  %r")
echo $TODAY
echo -----------------
echo Menu principal 
echo Elaborado por Juan Facundo
echo -----------------
PS3='Selecciona una opcion(1-4): '
options=("Equipos Activos" "Puertos Equipo" "Equipo" "Salir")
select opt in "${options[@]}"
do
    case $opt in
        "Equipos Activos")

which ifconfig && { echo "Comando ifconfig existe...";
                    direccion_ip= `hostname -I`;
                    echo "Esta es tu direccion ip: $direccion_ip";
                    subred=`hostname -I |awk -F. '{print $1"."$2"."$3"."}'`;
                    echo " Esta es tu subred: "$subred;
                    }\
                || { echo "No existe el comando ifconfig...usando ip";
                    direccion_ip=`ip addr show |grep inet| grep -v "127.0.0.1" |awk '{ print $2}'`;
                    echo "Esta es tu direccion ip: "$direcion_ip;
                    subred=`ip addr show |grep inet | grep -v "127.0.0.1" |awk '{ print $2}'|awk -F. '{print $1"."$2"."$3"."}'`;
                    echo "Esta es tu subred: "$subred;
                    }
for ip in {1..254}
do
    ping -q -c 4 ${subred}${ip} > /dev/null
    if [ $? -eq 0 ]
    then
        echo "Host responde: "${subred}${ip}
    fi
done          
            ;;
            
            
            
        "Puertos Equipo")
               
function is_alive_ping() { 
  ping -c 1 $1 > /dev/null 2>&1 
  [ $? -eq 0 ] && echo "Node with IP: $i is up."
     host=$1
      for ((counter=10; counter<=500; counter++))
      do
        (echo >/dev/tcp/$host/$counter) > /dev/null 2>&1 && echo "$counter open in IP $i"
      done
} 
for i in 10.0.2.{1..255} 
do 
  is_alive_ping $i & disown 
done
             ;;
            
            
            
        "Equipo")
            echo $USER
            echo $HOSTNAME
            echo $OSTYPE
            ;;
        "Salir")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done