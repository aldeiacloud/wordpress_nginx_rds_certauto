<b>RESUMO: <br>Configuração de uma aplicação Wordpress com Nginx, utilizando o AWS RDS como database. <br>
Contém certificado SSL LetsEncrypt com renovaço automática e redirecionamento para HTTPS.</b>

 <b>Extras:</b>
  - Altera o horário do Ubuntu para GMT-3;
  - Configura 2GB de Swap e adiciona no /etc/fstab.

<b>Vídeo da implementação: www.youtube.com/</b>

------------------------------------------------------------------------------

<b>1-</b> NA CAIXA DE DIÁLOGO AO <b>FINAL DA PÁGINA</b> DE CONFIGURAÇÃO DE ZONA/VPC DA EC2, ADICIONAR:

#!/bin/bash<br>
cd /tmp<br>
sudo wget https://raw.githubusercontent.com/aldeiacloud/wordpress_nginx_rds_certauto/main/install.sh<br>
sudo chmod +x install.sh<br>
sudo ./install.sh<br>

------------------------------------------------------------------------------

<b>2-</b> ABRIR CONFIGURAÇÃO INICIAL DO WORDPRESS COLOCANDO O IP PUBLICO NO NAVEGADOR:

- Database Name: Initial database name configurado (Ex.: aldeiacloud_db)

- Username: usuario do banco (Ex.: admin)

- Password: senha do usuário do banco

- Database Host: endpoint do banco

- Table Prefix: MANTENHA O QUE ESTÁ

<b>-> Instalar/Submit</b>

------------------------------------------------------------------------------

<b>3-</b> LOGAR, ALTERAR O DOMINIO NAS CONFIGURAÇÕES DO WORDPRESS:<br>
de: HTTP//:ip-publico para HTTPS://seudominio.com.br

------------------------------------------------------------------------------

<b>4-</b> NO TERMINAL, ALTERAR QUINTA LINHA: | "<i>server_name _;</i>" para "<i>server_name seudominio.com.br www.seudominio.com.br;</i>"
- sudo vim /etc/nginx/sites-available/wordpress

------------------------------------------------------------------------------

<b>4-</b> INSTALAR CERTIFICADO: (2- Redirect)
- sudo certbot --nginx
