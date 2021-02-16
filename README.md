RESUMO: Este script faz uma configuração de uma base Wordpress com nginx, usando o AWS RDS, certificado SSL LetsEncrypt com renovaço automática e redirecionamento para HTTPS.

1- cd /tmp && sudo wget https://raw.githubusercontent.com/aldeiacloud/wordpress_nginx_rds_certauto/main/install.sh && sudo chmod +x install.sh && sudo ./install.sh

2- ABRIR CONFIGURAÇÃO INICIAL DO WORDPRESS COLOCANDO O IP PUBLICO NO NAVEGADOR 

- Database Name: Initial database name configurado (Ex.: aldeiacloud_db)

- Username: usuario do banco (Ex.: admin)

- Password: senha do usuário do banco

- Database Host: endpoint do banco

- Table Prefix: MANTENHA O QUE ESTÁ

-> Instalar/Submit

3- LOGAR, ALTERAR O DOMINIO NAS CONFIGURAÇÕES DO WORDPRESS, DO SEU HTTP//:ip-publico para HTTPS://DOMINIO.com.br

4- NO TERMINAL, ALTERAR QUINTA LINHA "server_name _;" para "server_name seudominio.com.br;"
- vim /etc/nginx/sites-enabled/wordpress

4- INSTALAR CERTIFICADO (REDIRECT)
- sudo certbot --nginx
