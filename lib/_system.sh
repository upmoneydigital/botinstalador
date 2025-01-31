#!/bin/bash
# 
# system management

#######################################
# creates user
# Arguments:
#   None
#######################################
system_create_user() {
  print_banner
  printf "${WHITE} 💻 Agora, vamos criar o usuário para deployzdg...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  useradd -m -p $(openssl passwd $deploy_password) -s /bin/bash -G sudo deployzdg
  usermod -aG sudo deployzdg
  mv "${PROJECT_ROOT}"/whaticket.zip /home/deployzdg/
EOF

  sleep 2
}

#######################################
# unzip whaticket
# Arguments:
#   None
#######################################
system_unzip_whaticket() {
  print_banner
  printf "${WHITE} 💻 Fazendo unzip whaticket...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - deployzdg <<EOF
  unzip whaticket.zip
EOF

  sleep 2
}

#######################################
# updates system
# Arguments:
#   None
#######################################
system_update() {
  print_banner
  printf "${WHITE} 💻 Vamos atualizar o sistema...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  apt -y update && apt -y upgrade
EOF

  sleep 2
}

#######################################
# installs node
# Arguments:
#   None
#######################################
system_node_install() {
  print_banner
  printf "${WHITE} 💻 Instalando nodejs...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
  apt-get install -y nodejs
EOF

  sleep 2
}

#######################################
# installs mysql
# Arguments:
#   None
#######################################
system_mysql_install() {
  print_banner
  printf "${WHITE} 💻 Instalando mysql...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  apt install -y mysql-server
EOF

  sleep 2
}

#######################################
# Ask for file location containing
# multiple URL for streaming.
# Globals:
#   WHITE
#   GRAY_LIGHT
#   BATCH_DIR
#   PROJECT_ROOT
# Arguments:
#   None
#######################################
system_puppeteer_dependencies() {
  print_banner
  printf "${WHITE} 💻 Instalando puppeteer dependencies...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  apt-get install -y libxshmfence-dev \
                      libgbm-dev \
                      wget \
                      unzip \
                      fontconfig \
                      locales \
                      gconf-service \
                      libasound2 \
                      libatk1.0-0 \
                      libc6 \
                      libcairo2 \
                      libcups2 \
                      libdbus-1-3 \
                      libexpat1 \
                      libfontconfig1 \
                      libgcc1 \
                      libgconf-2-4 \
                      libgdk-pixbuf2.0-0 \
                      libglib2.0-0 \
                      libgtk-3-0 \
                      libnspr4 \
                      libpango-1.0-0 \
                      libpangocairo-1.0-0 \
                      libstdc++6 \
                      libx11-6 \
                      libx11-xcb1 \
                      libxcb1 \
                      libxcomposite1 \
                      libxcursor1 \
                      libxdamage1 \
                      libxext6 \
                      libxfixes3 \
                      libxi6 \
                      libxrandr2 \
                      libxrender1 \
                      libxss1 \
                      libxtst6 \
                      ca-certificates \
                      fonts-liberation \
                      libappindicator1 \
                      libnss3 \
                      lsb-release \
                      xdg-utils \
                      ffmpeg \
					  git
EOF

  sleep 2
}

#######################################
# installs pm2
# Arguments:
#   None
#######################################
system_pm2_install() {
  print_banner
  printf "${WHITE} 💻 Instalando pm2...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  npm install -g pm2
  pm2 startup ubuntu -u deployzdg
  env PATH=\$PATH:/usr/bin pm2 startup ubuntu -u deployzdg --hp /home/deployzdg
EOF

  sleep 2
}

#######################################
# set timezone
# Arguments:
#   None
#######################################
system_set_timezone() {
  print_banner
  printf "${WHITE} 💻 Instalando pm2...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  timedatectl set-timezone America/Sao_Paulo
EOF

  sleep 2
}

#######################################
# set ufw
# Arguments:
#   None
#######################################
system_set_ufw() {
  print_banner
  printf "${WHITE} 💻 Instalando pm2...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  ufw allow 80/tcp && ufw allow 22/tcp && ufw allow 443/tcp && ufw allow 8080/tcp && ufw allow 8081/tcp && ufw allow 3000/tcp && ufw allow 3333/tcp && ufw allow 3003/tcp
EOF

  sleep 2
}

#######################################
# installs snapd
# Arguments:
#   None
#######################################
system_snapd_install() {
  print_banner
  printf "${WHITE} 💻 Instalando snapd...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  apt install -y snapd
  snap install core
  snap refresh core
EOF

  sleep 2
}

