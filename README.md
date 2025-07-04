# 🚀 Lilucat.com - Corporate Website

Corporate website to showcase Lilucat apps on the App Store. Built with **Jekyll** for easy content management and **mobile-first** design.

## ⚡ Quick Start

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

## 📱 Available Apps

| App | URL | Status |
|-----|-----|--------|
| QR | `/qr/` | ✅ Active |
| App Lock | `/app-lock/` | ✅ Active |
| QR Code Reader | `/qr-code-reader/` | ✅ Active |
| Storage Cleaner | `/storage-cleaner/` | ✅ Active |
| Clean Up iPhone | `/clean-up-iphone/` | ✅ Active |
| Photo Vault X | `/photo-vault-x/` | ✅ Active |
| Screenfree | `/screenfree/` | ✅ Active |
| AI Math Solver | `/ai-math-solver/` | ✅ Active |
| AI PDF Scanner | `/ai-pdf-scanner/` | ✅ Active |

---

## 🛠️ Development Commands

### Docker (Recommended)
```bash
# Start development server
docker-compose up

# View real-time logs
docker-compose logs -f

# Stop server
docker-compose down

# Complete rebuild
docker-compose down && docker-compose build --no-cache && docker-compose up

# Run command inside container
docker-compose exec jekyll-dev bash
```

### Local Development
```bash
# Install dependencies
bundle install
npm install

# Development server
bundle exec jekyll serve --livereload

# Production build
bundle exec jekyll build
```

---

## 📁 Project Structure

```
lilucat.com/
├── _config.yml                 # Main Jekyll configuration
├── _data/                      # Data in YAML format
│   ├── products.yml           # List of all apps
│   ├── nav.yml                # Site navigation
│   └── [app-name].yml         # Specific data for each app
├── _includes/                  # Reusable components
│   ├── product-page.html      # Template for app pages
│   ├── nav.html               # Navigation
│   └── footer.html            # Footer
├── pages/                      # Static pages
│   ├── [app-name].html        # Page for each app
│   └── about.html             # About page
├── assets/                     # Static resources
│   ├── css/                   # CSS styles
│   ├── js/                    # JavaScript
│   └── img/                   # Images organized by app
└── _posts/                     # Blog posts
```

---

## 🎯 How to Add a New App

### 1. Add entry in `_data/products.yml`:
```yaml
- name: "App Name"
  url: "https://apps.apple.com/us/app/..."
  description: "App description..."
  subtitle: "Descriptive subtitle"
  icon: "/assets/img/app-name/app-icon.webp"
  badge: "https://one-badge.com/b/apple/appstore.svg"
  rating: 4.5
  ratings: 100
  legal:
    option:
      - name: "Privacy Policy"
        url: "https://app.lilucat.com/legal/privacy"
      - name: "Terms of Service"
        url: "https://app.lilucat.com/legal/terms"
  page: "app-name"
```

### 2. Create page in `pages/app-name.html`:
```html
---
layout: bootstrap
title: "App Name"
description: "SEO description"
permalink: "/app-name/"
data: data
index: 6
app_id: 1234567890
---
<div class="container pb-md-5 pb-4 mt-3">
  <div class="px-md-5 pt-md-3 pt-2 mb-4 bg-light rounded-img mx-auto text-center">
    <div class="container-fluid py-md-5 py-3">
      {%- include product-page.html -%}
    </div>
  </div>
  <div class="row align-items-md-stretch">
    {% for feature in site.data.app-name.data %}
    <div class="col-lg-4 mb-4">
      <div class="h-100 p-md-5 p-4 pb-0 pb-md-0 bg-body-tertiary rounded-img text-start"> 
        <img src="{{ feature.icon }}" width="42" class="mb-3 shadow-sm rounded-3" alt="{{ feature.name }} Icon">
        <h2 class="pb-2 m-0 fw-semibold">{{ feature.name }}</h2>
        <p class="text-start lead fw-normal text-body-secondary">{{ feature.description }}</p>
        <img src="{{ feature.screenshot }}" class="w-100" alt="{{ feature.name }} Screenshot">
      </div>
    </div>
    {% endfor %}
  </div>
</div>
```

### 3. Create data in `_data/app-name.yml`:
```yaml
data:
  - name: "Feature 1"
    description: "Feature description..."
    icon: "/assets/img/app-name/feature1-icon.png"
    screenshot: "/assets/img/app-name/feature1-screenshot.png"
```

### 4. Add images:
```
assets/img/app-name/
├── app-icon.webp
├── feature1-icon.png
└── feature1-screenshot.png
```

---

## 🛠️ Technologies

### Main Stack
- **Jekyll 4.4.1**: Static site generator
- **Ruby**: Base language for Jekyll
- **Bootstrap 5**: CSS framework for design
- **Node.js**: For build tools (Gulp)

### Key Dependencies
```yaml
# Jekyll Plugins
- jekyll-sitemap: 1.4.0
- jekyll-seo-tag: 2.8.0
- jekyll-feed: 0.17.0
- jekyll-last-modified-at: 1.3.2

# Build Tools
- gulp: ^4.0.2
- gulp-clean-css: ^4.3.0
- gulp-htmlmin: ^5.0.1
```

---

## 🐳 Docker Configuration

### Ports
- **4000**: Jekyll server (http://localhost:4000)
- **35729**: LiveReload for automatic updates

### Features
- ✅ Automatic hot reload with LiveReload
- ✅ Mounted volumes for real-time development
- ✅ Complete support for Ruby (Jekyll) and Node.js (Gulp)
- ✅ Optimized for mobile-first development

---

## 🔧 Troubleshooting

### Docker Issues
```bash
# If changes don't reflect
docker-compose down
docker-compose build --no-cache
docker-compose up

# If there are permission issues (macOS/Linux)
sudo chown -R $USER:$USER .

# Clean Docker
docker system prune -a
```

### Jekyll Issues
```bash
# Clear cache
bundle exec jekyll clean
rm -rf .jekyll-cache

# Reinstall gems
bundle clean --force
bundle install
```

---

## 📚 Project Principles

### 📱 Mobile-First
- All design is optimized for mobile first
- Bootstrap 5 with responsive breakpoints
- Images optimized for different sizes

### 🧩 Reusable Components
- Templates in `_includes/` to reuse code
- Centralized data in `_data/`
- Consistent structure across all pages

### 🚀 Simplicity
- No unnecessary tools
- Clear folder structure
- Readable and well-commented code

---

## 🎉 Ready to Start!

1. **Always use Docker** for development
2. **Follow the structure** of existing files
3. **Keep mobile-first** in mind
4. **Use reusable components** when possible

Happy coding! 🚀