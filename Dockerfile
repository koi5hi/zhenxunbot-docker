FROM ubuntu:focal
LABEL org.opencontainers.image.authors="源源圆球"
WORKDIR /home
ENV bot_qq=${bot_qq}
ENV bot_qq_key=${bot_qq_key}
ENV admin_qq=${admin_qq}

# 设为非交互命令
ARG DEBIAN_FRONTEND="noninteractive" 

RUN sed -i 's/us.archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list; \
sed -i 's/cn.archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list; \
sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list; \
sed -i 's/security.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list;

# 安装依赖
RUN apt update && apt upgrade -y && apt install -y --no-install-recommends \
python3.8 \
python3-distutils \
python3.8-dev \
vim \
git \
curl \
wget \
ffmpeg \
language-pack-zh-hans \
postgresql \
postgresql-contrib \
libgl1 \
libglib2.0-0 \
libnss3 \
libatk1.0-0 \
libatk-bridge2.0-0 \
libcups2 \
libxkbcommon0 \
libxcomposite1 \
libxrandr2 \
libgbm1 \
libgtk-3-0 \
libasound2 \
gcc \
libsasl2-dev \
libldap2-dev \
ca-certificates \
libssl-dev && \
apt clean && rm -rf /var/lib/apt/lists/*

# 调整软链接
RUN ln -s /usr/bin/python3.8 /usr/bin/python

# 调整时区+设定语言
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone
ENV LANG=zh_CN.UTF-8

# 安装pip,然后安装依赖,并清除缓存
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python get-pip.py && rm -f get-pip.py && \
pip install -r https://raw.githubusercontent.com/zhenxun-org/zhenxun_bot-deploy/master/requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple && \
pip install rich requests jinja2 thefuzz aiocache baike nonebot_plugin_htmlrender imageio -i https://pypi.tuna.tsinghua.edu.cn/simple && \
rm -rf ~/.cache/pip/*
RUN playwright install chromium

# 克隆zhenxun_bot
RUN git clone https://github.com/HibiKier/zhenxun_bot.git

# 安装web_ui
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
apt install -y nodejs && \
npm install -g yarn && \
npm install -g @vue/cli && \
git clone https://github.com/HibiKier/zhenxun_bot_webui.git && \
npm cache clean --force
WORKDIR /home/zhenxun_bot_webui
RUN npm config set registry https://registry.npmmirror.com/ && npm install && npm cache clean --force

RUN apt -y autoremove
# 拷贝文件
WORKDIR /home
COPY ./go-cqhttp ./go-cqhttp
COPY ./files/docker-entrypoint.sh ./
COPY ./files/config.sh ./
COPY ./files/config.yaml ./zhenxun_bot/configs/
COPY ./files/config.py ./zhenxun_bot/configs/

ENTRYPOINT ["./docker-entrypoint.sh"]
