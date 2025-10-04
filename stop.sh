#!/bin/bash

# 停止脚本 - Minimal CopilotKit LangGraph 项目
# 停止所有docker compose服务

set -e  # 遇到错误立即退出

echo "🛑 停止 Minimal CopilotKit LangGraph 项目..."
echo "================================================"

# 检查docker compose是否可用
if ! docker compose version &> /dev/null; then
    echo "❌ Docker Compose 不可用，请确保 Docker Compose 已安装"
    exit 1
fi

# 停止所有服务
echo "⏹️  停止所有服务..."
docker compose down

# 可选：清理所有相关资源
read -p "是否清理所有相关资源（包括镜像和卷）？(y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "🧹 清理所有相关资源..."
    docker compose down --volumes --remove-orphans
    docker system prune -f
    echo "✅ 清理完成"
fi

echo "✅ 服务已停止"
echo "================================================"
