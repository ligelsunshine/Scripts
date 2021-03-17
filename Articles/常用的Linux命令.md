# 常用的Linux命令

## 1. 查看占用某个端口的进程

```java
    netstat -anp | grep 端口
```

## 2. 查看进程对应的程序

```java
ps -ef | grep 进程号
```

## 3. 查看占用端口的进程号

```
lsof -i:端口
```

## 4. 通过端口杀死进程

```
kill -9 `lsof -ti:端口`
```

## 5.ubuntu防火墙操作

```java
防火墙gufw常用操作
启用ufw: sudo ufw enable
防外对内访问：sudo ufw default deny
关闭：sudo ufw disable
状态：sudo ufw status
开启相应服务：sudo ufw allow/deny [service]
ssh服务端、客户端：openssh-server/openssh-client
防ssh破解：denyhosts
ufw配置文件位于：/etc/ufw/ufw.conf
也可以直接在该配置文件中修改！
ps:修改之后要重启才能生效！
```



## 6. ubuntu查看端口防火墙问题

```java
 apt install firewalld
 firewall-cmd --query-port=8090/tcp
 firewall-cmd --add-port=8090/tcp
 firewall-cmd --zone=public --list-port
//启动：
 systemctl start firewalld
//停止：
 systemctl disable firewalld
//禁用： 
 systemctl stop firewalld
```





# 在Linux上安装工具

## 1. Docker 安装

Docker安装分国内镜像和国外镜像，下面都弄成了脚本，可以一键执行

### 1.1 国内版

```python
#!/bin/bash
# 移除掉旧的版本
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine

# 删除所有旧的数据
sudo rm -rf /var/lib/docker

#  安装依赖包
sudo yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

# 添加源，使用了阿里云镜像
sudo yum-config-manager \
    --add-repo \
    http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

# 配置缓存
sudo yum makecache fast

# 安装最新稳定版本的docker
sudo yum install -y docker-ce

# 配置镜像加速器
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["http://hub-mirror.c.163.com"]
}
EOF

# 启动docker引擎并设置开机启动
sudo systemctl start docker
sudo systemctl enable docker

# 配置当前用户对docker的执行权限
sudo groupadd docker
sudo gpasswd -a ${USER} docker
sudo systemctl restart docker
```

### 1.2国外版

```python
#!/bin/bash
# remove old version
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine

# remove all docker data 
sudo rm -rf /var/lib/docker

#  preinstall utils 
sudo yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

# add repository
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

# make cache
sudo yum makecache fast

# install the latest stable version of docker
sudo yum install -y docker-ce

# start deamon and enable auto start when power on
sudo systemctl start docker
sudo systemctl enable docker

# add current user 
sudo groupadd docker
sudo gpasswd -a ${USER} docker
sudo systemctl restart docker
国内版，需要设置网络加速，国内和docker官网网络不通
#!/bin/bash
# 移除掉旧的版本
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine

# 删除所有旧的数据
sudo rm -rf /var/lib/docker

#  安装依赖包
sudo yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

# 添加源，使用了阿里云镜像
sudo yum-config-manager \
    --add-repo \
    http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

# 配置缓存
sudo yum makecache fast

# 安装最新稳定版本的docker
sudo yum install -y docker-ce

# 配置镜像加速器
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["http://hub-mirror.c.163.com"]
}
EOF

# 启动docker引擎并设置开机启动
sudo systemctl start docker
sudo systemctl enable docker

# 配置当前用户对docker的执行权限
sudo groupadd docker
sudo gpasswd -a ${USER} docker
sudo systemctl restart docker
```

#### 1.1.1 参考资料

- https://zhuanlan.zhihu.com/p/54147784

## 2. Docker composr安装

**下面是安装命令**

```python
# 安装
sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
# 修改权限
sudo chmod +x /usr/local/bin/docker-compose
```

查看版本，也是查看安装是否成功：

```python
docker-compose -v
```

