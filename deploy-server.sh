#!/bin/bash

# 博客部署脚本 - 在服务器上运行

# 1. 更新系统并安装Nginx
apt update && apt install -y nginx

# 2. 启动Nginx
systemctl start nginx
systemctl enable nginx

# 3. 创建博客目录
mkdir -p /var/www/blog

# 4. 设置权限
chown -R www-data:www-data /var/www/blog
chmod -R 755 /var/www/blog

# 5. 配置Nginx
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

# 6. 启用配置
ln -sf /etc/nginx/sites-available/blog /etc/nginx/sites-enabled/default
nginx -t
systemctl reload nginx

echo "=== 部署完成 ==="
echo "请上传 index.html 到 /var/www/blog/ 目录"
