# Script de Provisionamento - Desafio DIO Linux

![GitHub last commit](https://img.shields.io/github/last-commit/sergiorbcruz88/linux-projeto1-iac)
![GitHub repo size](https://img.shields.io/github/repo-size/sergiorbcruz88/linux-projeto1-iac)

Script de provisionamento de diretórios, grupos e usuários desenvolvido como desafio do curso de Linux Iniciante da DIO.

## 📋 Funcionalidades

- Cria estrutura de diretórios:
  - `/publico`
  - `/adm`
  - `/ven` 
  - `/sec`
- Cria grupos:
  - `GRP_ADM`
  - `GRP_VEN`
  - `GRP_SEC`
- Cria usuários e associa aos grupos correspondentes
- Configura permissões automáticas

## 🚀 Como Usar

### Pré-requisitos
- Container Docker com imagem Ubuntu

### ⚡ Execução Rápida
```bash
docker run -it --name test-script --rm ubuntu:22.04 bash -c "
apt-get update -qq && apt-get install -y -qq wget &&
wget -q https://raw.githubusercontent.com/sergiorbcruz88/linux-projeto1-iac/main/iac1.sh -O iac1.sh &&
chmod +x iac1.sh && ./iac1.sh && bash"
