# 🏗️ Project Architecture

## 📊 Flow diagram

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Data Files    │    │   Jekyll        │    │   Browser       │
│                 │    │   Generator     │    │   (User)        │
│                 │    │                 │    │                 │
│ • products.yml  │───▶│ • Process YAML  │───▶│ • Static HTML   │
│ • nav.yml       │    │ • Generate HTML │    │ • CSS/JS        │
│ • [app].yml     │    │ • Optimize      │    │ • Images        │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         ▼                       ▼                       ▼
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Templates     │    │   Assets        │    │   LiveReload    │
│                 │    │                 │    │                 │
│ • product-page  │    │ • CSS/JS        │    │ • Auto-refresh  │
│ • nav.html      │    │ • Images        │    │ • Hot reload    │
│ • footer.html   │    │ • Fonts         │    │ • 35729 port    │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

## 🔄 Data flow

### 1. **Data input** (`_data/`)
```yaml
# products.yml - Main list
- name: "App Name"
  url: "https://apps.apple.com/..."
  description: "App description"
  page: "app-name"

# app-name.yml - Specific features
data:
  - name: "Feature 1"
    description: "Feature description"
```

### 2. **Processing** (Jekyll)
- Read YAML files
- Apply Liquid templates
- Generate static HTML
- Optimize assets

### 3. **Output** (Browser)
- Rendered HTML
- Optimized CSS/JS
- Compressed images
- SEO optimized

## 🧩 Main components

### 📁 File structure:
```
lilucat.com/
├── _config.yml              # ⚙️ Jekyll configuration
├── _data/                   # 📊 Centralized data
│   ├── products.yml        # 📱 App list
│   ├── nav.yml             # 🧭 Navigation
│   └── [app].yml           # 🎯 Data for each app
├── _includes/              # 🧩 Reusable components
│   ├── product-page.html   # 📄 App template
│   ├── nav.html            # 🧭 Navigation
│   └── footer.html         # 🦶 Footer
├── _layouts/               # 📐 Base layouts
│   └── bootstrap.html      # 🎨 Layout with Bootstrap
├── pages/                  # 📄 Static pages
│   └── [app].html          # 📱 Page for each app
└── assets/                 # 🎨 Static resources
    ├── css/                # 🎨 Styles
    ├── js/                 # ⚡ JavaScript
    └── img/                # 🖼️ Images
```

## 🔧 Technologies and tools

### 🛠️ Main stack:
```
┌─────────────┐  ┌─────────────┐  ┌─────────────┐
│   Ruby      │  │   Jekyll    │  │  Bootstrap  │
│  3.2+       │  │   4.3.2     │  │     5.0     │
└─────────────┘  └─────────────┘  └─────────────┘
       │               │               │
       ▼               ▼               ▼
┌─────────────┐  ┌─────────────┐  ┌─────────────┐
│   Node.js   │  │    Gulp     │  │   Docker    │
│  18+        │  │   4.0.2     │  │  Desktop    │
└─────────────┘  └─────────────┘  └─────────────┘
```

### 📦 Jekyll plugins:
- `jekyll-sitemap`: Automatically generates sitemap
- `jekyll-seo-tag`: SEO optimization
- `jekyll-feed`: RSS feed for blog
- `jekyll-last-modified-at`: Timestamps

## 🎯 Design patterns

### 1. **Mobile-first**
```css
/* Base styles for mobile */
.container { padding: 1rem; }

/* Media queries for desktop */
@media (min-width: 768px) {
  .container { padding: 2rem; }
}
```

### 2. **Reusable components**
```html
<!-- _includes/product-page.html -->
{%- include product-page.html -%}

<!-- _includes/nav.html -->
{%- include nav.html -%}
```

### 3. **Centralized data**
```yaml
# _data/products.yml
- name: "App Name"
  page: "app-name"

# pages/app-name.html
{% for feature in site.data.app-name.data %}
  <!-- Render features -->
{% endfor %}
```

## 🚀 Optimizations

### 📈 Performance:
- **Static HTML**: Fast loading
- **Minified CSS/JS**: Reduced size
- **Optimized images**: WebP + fallbacks
- **Lazy loading**: Deferred loading

### 🔍 SEO:
- **Automatic meta tags**: Jekyll SEO Tag
- **Automatic sitemap**: Jekyll Sitemap
- **Friendly URLs**: Custom permalinks
- **Schema markup**: Structured data

### 📱 Responsive:
- **Bootstrap 5**: Responsive grid system
- **Breakpoints**: Mobile, tablet, desktop
- **Touch-friendly**: Touchable buttons and links

## 🔄 Development workflow

### 1. **Editing**:
```bash
# Edit YAML/HTML files
code _data/products.yml
code pages/new-app.html
```

### 2. **Development**:
```bash
# Server with hot reload
docker-compose up
```

### 3. **Build**:
```bash
# Generate static site
docker-compose exec jekyll-dev bundle exec jekyll build
```

### 4. **Deploy**:
```bash
# Upload to production
git add . && git commit -m "Update" && git push
```

## 🎨 Design system

### 📐 Layouts:
- **Bootstrap**: Base CSS framework
- **Custom CSS**: Specific styles in `assets/css/local.css`
- **Variables**: Consistent colors and typography

### 🧩 Components:
- **Cards**: To display app features
- **Buttons**: CTA for App Store
- **Navigation**: Responsive menu
- **Footer**: Links and information

### 📱 Breakpoints:
- **Mobile**: < 768px
- **Tablet**: 768px - 992px
- **Desktop**: > 992px

---

## 🎯 Architectural principles

1. **Simplicity**: Clear and easy to understand structure
2. **Reusability**: Reusable components and templates
3. **Maintainability**: Clean and well-organized code
4. **Scalability**: Easy to add new apps
5. **Performance**: Optimized for speed
6. **Mobile-first**: Responsive design from mobile 