# 🚀 Onboarding Tutorial - Lilucat.com

## 📋 Index
1. [What is this project?](#what-is-this-project)
2. [Project structure](#project-structure)
3. [Technologies used](#technologies-used)
4. [Initial setup](#initial-setup)
5. [Workflow](#workflow)
6. [How to add a new app](#how-to-add-a-new-app)
7. [Docker for development](#docker-for-development)
8. [Useful commands](#useful-commands)

---

## What is this project?

**Lilucat.com** is a corporate website to showcase Lilucat apps on the App Store. It's built with **Jekyll**, a static site generator that converts Markdown and YAML files into HTML.

### 🎯 Project goals:
- Showcase all Lilucat apps in an attractive way
- Provide detailed information about each app
- Maintain a mobile-first design
- Facilitate content management without technical knowledge

---

## Project structure

```
lilucat.com/
├── _config.yml                 # Main Jekyll configuration
├── _data/                      # Data in YAML format
│   ├── products.yml           # List of all apps
│   ├── nav.yml                # Site navigation
│   ├── footer.yml             # Footer links
│   └── [app-name].yml         # Specific data for each app
├── _includes/                  # Reusable components
│   ├── product-page.html      # Template for app pages
│   ├── nav.html               # Navigation
│   └── footer.html            # Footer
├── _layouts/                   # Main layouts
│   ├── bootstrap.html         # Layout with Bootstrap
│   └── post.html              # Layout for blog posts
├── pages/                      # Static pages
│   ├── [app-name].html        # Page for each app
│   └── about.html             # About page
├── assets/                     # Static resources
│   ├── css/                   # CSS styles
│   ├── js/                    # JavaScript
│   └── img/                   # Images organized by app
└── _posts/                     # Blog posts (if any)
```

---

## Technologies used

### 🛠️ Main stack:
- **Jekyll 4.3.2**: Static site generator
- **Ruby**: Base language for Jekyll
- **Bootstrap 5**: CSS framework for design
- **Node.js**: For build tools (Gulp)

### 📦 Main dependencies:
```yaml
# Gemfile
- jekyll: ~> 4.3.2
- jekyll-sitemap: 1.4.0
- jekyll-seo-tag: 2.8.0
- jekyll-feed: 0.16.0
- webrick: ~> 1.7

# package.json
- gulp: ^4.0.2
- gulp-clean-css: ^4.3.0
- gulp-htmlmin: ^5.0.1
```

---

## Initial setup

### 1. Prerequisites:
```bash
# Install Ruby (if you don't have it)
brew install ruby

# Install Node.js (if you don't have it)
brew install node

# Install Docker (for development)
brew install --cask docker
```

### 2. Clone and configure:
```bash
# Clone the repository
git clone [REPO_URL]
cd lilucat.com

# Install Ruby dependencies
bundle install

# Install Node.js dependencies
npm install
```

### 3. Docker configuration:
```bash
# Build Docker image
docker-compose build

# Start development server
docker-compose up
```

---

## Workflow

### 🔄 Development process:

1. **Edit content** → Modify YAML or HTML files
2. **See changes** → Jekyll regenerates automatically
3. **Test** → Navigate to localhost:4000
4. **Commit** → Save changes to Git
5. **Deploy** → Upload to production

### 📝 Types of files you'll edit:

#### Data files (`_data/`):
- **`products.yml`**: Main app list
- **`[app-name].yml`**: Specific features for each app

#### Pages (`pages/`):
- **`[app-name].html`**: Individual page for each app

#### Resources (`assets/`):
- **`img/[app-name]/`**: Images for each app

---

## How to add a new app

### 📱 Step by step:

#### 1. Add entry in `_data/products.yml`:
```yaml
- name: "App Name"
  url: "https://apps.apple.com/us/app/..."
  description: "App description..."
  subtitle: "Descriptive subtitle"
  icon: "/assets/img/app-name/app-icon.png"
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

#### 2. Create page in `pages/app-name.html`:
```html
---
layout: bootstrap
title: "App Name"
description: "SEO description"
permalink: "/app-name/"
data: data
index: 6  # Sequential number (starts at 0)
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

#### 3. Create data in `_data/app-name.yml`:
```yaml
data:
  - name: "Feature 1"
    description: "Feature description..."
    icon: "/assets/img/app-name/feature1-icon.png"
    screenshot: "/assets/img/app-name/feature1-screenshot.png"
  
  - name: "Feature 2"
    description: "Feature description..."
    icon: "/assets/img/app-name/feature2-icon.png"
    screenshot: "/assets/img/app-name/feature2-screenshot.png"
```

#### 4. Add images:
```
assets/img/app-name/
├── app-icon.png
├── feature1-icon.png
├── feature1-screenshot.png
├── feature2-icon.png
└── feature2-screenshot.png
```

---

## Docker for development

### 🐳 Docker configuration:

#### Created files:
- **`Dockerfile`**: Image with Ruby + Node.js
- **`docker-compose.yml`**: Development configuration
- **`.dockerignore`**: Files to exclude from build

#### Main commands:
```bash
# Start development
docker-compose up --build

# View logs
docker-compose logs -f

# Run commands inside container
docker-compose exec jekyll-dev bundle exec jekyll build

# Stop server
docker-compose down
```

#### Ports:
- **4000**: Jekyll server
- **35729**: LiveReload

---

## Useful commands

### 🛠️ Local development (without Docker):
```bash
# Development server
bundle exec jekyll serve --livereload

# Production build
bundle exec jekyll build

# Clean and rebuild
rm -rf _site && bundle exec jekyll build
```

### 🐳 With Docker:
```bash
# Start development
docker-compose up

# Complete rebuild
docker-compose down
docker-compose build --no-cache
docker-compose up

# View real-time logs
docker-compose logs -f
```

### 📦 Gulp (optimization):
```bash
# Minify files
npm run dev

# Production build
npm run production
```

---

## 🎯 Project principles

### 📱 Mobile-first:
- All design is optimized for mobile first
- Bootstrap 5 with responsive breakpoints
- Images optimized for different sizes

### 🧩 Reusable components:
- Templates in `_includes/` to reuse code
- Centralized data in `_data/`
- Consistent structure across all pages

### 🚀 Simplicity:
- No unnecessary tools
- Clear folder structure
- Readable and well-commented code

---

## 🔧 Troubleshooting

### Common problems:

#### Docker won't start:
```bash
# Check if Docker Desktop is running
open -a Docker

# Check status
docker info
```

#### Ruby dependencies:
```bash
# Reinstall gems
bundle clean --force
bundle install
```

#### Permission problems:
```bash
# On macOS/Linux
sudo chown -R $USER:$USER .
```

#### Jekyll cache:
```bash
# Clear cache
bundle exec jekyll clean
rm -rf .jekyll-cache
```

---

## 📚 Additional resources

### Official documentation:
- [Jekyll Docs](https://jekyllrb.com/docs/)
- [Bootstrap 5](https://getbootstrap.com/docs/5.0/)
- [Liquid Template Language](https://shopify.github.io/liquid/)

### Useful tools:
- **Jekyll Admin**: Web interface to edit content
- **Jekyll SEO Tag**: Automatic SEO optimization
- **Jekyll Sitemap**: Automatic sitemap generation

---

## 🎉 Ready to start!

Now you have all the information needed to work with the project. Remember:

1. **Always use Docker** for development
2. **Follow the structure** of existing files
3. **Keep mobile-first** in mind
4. **Use reusable components** when possible

Happy coding! 🚀 