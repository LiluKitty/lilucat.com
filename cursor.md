# Style Guide for Cursor - Lilucat.com

## 🎯 Project Philosophy

This is a Jekyll website for **Lilucat**, a company that develops simple and useful iOS apps. The project follows principles of **simplicity**, **readability**, and **mobile-first**.

## 🏗️ Project Architecture

### Folder Structure
```
lilucat.com/
├── _config.yml          # Main Jekyll configuration
├── _data/               # Structured data (YAML)
├── _includes/           # Reusable components
├── _layouts/            # Page templates
├── _plugins/            # Custom plugins (Ruby)
├── _posts/              # Blog posts organized by category
├── assets/              # Static assets
│   ├── css/            # CSS styles
│   ├── js/             # JavaScript
│   └── img/            # Images organized by product
├── pages/               # Static pages
└── Gemfile             # Ruby dependencies
```

## 📝 Code Conventions

### Language and Content
- **All text must be written in English**: Titles, descriptions, page content, blog posts
- **Consistent language**: Keep the same language throughout the site
- **SEO optimized**: Use English terms for better search ranking
- **Global audience**: English content reaches more users

### HTML/Liquid Templates

#### Includes Structure
- **Descriptive names**: `product-page.html`, `nav.html`, `footer.html`
- **Responsive design**: Always mobile-first
- **Accessibility**: Include `alt`, `title`, `rel="noopener"` in external links
- **Content in English**: All user-visible text

#### Example Include:
```html
{% assign product = site.data.products.data[page.index] %}
<img class="rounded-4 shadow-sm mb-md-4 mb-3" 
     src="{{ product.icon }}" 
     alt="{{ product.name }} Icon" 
     title="{{ product.name }} Icon" 
     width="76" height="76" 
     loading="lazy">
```

### CSS

#### Organization
- **Mobile-first**: Media queries for larger screens
- **Utility classes**: Use Bootstrap 5 + custom classes
- **Smooth transitions**: `transition: 0.25s ease-in-out`
- **Comments**: Only when logic is complex

#### Example Style:
```css
.hover {
  border-radius: 0.5rem;
  transition: 
    background-color 0.25s ease-in-out,
    box-shadow 0.25s ease-in-out,
    border-color 0.25s ease-in-out, 
    transform 0.25s ease-in-out;
}

.hover:hover {
  box-shadow: 0 0.2rem 0.5rem rgba(0,0,0,.05);
  border-radius: 0.5rem;
  transform: scale(1.01, 1.01);
}
```

### JavaScript

#### Structure
- **Simple functions**: One function per file when possible
- **Descriptive names**: `thankYou()`, `needImprove()`
- **Tracking**: Splitbee integration for analytics

#### Example:
```javascript
function thankYou() {
    document.getElementById("helpful").innerHTML = '<div class="py-2">Thank You!</div>';
    splitbee.track("helpful: Yes");
}
```

### YAML (Data Files)

#### Data Structure
- **Consistent indentation**: 2 spaces
- **Descriptive names**: `products.yml`, `nav.yml`
- **Logical organization**: Group related data

#### Example:
```yaml
data:
  - name: QR
    url: https://apps.apple.com/us/app/qr/id6745213752
    description: Scan any QR code instantly and create your own custom codes.
    subtitle: Code Reader Scanner Generator
    icon: /assets/img/QR/qr-app-icon.png
    rating: 4.8
    ratings: 125
```

### Ruby (Plugins)

#### Structure
- **Descriptive comments**: Explain the plugin's purpose
- **Module names**: PascalCase
- **Documentation**: Include usage examples

#### Example:
```ruby
# frozen_string_literal: true

# capitalizewords / https://github.com/jasoncomes/Capitalize-Words-Liquid-Filter
# Takes a string or variable and capitalizes the first letter of every word.
# {{ string | capitalizewords }}

module CapitalizeWords
  def capitalizewords(words)
    words.to_s.split(' ').map(&:capitalize).join(' ')
  end
end

Liquid::Template.register_filter(CapitalizeWords)
```

## 🎨 Design System

