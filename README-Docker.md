# Development with Docker

This project includes Docker configuration to facilitate local development.

## Requirements

- Docker
- Docker Compose

## Quick commands

### Start the development server
```bash
docker-compose up
```

### Build the image (only the first time or after Dockerfile changes)
```bash
docker-compose build
```

### Run in background
```bash
docker-compose up -d
```

### Stop the server
```bash
docker-compose down
```

### View logs
```bash
docker-compose logs -f
```

### Run commands inside the container
```bash
# Run Gulp
docker-compose exec jekyll-dev npm run dev

# Run production build
docker-compose exec jekyll-dev npm run production

# Access container shell
docker-compose exec jekyll-dev bash
```

## Ports

- **4000**: Jekyll server (http://localhost:4000)
- **35729**: LiveReload for automatic updates

## Features

- ✅ Automatic hot reload with LiveReload
- ✅ Mounted volumes for real-time development
- ✅ Complete support for Ruby (Jekyll) and Node.js (Gulp)
- ✅ Optimized for mobile-first development
- ✅ Simple and readable structure

## Troubleshooting

### If changes don't reflect
```bash
# Rebuild the image
docker-compose down
docker-compose build --no-cache
docker-compose up
```

### If there are permission issues
```bash
# On macOS/Linux, adjust permissions
sudo chown -R $USER:$USER .
```

### Clean Docker
```bash
# Clean unused containers and images
docker system prune -a
``` 