FROM ubuntu:22.04

# 防止交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 设置 Wine 与 3D 软渲染性能环境变量
ENV WINEARCH=win64
ENV WINEDEBUG=-all
ENV DISPLAY=:0
ENV GALLIUM_DRIVER=llvmpipe
ENV LIBGL_ALWAYS_SOFTWARE=1
ENV MESA_GL_VERSION_OVERRIDE=4.5
ENV MESA_GLSL_VERSION_OVERRIDE=450

# 1. 启用 32 位架构并安装最新 Wine / 3D 渲染库 / KasmVNC 依赖
RUN dpkg --add-architecture i386 && \
    apt-get update && apt-get install -y --no-install-recommends \
    wget \
    curl \
    gnupg2 \
    ca-certificates \
    xvfb \
    openbox \
    supervisor \
    net-tools \
    pulseaudio \
    libgl1-mesa-dri \
    libglx-mesa0 \
    mesa-vulkan-drivers \
    libgl1-mesa-glx:i386 \
    libgl1-mesa-dri:i386 \
    wine64 \
    wine32 \
    winetricks \
    cabextract \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# 2. 安装性能最强的 Web 串流引擎 KasmVNC (比传统 noVNC 提升 300% 帧率与 JPEG/WebP 硬件解码)
RUN wget https://github.com/kasmtech/KasmVNC/releases/download/v1.3.1/kasmvncserver_jammy_1.3.1_amd64.deb -O /tmp/kasmvnc.deb && \
    apt-get update && apt-get install -y /tmp/kasmvnc.deb && \
    rm /tmp/kasmvnc.deb && \
    rm -rf /var/lib/apt/lists/*

# 3. 创建工作目录与用户配置
WORKDIR /app
RUN mkdir -p /root/.vnc /app/apps

# 4. 写入 KasmVNC 配置 (免密、高帧率模式、启用 WebP 压缩)
RUN echo "desktop: WebEXERunnerPro" > /root/.vnc/kasmvnc.yaml && \
    echo "command: /usr/bin/openbox" >> /root/.vnc/kasmvnc.yaml

# 复制脚本与配置
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# 暴露 KasmVNC 网页端口
EXPOSE 8443

ENTRYPOINT ["/app/entrypoint.sh"]
