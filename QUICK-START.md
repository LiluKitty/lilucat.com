# ⚡ Quick Start - Lilucat.com

## 🚀 In 3 steps

### 1. Start Docker
```bash
# Make sure Docker Desktop is running
open -a Docker
```

### 2. Build and run
```bash
# Build the image (only the first time)
docker-compose build

# Start the development server
docker-compose up
```

### 3. Open in browser
```
http://localhost:4000
```

---

## 📱 Available apps

| App | URL | Status |
|-----|-----|--------|
| QR | `/qr/` | ✅ Active |
| App Lock | `/app-lock/` | ✅ Active |
| Storage Cleaner | `/storage-cleaner/` | ✅ Active |
| Clean Up iPhone | `/clean-up-iphone/` | ✅ Active |
| Photo Vault X | `/photo-vault-x/` | ✅ Active |
| QR Code Reader | `/qr-code-reader/` | ✅ Active |

---

## 🔧 Essential commands

```bash
# View real-time logs
docker-compose logs -f

# Stop server
docker-compose down

# Complete rebuild
docker-compose down && docker-compose build --no-cache && docker-compose up

# Run command inside container
docker-compose exec jekyll-dev bash
```

---

## 📁 Key structure

```
_data/products.yml          # List of all apps
pages/[app-name].html       # Page for each app
_data/[app-name].yml        # Data for each app
assets/img/[app-name]/      # Images for each app
```

---

## 🎯 Next steps

1. **Review** the `ONBOARDING.md` file to understand the complete project
2. **Explore** existing pages at `localhost:4000`
3. **Modify** content in YAML files
4. **Add** new apps following the existing pattern

Ready! 🎉 