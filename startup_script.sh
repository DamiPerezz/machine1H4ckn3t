#!/bin/bash

limpiar(){
    echo "Parando los contenedores, se paciente...";
    sudo docker stop maquina01prueba1 > /dev/null 2>&1
    sudo docker stop maquina01web2 > /dev/null 2>&1
    echo "Contenedores detenidos."

    echo "Eliminando contenedores"
    sudo docker rm maquina01prueba1 
    sudo docker rm maquina01web2

    echo "Eliminando imagenes"
    sudo docker image rm maquina01:beta
    sudo docker image rm maquina01web:2

    echo "Listo, ya puedes cerrar la terminal ;)"
   
    exit 0
}

#Ahora ponemos aqui pa que se activeal pulsar ctrl+c
trap limpiar SIGINT

echo "Iniciando el laboratorio"

if [ "$(whoami)" != "root" ]; then
    echo "Tienes que ejecutar el script como root o usando sudo."
    exit 1
fi

echo "Inicando entorno, no cierres el proceso"
echo "Creando red virtual..."
sudo docker network create --subnet 172.18.0.0/16 DockerRed > /dev/null 2>&1

echo "Iniciando primer host " # API Backend
sudo docker build -t maquina01:beta ./Back-end > /dev/null 2>&1
sudo docker create --name maquina01prueba1 --net DockerRed --ip 172.18.0.5 maquina01:beta > /dev/null 2>&1
sudo docker start maquina01prueba1 > /dev/null 2>&1

echo "Iniciando segundo host  " # Servidor Web
sudo docker build -t maquina01web:2 ./Front-end > /dev/null 2>&1
sudo docker create --name maquina01web2 --net DockerRed --ip 172.18.0.6 maquina01web:2 > /dev/null 2>&1
sudo docker start maquina01web2 > /dev/null 2>&1
echo ""
echo "Ambos contenedores se han iniciado correctamente. "
echo "Laboratorio deplegado, para cerrarlo presiona CTRL+C y espera a que se cierre  "
echo "-------------------------------------------------- "
echo ""
echo "Desplegados 2 hosts en red 172.18.0.0 "
echo "Identificalos, atacalos y consigue 2 flags "
echo "Buena suerte "
echo ""
echo "-------------------------------------------------- "
echo ""
echo "Machine made by dpmcyber for H4ckn3t Team :) "
echo "Team contact: https://linktr.ee/h4ckn3t "


#Para mantener el script esperando a que pulse en SIGINT
while true; do
    sleep 1
done