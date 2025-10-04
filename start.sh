#!/bin/bash

# 一键启动脚本 - Minimal CopilotKit LangGraph 项目
# 使用docker compose启动三个服务

set -e  # 遇到错误立即退出

echo "🚀 启动 Minimal CopilotKit LangGraph 项目..."
echo "================================================"

# 检查docker是否安装
if ! command -v docker &> /dev/null; then
    echo "❌ Docker 未安装，请先安装 Docker"
    exit 1
fi

# 检查docker compose是否可用
if ! docker compose version &> /dev/null; then
    echo "❌ Docker Compose 不可用，请确保 Docker Compose 已安装"
    exit 1
fi

# 停止并删除之前的容器（如果存在）
echo "🧹 清理之前的容器..."
docker compose down --remove-orphans

# 构建并启动所有服务
echo "🔨 构建并启动所有服务..."
docker compose up --build -d

# 等待服务启动
echo "⏳ 等待服务启动..."
sleep 10

# 检查服务状态
echo "📊 检查服务状态..."
docker compose ps

# 显示服务访问信息
echo ""
echo "✅ 服务启动完成！"
echo "================================================"
echo "🌐 服务访问地址："
echo "   • React 客户端: http://localhost:5173"
echo "   • Copilot Runtime: http://localhost:4000/copilotkit"
echo "   • LangGraph 服务: http://localhost:8000/copilotkit"
echo "   • LangGraph 健康检查: http://localhost:8000/health"
echo ""
echo "📝 常用命令："
echo "   • 查看日志: docker compose logs -f"
echo "   • 停止服务: docker compose down"
echo "   • 重启服务: docker compose restart"
echo "   • 查看状态: docker compose ps"
echo "================================================"

# 可选：显示实时日志
read -p "是否查看实时日志？(y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "📋 显示实时日志 (按 Ctrl+C 退出)..."
    docker compose logs -f
fi
