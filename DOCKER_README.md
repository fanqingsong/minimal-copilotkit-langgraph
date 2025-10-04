# Docker 部署指南

本项目使用 Docker Compose 封装了三个服务，提供一键启动功能。

## 🚀 快速开始

### 一键启动
```bash
./start.sh
```

### 停止服务
```bash
./stop.sh
```

## 📋 服务说明

### 1. LangGraph 服务 (Python)
- **端口**: 8000
- **访问地址**: http://localhost:8000/copilotkit
- **健康检查**: http://localhost:8000/health
- **技术栈**: Python + FastAPI + LangGraph

### 2. Copilot Runtime 服务 (Node.js)
- **端口**: 4000
- **访问地址**: http://localhost:4000/copilotkit
- **技术栈**: Node.js + TypeScript + CopilotKit Runtime

### 3. React 客户端 (前端)
- **端口**: 5173
- **访问地址**: http://localhost:5173
- **技术栈**: React + Vite + TailwindCSS + CopilotKit

## 🛠️ 手动操作

### 启动所有服务
```bash
docker compose up --build -d
```

### 查看服务状态
```bash
docker compose ps
```

### 查看日志
```bash
# 查看所有服务日志
docker compose logs -f

# 查看特定服务日志
docker compose logs -f lang-graph-service
docker compose logs -f copilot-runtime-service
docker compose logs -f react-client
```

### 停止服务
```bash
docker compose down
```

### 重启服务
```bash
docker compose restart
```

## 🔧 开发模式

项目配置了开发模式，支持热重载：

- **代码变更**: 修改代码后会自动重新加载
- **依赖安装**: 首次启动会自动安装所有依赖
- **端口映射**: 所有服务端口都已映射到宿主机

## 📁 项目结构

```
minimal-copilotkit-langgraph/
├── docker-compose.yml          # Docker Compose 配置
├── start.sh                    # 一键启动脚本
├── stop.sh                     # 停止脚本
├── lang-graph-service/         # Python LangGraph 服务
│   ├── Dockerfile
│   ├── server.py
│   └── ...
├── copilot-runtime-service/    # Node.js Copilot Runtime 服务
│   ├── Dockerfile
│   ├── server.ts
│   └── ...
└── react-client/               # React 前端应用
    ├── Dockerfile
    ├── src/
    └── ...
```

## 🌐 网络配置

所有服务运行在同一个 Docker 网络中 (`app-network`)，服务间可以通过服务名互相访问：

- `lang-graph-service:8000`
- `copilot-runtime-service:4000`
- `react-client:5173`

## 🚨 故障排除

### 端口冲突
如果遇到端口冲突，可以修改 `docker-compose.yml` 中的端口映射：
```yaml
ports:
  - "8001:8000"  # 将宿主机端口改为8001
```

### 服务启动失败
1. 检查 Docker 是否正常运行
2. 查看服务日志：`docker compose logs [service-name]`
3. 检查端口是否被占用：`netstat -tulpn | grep :8000`

### 清理资源
```bash
# 停止并删除所有容器、网络、卷
docker compose down --volumes --remove-orphans

# 清理未使用的镜像和缓存
docker system prune -f
```

## 📝 注意事项

1. **首次启动**: 首次启动会下载基础镜像和安装依赖，可能需要几分钟时间
2. **环境变量**: 确保设置了必要的环境变量（如 API 密钥）
3. **资源要求**: 建议至少 4GB 内存和 2GB 可用磁盘空间
4. **网络**: 确保防火墙允许相关端口访问

## 🔗 相关链接

- [Docker Compose 官方文档](https://docs.docker.com/compose/)
- [CopilotKit 文档](https://docs.copilotkit.ai/)
- [LangGraph 文档](https://langchain-ai.github.io/langgraph/)