### UI Components
- **Buttons**: Use Bootstrap classes + custom styles
- **Cards**: Rounded borders (`rounded-4`), subtle shadows
- **Navigation**: Blur effect, smooth transitions
- **Icons**: Bootstrap Icons + inline SVG when needed

### Color Palette
- **Primary**: Bootstrap default + customizations
- **Secondary**: `text-body-secondary` for secondary text
- **Success**: `#28a745` (green)
- **Info**: `#0366d6` (blue)

### Typography
- **Clear hierarchy**: `display-5`, `fs-4`, `h5`
- **Weights**: `fw-bold`, `fw-semibold`, `fw-normal`
- **Responsive**: Adaptive sizes

## 📱 Mobile-First

### Principles
1. **Mobile-first design**: Base CSS for mobile
2. **Progressive media queries**: `@media (min-width: 768px)`
3. **Touch-friendly**: Minimum 44px for interactive elements
4. **Performance**: Lazy loading for images

#### Responsive Example:
```css
@media (max-width: 767.98px) {
  body {
    padding-top: 50px;
  }
}

@media (min-width: 768px) {
  .change-log {
    margin-left: 74px;
  }
}
```

## 🔧 Tools and Build

### Gulp Tasks
- **Minification**: JS, CSS, HTML
- **Optimization**: CSS selectors, compression
- **Compatibility**: IE8 for CSS

### Jekyll
- **Plugins**: SEO, sitemap, feed, last-modified
- **Sass**: Compressed style
- **Live reload**: For development

## 📁 File Organization

### Images
```
assets/img/
├── [product]/          # One folder per product
│   ├── Icon-1024.png   # Main icon
│   ├── screenshot-01.png
│   └── [other assets]
├── blog/               # Blog images
└── [categories]/
```

### Blog Posts
```
_posts/
├── [category]/        # Organized by category
│   ├── YYYY-MM-DD-title.md
│   └── ...
```

## 🚀 Development Scripts

### Package.json
```json
{
  "scripts": {
    "dev": "rm -rf Gemfile.lock && bundle exec jekyll serve --livereload --trace",
    "production": "rm -rf _site && bundle exec jekyll build --trace && git add . -A && git commit -a -m 'update' && git push origin master --force"
  }
}
```

## 📋 Quality Checklist

### Before Commit
- [ ] Code is readable and well-commented
- [ ] Mobile-first responsive design
- [ ] Basic accessibility (alt, title, etc.)
- [ ] Performance optimized (lazy loading, minification)
- [ ] Consistent with the existing design system

### Component Structure
- [ ] Descriptive and consistent names
- [ ] Reuse when possible
- [ ] Separation of concerns
- [ ] Documentation when needed

## 🎯 Reminder

**"You are a simple programmer, you opt for code readability and best practices. Leave comments when things get tricky."**

- Prioritize simplicity over complexity
- Keep code readable and maintainable
- Use existing tools before adding new ones
- Build a coherent design system
- **Always mobile-first**

## 🖼️ Image Optimization

### Product Screenshots Optimization Process

#### Standard Dimensions
- **App icons**: 76×76 px (consistent across site)

#### Optimization Workflow
1. **Resize**: Convert to target dimensions using `sips`
   ```bash
   sips -z 402 320 original.png --out resized.png
   ```
2. **Convert**: PNG to WebP using `cwebp` with quality 80
   ```bash
   cwebp resized.png -o optimized.webp
   ```
3. **Update**: YAML data files to reference new WebP images
4. **Clean**: Remove temporary PNG files

#### Expected Results
- **Format**: WebP with excellent compression
- **Quality**: Maintained visual quality at 100% compression
- **Performance**: Faster loading, better Core Web Vitals

#### File Naming Convention
- **Screenshots**: `Product-Feature-320x402.webp`
- **Icons**: `product-icon-76x76.webp`
- **Logos**: `publication-logo-172x56.webp`

#### Benefits
- **Faster loading**: Significantly smaller file sizes
- **Better performance**: Reduced bandwidth usage
- **Mobile-optimized**: Correct dimensions for mobile screens
- **Modern format**: WebP with universal browser support
- **SEO friendly**: Better page speed scores

---

*This guide reflects the best practices observed in the current project and should evolve over time.* 