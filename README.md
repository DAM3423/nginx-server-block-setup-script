# nginx-server-block-setup-script
## Shell script to set up a new server block on a ubuntu web server running NGINX

### Installation
1. Use `wget -qO nginx-create-server-block.sh 'https://raw.githubusercontent.com/DAM3423/nginx-server-block-setup-script/main/setup-nginx-server-block.sh' && bash nginx-create-server-block.sh` to download and run the script.
2. You will be asked for a domain name. This will be used to point nginx to a specific folder in the `/var/www` directory.