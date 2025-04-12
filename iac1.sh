#!/bin/bash

# Script de provisionamento de diretórios, grupos e usuários
# Autor: Sérgio R. B. Cruz
# Data: 12 de abril de 2025


# Esse script foi executado em uma máquina docker com os seguintes comandos:
# docker run -it --name test-script --rm ubuntu:22.04 bash


# Em um outro terminal faça a cópia desse script para o container que já está em execução:
# docker cp provisionamento.sh test-script:/provisionamento.sh
 

# Verifica se o script está sendo executado como root
if [ "$(id -u)" != "0" ]; then
    echo "Este script deve ser executado como root!" 1>&2
    exit 1
fi

echo -n "Removendo configurações anteriores... "

# A primeira parte do script remove qualquer configuração de 
# usuário, grupo e diretório que possa existir
rm -rf /publico /adm /ven /sec 2> /dev/null

for user in carlos maria joao debora sebastiana roberto josefina amanda rogerio; do
    userdel -r "$user" 2> /dev/null
done

groupdel GRP_ADM 2> /dev/null
groupdel GRP_VEN 2> /dev/null
groupdel GRP_SEC 2> /dev/null

echo "Feito"

# A segunda parte do script de provisionamento cria 
# os usuários, grupos e diretório

echo -n "Criando diretórios... "
mkdir /publico
mkdir /adm
mkdir /ven
mkdir /sec
echo "Feito"

echo -n "Criando grupos... "
groupadd GRP_ADM
groupadd GRP_VEN
groupadd GRP_SEC
echo "Feito"

# Verificando se o OpenSSL está instalado para criptografar as senhas dos usuários
echo -n "Verificando instalação do OpenSSL..."
if apt list --installed 2>/dev/null | grep -q openssl; then
    echo " (já instalado)"
else
    apt-get update -y >/dev/null
    apt-get install -y openssl >/dev/null 2>&1 && echo " Instalado!" || echo " Falhou!"
fi

echo -n "Criando usuários... "
# Usuários do grupo GRP_ADM
useradd carlos -m -s /bin/bash -p $(openssl passwd -6 Senha123) -G GRP_ADM
useradd maria -m -s /bin/bash -p $(openssl passwd -6 Senha123) -G GRP_ADM
useradd joao -m -s /bin/bash -p $(openssl passwd -6 Senha123) -G GRP_ADM

# Usuários do grupo GRP_VEN
useradd debora -m -s /bin/bash -p $(openssl passwd -6 Senha123) -G GRP_VEN
useradd sebastiana -m -s /bin/bash -p $(openssl passwd -6 Senha123) -G GRP_VEN
useradd roberto -m -s /bin/bash -p $(openssl passwd -6 Senha123) -G GRP_VEN

# Usuários do grupo GRP_SEC
useradd josefina -m -s /bin/bash -p $(openssl passwd -6 Senha123) -G GRP_SEC
useradd amanda -m -s /bin/bash -p $(openssl passwd -6 Senha123) -G GRP_SEC
useradd rogerio -m -s /bin/bash -p $(openssl passwd -6 Senha123) -G GRP_SEC

# Configurando propriedade e permissões de diretórios, grupos e usuários
echo "Feito"


echo -n "Configurando propriedades e permissões... "

chmod 777 /publico
chown root:root /publico

chown root:GRP_ADM /adm
chown root:GRP_VEN /ven
chown root:GRP_SEC /sec

chmod 770 /adm
chmod 770 /ven
chmod 770 /sec

echo "Feito"

echo "Provisionamento concluído com \e[32msucesso!\e[0m" 
