# 安装
sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
# 修改权限
sudo chmod +x /usr/local/bin/docker-compose
# 查看版本
docker-compose -v