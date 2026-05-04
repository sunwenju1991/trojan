# Trojan Docker

这是一个基于 Docker Compose 部署 Trojan 服务端的项目。

本项目已经把 Trojan 服务端、Nginx 伪装站、证书挂载路径、配置文件映射都整理好了。  
正常情况下，克隆项目后直接执行：

```bash
docker compose up -d

1. 克隆项目到 /opt/trojan
```bash
cd /opt || exit 1

rm -rf /opt/trojan

git clone https://github.com/sunwenju1991/trojan.git /opt/trojan

cd /opt/trojan || exit 1

2. 启动服务
```bash
docker compose up -d
