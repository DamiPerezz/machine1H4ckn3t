#!/bin/bash

limpiar(){
    echo "Parando los contenedores, se paciente...";
    sudo docker stop maquina01prueba1
    sudo docker stop maquina01web2
    echo "Contenedores detenidos."

    echo "Eliminando contenedores"
    sudo docker rm maquina01prueba1
    sudo docker rm maquina01web2
    echo "Eliminando contenedores"
    sudo docker rm maquina01prueba1
    sudo docker rm maquina01web2

    echo "Eliminando imagenes"
    sudo docker image rm maquina01:beta
    sudo docker image rm maquina01web:2

   
    exit 0
}

#Ahora ponemos aqui pa que se activeal pulsar ctrl+c
trap limpiar SIGINT

echo "Iniciando el laboratorio"

if [ "$(whoami)" != "root" ]; then
    echo "Tienes que ejecutar el script como root o usando sudo."
    exit 1
fi

echo "Creadno red virtual"

sudo docker network create --subnet 172.18.0.0/16 DockerRed

echo "Iniciando primer host (Backend API)"
sudo docker build -t maquina01:beta ./Back-end
sudo docker create --name maquina01prueba1 --net DockerRed --ip 172.18.0.5 maquina01:beta
sudo docker start maquina01prueba1

echo "Iniciando segundo host (Servidor Web Frontend)"
sudo docker build -t maquina01web:2 ./Front-end
sudo docker create --name maquina01web2 --net DockerRed --ip 172.18.0.6 maquina01web:2
sudo docker start maquina01web2

echo "Ambos contenedores se han iniciado correctamente."

#Para mantener el script esperando a que pulse en SIGINT
while true; do
    sleep 1
done