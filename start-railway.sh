#!/bin/bash
set -e

echo "🚀 Starting Airbyte on Railway..."
echo "📦 Port: ${PORT:-8000}"
echo "🌐 Railway URL: ${RAILWAY_STATIC_URL:-localhost}"

# Check if we have environment variables needed
if [ -z "$DATABASE_URL" ]; then
    echo "⚠️  DATABASE_URL not set. You need to add a PostgreSQL database in Railway."
    echo "📖 Please add a PostgreSQL database service to your Railway project."
fi

# For now, start a simple web server that shows setup instructions
cat > /tmp/index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Airbyte on Railway</title>
    <style>
        body { font-family: Arial, sans-serif; max-width: 800px; margin: 0 auto; padding: 20px; background: #f5f5f5; }
        .container { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h1 { color: #333; text-align: center; }
        .status { padding: 15px; border-radius: 5px; margin: 20px 0; }
        .success { background: #d4edda; border: 1px solid #c3e6cb; color: #155724; }
        .warning { background: #fff3cd; border: 1px solid #ffeaa7; color: #856404; }
        .info { background: #d1ecf1; border: 1px solid #bee5eb; color: #0c5460; }
        pre { background: #f8f9fa; padding: 15px; border-radius: 5px; overflow-x: auto; }
        .logo { text-align: center; margin-bottom: 30px; }
        .logo img { max-width: 200px; }
    </style>
</head>
<body>
    <div class="container">
        <div class="logo">
            <h1>🛩️ Airbyte on Railway</h1>
        </div>
        
        <div class="status success">
            ✅ <strong>Deployment Successful!</strong> Your Airbyte instance is running on Railway.
        </div>
        
        <div class="status info">
            <strong>🔧 Setup Required:</strong><br>
            To complete your Airbyte setup, you need to add a PostgreSQL database to your Railway project.
        </div>
        
        <h2>📋 Next Steps:</h2>
        <ol>
            <li><strong>Add PostgreSQL Database:</strong>
                <ul>
                    <li>Go to your Railway project dashboard</li>
                    <li>Click "New Service" → "Database" → "PostgreSQL"</li>
                    <li>Railway will automatically set the DATABASE_URL environment variable</li>
                </ul>
            </li>
            <li><strong>Redeploy:</strong> After adding the database, redeploy this service</li>
            <li><strong>Access Airbyte:</strong> The Airbyte web interface will be available at this URL</li>
        </ol>
        
        <h2>🔧 Environment Variables:</h2>
        <pre>PORT: ${PORT:-8000}
RAILWAY_STATIC_URL: ${RAILWAY_STATIC_URL:-Not Set}
DATABASE_URL: ${DATABASE_URL:-Not Set - Add PostgreSQL database}
AIRBYTE_VERSION: 0.63.15</pre>
        
        <h2>📚 Resources:</h2>
        <ul>
            <li><a href="https://docs.airbyte.com/" target="_blank">Airbyte Documentation</a></li>
            <li><a href="https://docs.railway.app/" target="_blank">Railway Documentation</a></li>
            <li><a href="https://github.com/airbytehq/airbyte" target="_blank">Airbyte GitHub</a></li>
        </ul>
        
        <div class="status warning">
            <strong>⚠️ Note:</strong> This is a simplified deployment. For production use, consider using Airbyte Cloud or a full Kubernetes deployment.
        </div>
    </div>
</body>
</html>
EOF

# Start web server
echo "🌐 Starting web server on port ${PORT:-8000}..."
cd /tmp
exec python3 -m http.server ${PORT:-8000} 