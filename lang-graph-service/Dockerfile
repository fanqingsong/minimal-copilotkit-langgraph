# 使用华为云镜像加速
FROM swr.cn-north-4.myhuaweicloud.com/ddn-k8s/docker.io/python:3.12-slim

WORKDIR /app

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 安装uv (更快的Python包管理器)
RUN pip install uv

# 复制依赖文件
COPY pyproject.toml ./

# 安装Python依赖
RUN uv sync

# 复制源代码
COPY . .

# 暴露端口
EXPOSE 8000

# 启动服务
CMD ["uv", "run", "python", "server.py"]
