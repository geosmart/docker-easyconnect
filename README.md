# docker-easyconnect

## 编译镜像
docker image build  --tag geosmart/docker-easyconnect:7.6.7  -f Dockerfile .

## 启动
```sh
docker run -itd \
--name easyconnect \
--device /dev/net/tun \
--cap-add NET_ADMIN \
-ti \
-e PASSWORD=xxx \
-v $HOME/.ecdata:/root \
-p 127.0.0.1:5901:5901 \
-p 127.0.0.1:9080:1080 \
-p 127.0.0.1:9888:8888 \
geosmart/docker-easyconnect:7.6.7
```
vnc客户端Remmina连接127.0.0.1:5901，用户名/密码登录，输入手机验证码

## 测试
export HTTP_PROXY=127.0.0.1:9888

curl 内网地址