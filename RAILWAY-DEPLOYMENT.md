# 🛩️ Triển khai Airbyte OSS lên Railway

Hướng dẫn này sẽ giúp bạn triển khai Airbyte Open Source lên Railway platform một cách nhanh chóng.

## 🚀 Triển khai nhanh

### Bước 1: Deploy từ GitHub

1. **Login vào Railway**: Truy cập [railway.app](https://railway.app) và đăng nhập
2. **Tạo project mới**: Click "New Project"
3. **Deploy from GitHub**: Chọn "Deploy from GitHub repo"
4. **Chọn repository**: Chọn repository `newtech-trm/airbyte-oss`
5. **Confirm deployment**: Click "Deploy Now"

### Bước 2: Thêm PostgreSQL Database

1. **Thêm service mới**: Trong project dashboard, click "New Service"
2. **Chọn Database**: Click "Database" → "PostgreSQL" 
3. **Deploy database**: Click "Deploy PostgreSQL"
4. **Chờ deployment**: Railway sẽ tự động tạo database và set biến `DATABASE_URL`

### Bước 3: Cấu hình Domain (Tùy chọn)

1. **Mở Settings**: Click vào service Airbyte → "Settings" tab
2. **Generate Domain**: Ở phần "Domains", click "Generate Domain"
3. **Custom Domain**: Hoặc thêm custom domain của bạn

## 🔧 Biến môi trường

Railway sẽ tự động set các biến sau:

```bash
PORT=8000                    # Cổng ứng dụng
RAILWAY_STATIC_URL           # URL của deployment  
DATABASE_URL                 # PostgreSQL connection string (từ database service)
```

## 📋 Sau khi Deploy

1. **Truy cập ứng dụng**: Click vào domain được generate
2. **Kiểm tra status**: Trang web sẽ hiển thị trạng thái deployment
3. **Đợi database**: Nếu chưa có database, làm theo hướng dẫn trên trang

## 🏗️ Cấu trúc Project

```
airbyte-oss/
├── Dockerfile                 # Docker config cho Railway
├── railway.toml              # Railway configuration  
├── start-railway.sh          # Startup script
├── docker-compose.railway.yml # Compose config (cho dev)
└── RAILWAY-DEPLOYMENT.md     # Hướng dẫn này
```

## 🔍 Troubleshooting

### 1. Deploy bị lỗi
- Kiểm tra logs trong Railway dashboard
- Đảm bảo Dockerfile syntax đúng
- Check resource limits

### 2. Database connection failed
- Đảm bảo đã thêm PostgreSQL service
- Kiểm tra biến `DATABASE_URL` trong Settings
- Restart service sau khi thêm database

### 3. Port issues
- Railway tự động set PORT, không cần thay đổi
- App sẽ listen trên port từ biến `$PORT`

## 📞 Hỗ trợ

- [Railway Documentation](https://docs.railway.app/)
- [Airbyte Documentation](https://docs.airbyte.com/)
- [GitHub Issues](https://github.com/newtech-trm/airbyte-oss/issues)

## 💡 Lưu ý

- Đây là deployment đơn giản để bắt đầu nhanh
- Để production, nên dùng Airbyte Cloud hoặc Kubernetes
- Railway free tier có giới hạn resources

---

**Token Railway**: `1d91c1cb-c3a0-45fe-add2-25ea3857a917`
**Project ID**: `522d968d-1430-485c-bd87-f33c52568680` 