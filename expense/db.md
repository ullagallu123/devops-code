1. Install mysql server

```bash
dnf install mysql-server -y
```

2. Start and Enable mysql server

```bash
systemctl start mysqld
systemctl enable mysqld
```

3. setup mysql root passwd for first time

```bash
mysql_secure_installation --set-root-pass siva
```

4. login to mysql server

```bash
mysql -uroot -p
```
- here password asking prompt
- login as normal user if it is root user directly use `mysql`

5. list nof schemas avaialable in the mysql server

```bash
show databases
```

# Useful Commands

```bash
ps -ef | grep mysqld
```
