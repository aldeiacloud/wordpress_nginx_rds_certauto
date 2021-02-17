#!/bin/bash
# ATUALIZAR REPO
sudo apt update -y 
# INSTALAR NGINX
sudo apt install -y nginx
# INSTALAR ~PHP
sudo apt install -y php-fpm php-mysql
# ADICIONAR REPO ~LETSENCRYPT E ATUALIZAR
sudo install -y software-properties-common 
sudo apt update -y 
# INSTALAR CERTBOT
sudo apt install -y certbot 
# INSTALAR PYTHON CERTBOT
sudo apt install -y python-certbot-nginx 
# BAIXAR CONFIGURAÇÃO BASE DO WORDPRESS PARA NGINX
wget https://raw.githubusercontent.com/aldeiacloud/wordpress_nginx_rds_certauto/main/default.conf
# COPIAR ARQUIVO DE CONFIGURACAO PARA "SITES AVAILABLE"
sudo cp default.conf /etc/nginx/sites-available/wordpress
# CRIANDO LINK DA CONFIGURAÇÃO PARA "SITES ENABLED"
sudo ln -s /etc/nginx/sites-available/wordpress /etc/nginx/sites-enabled/
# UNLINK DEFAULT
sudo unlink /etc/nginx/sites-enabled/default
# ABRIR PASTA TEMPORARIA
cd /tmp
# BAIXAR ULTIMA VERSAO DO WORDPRESS
curl -LO https://wordpress.org/latest.tar.gz
# DESCOMPACTAR PASTA DO WORDPRESS
tar xzvf latest.tar.gz
# COPIAR ARQUIVOS DO WORDPRESS PARA PASTA PADRÃO DO NGINX
sudo cp -a /tmp/wordpress/. /var/www/html
# TROCANDO DONO E GRUPO DA PASTA, PARA WWW-DATA (WORDRPRESS)
sudo chown -R www-data:www-data /var/www/html
# REINICIANDO O PHP
sudo systemctl restart php7.2-fpm
# REINICIANDO CONFIGURACOES DO NGINX
sudo systemctl reload nginx
# HABILITANDO NGINX PARA INICIAR COM SISTEMA OPERACIONAL
sudo systemctl enable nginx
# CONFIGURAR HORARIO (BUENOS AIRES = BRASILIA SEM HORARIO DE VERAO)
timedatectl set-timezone America/Argentina/Buenos_Aires
# CRIAR SWAP (MEMORIA DE ESCAPE)
sudo fallocate -l 2G /swapfile
# ATRIBUINDO ELEITURA E ESCRITA PARA O DONO E NADA PARA GRUPO E OUTROS
sudo chmod 600 /swapfile
# MONTANDO SWAP NO ARQUIVO CRIADO
sudo mkswap /swapfile
# SUBINDO SWAP
sudo swapon /swapfile
# ADICIONANDO SWAP NO FSTAB PARA INICIAR COM SISTEMA OPERACIONAL
echo "/swapfile swap swap defaults 0 0" >> /etc/fstab
# ADICIONAR RENOVAÇÃO AUTOMATICA DO CERTIFICADO
echo "SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

0 */12 * * * root certbot -q renew --nginx" >> /etc/cron.d/certbot
