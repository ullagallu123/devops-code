1. Install nginx server
```bash
dnf install nginx -y
```
2. start and enable nginx server
```bash
systemctl enable nginx
systemctl start nginx
```
3. remove all default config
```bash
rm -rf /usr/share/nginx/html/*
```
4. download the code
```bash
git clone https://github.com/ullagallu123/exp-frontend.git /usr/share/nginx/html
```
5. add the configuration without modifying the original conf everything you added default.d was automatically loaded this was defined in the original conf..
```bash
vim /etc/nginx/default.d/expense.conf
```
```bash
proxy_http_version 1.1;
    
location /api/ { proxy_pass http://backend.ullagallu.cloud:8080/; }
    
location /health {
  stub_status on;
  access_log off;
} 
```
6. restart nginx server
```bash
systemctl restart nginx
```
