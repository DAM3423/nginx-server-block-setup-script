#!/bin/bash

# SETUP NGINX SERVER BLOCK

echo "We need a domain name please"
read domain_name

echo "We need a PHP version"
read php_version

echo "Creating nginx server block"

uri='$uri'
realpath_root='$document_root'
fastcgi_script_name='$fastcgi_script_name'

sudo tee /etc/nginx/sites-available/$domain_name >/dev/null <<EOF
server {
    listen 80;
    server_name $domain_name;
    root /var/www/$domain_name/public;
    add_header X-Frame-Options "SAMEORIGIN";
    add_header X-XSS-Protection "1; mode=block";
    add_header X-Content-Type-Options "nosniff";
    index index.html index.htm index.php;
    charset utf-8;
    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }
    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }
    error_page 404 /index.php;
    location ~ \.php$ {
        fastcgi_pass unix:/var/run/php/php$php_version-fpm.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;
        include fastcgi_params;
    }
    location ~ /\.(?!well-known).* {
        deny all;
    }
}
EOF

echo "Linking nginx server block"
sudo ln -s /etc/nginx/sites-available/$domain_name /etc/nginx/sites-enabled/

sudo nginx -t

sudo systemctl reload nginx
