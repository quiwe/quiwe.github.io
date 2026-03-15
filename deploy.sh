#!/bin/bash

# 博客部署脚本

echo "=== 开始部署博客 ==="

# 更新系统
echo "1. 更新系统..."
apt update && apt upgrade -y

# 安装 Nginx
echo "2. 安装 Nginx..."
apt install -y nginx

# 启动 Nginx
echo "3. 启动 Nginx..."
systemctl start nginx
systemctl enable nginx

# 创建博客目录
echo "4. 创建博客目录..."
mkdir -p /var/www/blog

# 复制博客文件（需要手动上传 index.html 到服务器）
echo "5. 请将 index.html 上传到 /var/www/blog/ 目录"

# 配置 Nginx
echo "6. 配置 Nginx..."
cat > /etc/nginx/sites-available/blog << 'EOF'
server {
    listen 80;
    server_name _;
    
    root /var/www/blog;
    index index.html;
    
    location / {
        try_files $uri $uri/ =404;
    }
}
EOF

# 启用配置
ln -sf /etc/nginx/sites-available/blog /etc/nginx/sites-enabled/
nginx -t
systemctl reload nginx

echo "=== 部署完成 ==="
echo "请上传 index.html 到 /var/www/blog/ 目录"
echo "然后配置域名解析到服务器 IP"
