<!--
 * @Author: 源源圆球 1340793687@outlook.com
 * @Date: 2022-06-03 18:01:14
 * @LastEditors: error: git config user.name && git config user.email & please set dead value or install git
 * @LastEditTime: 2022-08-26 08:42:04
 * @FilePath: /zhenxunbot-docker/README.md
 * Copyright (c) 2022 by 源源圆球 1340793687@outlook.com, All Rights Reserved. 
-->
<div align=center><img width="30%" src="./image/docker.png"/></div>

# [绪山真寻BOT](https://github.com/HibiKier/zhenxun_bot)的Docker镜像

![](https://img.shields.io/github/workflow/status/SinKy-Yan/zhenxunbot-docker/Build%20Docker%20image?label=%E9%95%9C%E5%83%8F%E7%BC%96%E8%AF%91&style=for-the-badge)
![](https://img.shields.io/docker/image-size/jyishit/zhenxun_bot?label=%E9%95%9C%E5%83%8F%E5%A4%A7%E5%B0%8F&style=for-the-badge&logo=docker&logoColor=white&color=2496ED)
![](https://img.shields.io/docker/pulls/jyishit/zhenxun_bot?label=%E4%B8%8B%E8%BD%BD%E6%AC%A1%E6%95%B0&style=for-the-badge)
![](https://img.shields.io/badge/%E6%94%AF%E6%8C%81%E6%9E%B6%E6%9E%84-amd64%7Carm64-FF69B4?style=for-the-badge)
![Arduino](https://img.shields.io/badge/-Debian-A81D33?style=for-the-badge&logo=debian&logoColor=white)
![Arduino](https://img.shields.io/badge/-Python3.9-3776AB?style=for-the-badge&logo=python&logoColor=white)

**使用Docker Compose管理机器人本体、数据库、QQ客户端,一键启动😋**

<img align=right src='https://github.githubassets.com/images/mona-whisper.gif' />

顺手点个Star⭐呗~

## 快速开始🚀

🐂 首先下载本仓库中的`docker-compose.yml`文件,用`wget`或者别的你会的方法

```shell
wget https://raw.githubusercontent.com/SinKy-Yan/zhenxunbot-docker/mulit/compose/docker-compose.yml
```

🐖 然后编辑刚才下好的`docker-compose.yml`,可以用`vim`、`nano`或者任何你会的编辑器,按照文件里的注释改,其中数据库管理器不是必须的,不想要可以删掉那段

🐏 然后直接运行`docker compose up`,docker compose会帮你自动配置好,等着机器人启动就好

## 注意事项🧐

1. 需要注意gocq容器的日志,看它能不能正常登录QQ

2. gocq容器的日志中一直出现"连接到反向服务器失败"的警告是正常现象,等待机器人启动后这个警告就会消失

3. 第一次启动机器人会很久,而且还需要下载图片素材,会很慢

## 迁移数据库📑

跟一般的导入数据库没有区别,但是需要修改`docker-compose.yml`,先把机器人本体部分注释掉,先创建数据库容器,导入了数据库之后再加上机器人

## 需要帮助🐱‍💻?

你可以点击图片加入QQ交流群、有关代码的问题可以提一个[issue](https://github.com/SinKy-Yan/zhenxunbot-docker/issues/new)、别的东西可以发在[讨论](https://github.com/SinKy-Yan/zhenxunbot-docker/discussions)里

[![加入QQ群](https://img.shields.io/badge/QQ%E7%BE%A4-1034439737-ddff95?style=for-the-badge)](https://jq.qq.com/?_wv=1027&k=u8PgBkMZ)

## 编译镜像🐋

你需要搞定Docker的`Buildx`环境然后克隆该仓库然后直接构建即可

```
docker buildx build --platform=arm64 --tag=zhenxun -o type=docker .
```

## 仓库文件说明📂

### `./gocq`

构建gocq镜像的相关文件

### `./compose`

示例文件

### `./image`

这个readme用的图片在里面

### `./webui`

构建webui镜像的相关文件

### `./zhenxun`

构建zhenxun镜像的相关文件
