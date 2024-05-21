1. list out the nodes modules
```bash
dnf module list
```
2. disable current nodjs module
```bash
dnf module disable nodejs:18 -y
```
3. enable nodjs 20 
```bash
dnf module enable nodejs:20 -y
```
4. Install nodejs 20
```bash
dnf install nodejs -y
```
5. check the version of nodejs
```bash
node -v
```
6. add user for app
```bash
useradd wages
```
7. create dir and change to dir
```bash
mkdir /app; cd /app
```
8. clone the code
```bash
https://github.com/ullagallu123/exp-backend.git
```
9. build the application
```bash
npm install
```
10. add the service for app
```bash
vim /etc/systemd/system/backend.service
```
```bash
[Unit]
Description = Backend Service
    
[Service]
User=wages
Environment=DB_HOST="db.ullagallu.cloud"
ExecStart=/bin/node /app/index.js
SyslogIdentifier=backend
    
[Install]
WantedBy=multi-user.target
```
11. reload,enable and start the app
```bash
systemctl daemon-reload
systemctl start backend
systemctl enable backend
```
12. app need to conn db but it need to client
```bash
dnf install mysql -y
``
13. execute the schema
```bash
mysql -h db.ullagallu.cloud -uroot -psiva
mysql -h db.ullagallu.cloud -uroot -psiva < /app/schema/backend.sql
```

## useful commands
1. Ensure reachability to db server
```bash
ping -c 3 db.ullagallu.cloud
```
2. Checking connetivity to db server
```bash
telnet db.ullagallu.cloud 3306
```
3. check the process of the node
```bash
ps -ef | grep node
```
4. check the logs of backend service
```bash
journalctl -u backend
```
5. Generally non-systemd services logs you might find logs on /var/log/syslog and /var/log/messages use tail to monitor logs in realtime
```bash
tail -f /var/log/messages
```