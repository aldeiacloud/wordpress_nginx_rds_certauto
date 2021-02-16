RESUMO: Este script faz uma configuração de uma base Wordpress com Nginx, utilizando o AWS RDS como database. Contém certificado SSL LetsEncrypt com renovaço automática e redirecionamento para HTTPS.</b2>

  Extras:
  - Altera o horário do Ubuntu para -3 UTC;
  - Configura 2GB de Swap e adiciona no fstab.

------------------------------------------------------------------------------

1- NA CAIXA DE DIÁLOGO AO FINAL DA CONFIGURAÇÃO DE AZ DA EC2, ADICIONAR:

#!/bin/bash

cd /tmp 

sudo wget https://raw.githubusercontent.com/aldeiacloud/wordpress_nginx_rds_certauto/main/install.sh 

sudo chmod +x install.sh 

sudo ./install.sh


2- ABRIR CONFIGURAÇÃO INICIAL DO WORDPRESS COLOCANDO O IP PUBLICO NO NAVEGADOR 

- Database Name: Initial database name configurado (Ex.: aldeiacloud_db)

- Username: usuario do banco (Ex.: admin)

- Password: senha do usuário do banco

- Database Host: endpoint do banco

- Table Prefix: MANTENHA O QUE ESTÁ

-> Instalar/Submit


3- LOGAR, ALTERAR O DOMINIO NAS CONFIGURAÇÕES DO WORDPRESS, DO SEU HTTP//:ip-publico para HTTPS://seudominio.com.br


4- NO TERMINAL, ALTERAR QUINTA LINHA "server_name _;" para "server_name seudominio.com.br;"
- sudo vim /etc/nginx/sites-enabled/wordpress


4- INSTALAR CERTIFICADO (REDIRECT)
- sudo certbot --nginx