#######################################
# installs certbot
# Arguments:
#   None
#######################################
system_certbot_install() {
  print_banner
  printf "${WHITE} 💻 Instalando certbot...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  apt-get remove certbot
  snap install --classic certbot
  ln -s /snap/bin/certbot /usr/bin/certbot
EOF

  sleep 2
}

#######################################
# installs nginx
# Arguments:
#   None
#######################################
system_nginx_install() {
  print_banner
  printf "${WHITE} 💻 Instalando nginx...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  apt install -y nginx
  rm /etc/nginx/sites-enabled/default
EOF

  sleep 2
}

#######################################
# restarts nginx
# Arguments:
#   None
#######################################
system_nginx_restart() {
  print_banner
  printf "${WHITE} 💻 reiniciando nginx...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  service nginx restart
EOF

  sleep 2
}

#######################################
# setup for nginx.conf
# Arguments:
#   None
#######################################
system_nginx_conf() {
  print_banner
  printf "${WHITE} 💻 configurando nginx...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

sudo su - root << EOF

cat > /etc/nginx/conf.d/whaticket.conf << 'END'
client_max_body_size 20M;
END

EOF

  sleep 2
}

#######################################
# installs nginx
# Arguments:
#   None
#######################################
system_certbot_setup() {
  print_banner
  printf "${WHITE} 💻 Configurando certbot...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  backend_domain=$(echo "${backend_url/https:\/\/}")
  frontend_domain=$(echo "${frontend_url/https:\/\/}")

  sudo su - root <<EOF
  certbot -m $deploy_email \
          --nginx \
          --agree-tos \
          --non-interactive \
          --domains $backend_domain,$frontend_domain
EOF

  sleep 2
}

#######################################
# installs apache
# Arguments:
#   None
#######################################
system_apache_install() {
  print_banner
  printf "${WHITE} 💻 Instalando apache...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  sudo apt-get install -y apache2 \
                            apache2-utils
EOF

  sleep 2
}

#######################################
# set port apache
# Arguments:
#   None
#######################################
system_apache_set_port() {
  print_banner
  printf "${WHITE} 💻 Setando porta do apache...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root << EOF
    cat <<[-]EOF > /etc/apache2/ports.conf
# If you just change the port or add more ports here, you will likely also
# have to change the VirtualHost statement in
# /etc/apache2/sites-enabled/000-default.conf

Listen 81

<IfModule ssl_module>
  Listen 443
</IfModule>

<IfModule mod_gnutls.c>
  Listen 443
</IfModule>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
[-]EOF
EOF

  sleep 2
}

#######################################
# restart apache
# Arguments:
#   None
#######################################
system_apache_restart() {
  print_banner
  printf "${WHITE} 💻 Restart apache...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  systemctl restart apache2
  systemctl enable apache2
EOF

  sleep 2
}

#######################################
# install php
# Arguments:
#   None
#######################################
system_php_install() {
  print_banner
  printf "${WHITE} 💻 Instalando php...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  apt-get install -y php7.4 \
                  libapache2-mod-php7.4 \
                  php7.4-mysql \
                  php-common \
                  php7.4-cli \
                  php7.4-common \
                  php7.4-json \
                  php7.4-opcache \
                  php7.4-readline
  apt-get install -y php-curl
EOF

  sleep 2
}

#######################################
# set mod php
# Arguments:
#   None
#######################################
system_php_set_mod() {
  print_banner
  printf "${WHITE} 💻 Setando mod PHP...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  a2enmod php7.4
  systemctl restart apache2
  a2dismod php7.4
  apt-get install -y php7.4-fpm
  a2enmod proxy_fcgi setenvif
  a2enconf php7.4-fpm
  systemctl restart apache2
EOF

  sleep 2
}

#######################################
# creates final message
# Arguments:
#   None
#######################################
system_success() {
  print_banner
  printf "${GREEN} 💻 Instalação concluída com Sucesso...${NC}"
  printf "${CYAN_LIGHT}";
  printf "\n\n"
  printf "Usuário: admin@whaticket.com"
  printf "\n"
  printf "Senha: admin"
  printf "\n"
  printf "URL front: https://$frontend_url"
  printf "\n"
  printf "URL back: https://$backend_url"
  printf "\n"
  printf "Senha Usuario DeployZDG: $deploy_password"
  printf "\n"
  printf "Usuario do Banco de Dados: $db_user"
  printf "\n"
  printf "Nome do Banco de Dados: $db_name"
  printf "\n"
  printf "Senha do Banco de Dados: $db_pass"
  printf "\n"

  sleep 2
}