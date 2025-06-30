# Guía de Estilo para Cursor - Lilucat.com

## 🎯 Filosofía del Proyecto

Este es un sitio web Jekyll para **Lilucat**, una empresa que desarrolla aplicaciones iOS simples y útiles. El proyecto sigue principios de **simplicidad**, **legibilidad** y **mobile-first**.

## 🏗️ Arquitectura del Proyecto

### Estructura de Carpetas
```
lilucat.com/
├── _config.yml          # Configuración principal de Jekyll
├── _data/               # Datos estructurados (YAML)
├── _includes/           # Componentes reutilizables
├── _layouts/            # Plantillas de página
├── _plugins/            # Plugins personalizados (Ruby)
├── _posts/              # Posts del blog organizados por categoría
├── assets/              # Recursos estáticos
│   ├── css/            # Estilos CSS
│   ├── js/             # JavaScript
│   └── img/            # Imágenes organizadas por producto
├── pages/               # Páginas estáticas
└── Gemfile             # Dependencias de Ruby
```

## 📝 Convenciones de Código

### Idioma y Contenido
- **Todos los textos deben escribirse en inglés**: Títulos, descripciones, contenido de páginas, posts del blog
- **Consistencia lingüística**: Mantener el mismo idioma en todo el sitio
- **SEO optimizado**: Usar términos en inglés para mejor posicionamiento
- **Audiencia global**: El contenido en inglés permite llegar a más usuarios

### HTML/Liquid Templates

#### Estructura de Includes
- **Nombres descriptivos**: `product-page.html`, `nav.html`, `footer.html`
- **Responsive design**: Siempre mobile-first
- **Accesibilidad**: Incluir `alt`, `title`, `rel="noopener"` en enlaces externos
- **Contenido en inglés**: Todos los textos visibles al usuario

#### Ejemplo de Include:
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

#### Organización
- **Mobile-first**: Media queries para pantallas más grandes
- **Clases utilitarias**: Usar Bootstrap 5 + clases personalizadas
- **Transiciones suaves**: `transition: 0.25s ease-in-out`
- **Comentarios**: Solo cuando la lógica es compleja

#### Ejemplo de Estilo:
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

#### Estructura
- **Funciones simples**: Una función por archivo cuando sea posible
- **Nombres descriptivos**: `thankYou()`, `needImprove()`
- **Tracking**: Integración con Splitbee para analytics

#### Ejemplo:
```javascript
function thankYou() {
    document.getElementById("helpful").innerHTML = '<div class="py-2">Thank You!</div>';
    splitbee.track("helpful: Yes");
}
```

### YAML (Data Files)

#### Estructura de Datos
- **Indentación consistente**: 2 espacios
- **Nombres descriptivos**: `products.yml`, `nav.yml`
- **Organización lógica**: Agrupar datos relacionados

#### Ejemplo:
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

#### Estructura
- **Comentarios descriptivos**: Explicar el propósito del plugin
- **Nombres de módulos**: PascalCase
- **Documentación**: Incluir ejemplos de uso

#### Ejemplo:
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

## 🎨 Sistema de Diseño

### Componentes UI
- **Botones**: Usar clases Bootstrap + personalizadas
- **Cards**: Bordes redondeados (`rounded-4`), sombras sutiles
- **Navegación**: Efecto blur, transiciones suaves
- **Iconos**: Bootstrap Icons + SVG inline cuando sea necesario

### Paleta de Colores
- **Primario**: Bootstrap default + personalizaciones
- **Secundario**: `text-body-secondary` para texto secundario
- **Éxito**: `#28a745` (verde)
- **Info**: `#0366d6` (azul)

### Tipografía
- **Jerarquía clara**: `display-5`, `fs-4`, `h5`
- **Pesos**: `fw-bold`, `fw-semibold`, `fw-normal`
- **Responsive**: Tamaños adaptativos

## 📱 Mobile-First

### Principios
1. **Diseño mobile primero**: CSS base para móviles
2. **Media queries progresivas**: `@media (min-width: 768px)`
3. **Touch-friendly**: Tamaños mínimos de 44px para elementos interactivos
4. **Performance**: Lazy loading para imágenes

### Ejemplo de Responsive:
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

## 🔧 Herramientas y Build

### Gulp Tasks
- **Minificación**: JS, CSS, HTML
- **Optimización**: Selectores CSS, compresión
- **Compatibilidad**: IE8 para CSS

### Jekyll
- **Plugins**: SEO, sitemap, feed, last-modified
- **Sass**: Compressed style
- **Live reload**: Para desarrollo

## 📁 Organización de Archivos

### Imágenes
```
assets/img/
├── [producto]/          # Una carpeta por producto
│   ├── Icon-1024.png   # Icono principal
│   ├── screenshot-01.png
│   └── [otros assets]
├── blog/               # Imágenes del blog
└── [categorías]/
```

### Posts del Blog
```
_posts/
├── [categoría]/        # Organizar por categoría
│   ├── YYYY-MM-DD-titulo.md
│   └── ...
```

## 🚀 Scripts de Desarrollo

### Package.json
```json
{
  "scripts": {
    "dev": "rm -rf Gemfile.lock && bundle exec jekyll serve --livereload --trace",
    "production": "rm -rf _site && bundle exec jekyll build --trace && git add . -A && git commit -a -m 'update' && git push origin master --force"
  }
}
```

## 📋 Checklist de Calidad

### Antes de Commit
- [ ] Código es legible y bien comentado
- [ ] Mobile-first responsive design
- [ ] Accesibilidad básica (alt, title, etc.)
- [ ] Performance optimizada (lazy loading, minificación)
- [ ] Consistencia con el sistema de diseño existente

### Estructura de Componentes
- [ ] Nombres descriptivos y consistentes
- [ ] Reutilización cuando sea posible
- [ ] Separación de responsabilidades
- [ ] Documentación cuando sea necesario

## 🎯 Recordatorio

**"Eres un programador simple, optas por la legibilidad del código y las buenas prácticas. Dejas comentarios cuando la cosa se pone difícil."**

- Prioriza la simplicidad sobre la complejidad
- Mantén el código legible y mantenible
- Usa herramientas existentes antes de agregar nuevas
- Construye un sistema de diseño coherente
- **Mobile-first siempre**

---

*Esta guía refleja las mejores prácticas observadas en el proyecto actual y debe evolucionar con el tiempo.* 