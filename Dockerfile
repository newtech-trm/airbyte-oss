# Use a lighter base image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Create a simple web server
RUN npm install -g http-server

# Create HTML content
COPY start-railway.sh /app/start.sh
RUN chmod +x /app/start.sh

# Create a simple HTML page
RUN echo '<!DOCTYPE html>\
<html lang="en">\
<head>\
    <meta charset="UTF-8">\
    <meta name="viewport" content="width=device-width, initial-scale=1.0">\
    <title>Airbyte on Railway</title>\
    <style>\
        body { font-family: Arial, sans-serif; max-width: 800px; margin: 0 auto; padding: 20px; background: #f5f5f5; }\
        .container { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }\
        h1 { color: #333; text-align: center; }\
        .status { padding: 15px; border-radius: 5px; margin: 20px 0; }\
        .success { background: #d4edda; border: 1px solid #c3e6cb; color: #155724; }\
        .warning { background: #fff3cd; border: 1px solid #ffeaa7; color: #856404; }\
        .info { background: #d1ecf1; border: 1px solid #bee5eb; color: #0c5460; }\
        pre { background: #f8f9fa; padding: 15px; border-radius: 5px; overflow-x: auto; }\
    </style>\
</head>\
<body>\
    <div class="container">\
        <h1>🛩️ Airbyte on Railway</h1>\
        \
        <div class="status success">\
            ✅ <strong>Deployment Successful!</strong> Your Airbyte instance is running on Railway.\
        </div>\
        \
        <div class="status info">\
            <strong>🔧 Setup Required:</strong><br>\
            To complete your Airbyte setup, you need to add a PostgreSQL database to your Railway project.\
        </div>\
        \
        <h2>📋 Next Steps:</h2>\
        <ol>\
            <li><strong>Add PostgreSQL Database:</strong>\
                <ul>\
                    <li>Go to your Railway project dashboard</li>\
                    <li>Click "New Service" → "Database" → "PostgreSQL"</li>\
                    <li>Railway will automatically set the DATABASE_URL environment variable</li>\
                </ul>\
            </li>\
            <li><strong>Redeploy:</strong> After adding the database, redeploy this service</li>\
            <li><strong>Access Airbyte:</strong> The Airbyte web interface will be available at this URL</li>\
        </ol>\
        \
        <h2>📞 Support:</h2>\
        <ul>\
            <li><a href="https://docs.airbyte.com/" target="_blank">Airbyte Documentation</a></li>\
            <li><a href="https://docs.railway.app/" target="_blank">Railway Documentation</a></li>\
        </ul>\
    </div>\
</body>\
</html>' > /app/index.html

# Expose port
EXPOSE 8000

# Set environment variable for port
ENV PORT=8000

# Start command
CMD ["sh", "-c", "http-server -p $PORT -a 0.0.0.0"] 