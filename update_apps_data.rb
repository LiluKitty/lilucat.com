#!/usr/bin/env ruby

require 'net/http'
require 'json'
require 'yaml'
require 'fileutils'
require 'open-uri'

# Configuración
DEVELOPER_ID = "1676061700"
CONFIG_FILE = "_config.yml"
ASSETS_DIR = "assets/img"

def fetch_developer_apps(developer_id)
  url = URI("https://itunes.apple.com/lookup?id=#{developer_id}&entity=software")
  
  begin
    response = Net::HTTP.get(url)
    json = JSON.parse(response)
    
    if json['results'] && json['results'].any?
      # El primer resultado es info del desarrollador, los demás son apps
      return json['results'][1..-1] || []
    end
  rescue => e
    puts "Error fetching developer apps: #{e}"
  end
  
  []
end

def download_image(url, local_path)
  return false unless url
  
  begin
    # Crear directorio si no existe
    FileUtils.mkdir_p(File.dirname(local_path))
    
    # Descargar imagen
    URI.open(url) do |image|
      File.open(local_path, "wb") do |file|
        file.write(image.read)
      end
    end
    
    puts "✅ Downloaded: #{local_path}"
    return true
  rescue => e
    puts "❌ Error downloading #{url}: #{e}"
    return false
  end
end

def find_app_by_id(apps, app_id)
  apps.find { |app| app['trackId'].to_s == app_id.to_s }
end

def extract_legal_links_from_description(description)
  return {} unless description
  
  legal_links = {}
  
  # Buscar la sección "Links" al final de la descripción
  if description.include?("\nLinks\n")
    links_section = description.split("\nLinks\n").last
    
    # Buscar enlaces de Terms of Service
    terms_match = links_section.match(/Terms of Service:\s*(https?:\/\/[^\s\n]+)/i)
    if terms_match
      legal_links['terms'] = terms_match[1]
    end
    
    # Buscar enlaces de Privacy
    privacy_match = links_section.match(/Privacy:\s*(https?:\/\/[^\s\n]+)/i)
    if privacy_match
      legal_links['privacy'] = privacy_match[1]
    end
  end
  
  # Fallback: buscar en toda la descripción si no se encuentra la sección Links
  if legal_links.empty?
    # Buscar enlaces de privacy policy (formato alternativo)
    privacy_policy_match = description.match(/privacy\s+policy[:\s]*([^\s\n]+)/i)
    if privacy_policy_match
      legal_links['privacy'] = privacy_policy_match[1]
    end
    
    # Buscar enlaces de terms of service (formato alternativo)
    terms_service_match = description.match(/terms\s+of\s+service[:\s]*([^\s\n]+)/i)
    if terms_service_match
      legal_links['terms'] = terms_service_match[1]
    end
    
    # Buscar URLs que contengan "privacy" o "terms"
    urls = description.scan(/https?:\/\/[^\s\n]+/)
    urls.each do |url|
      if url.downcase.include?('privacy') && !legal_links['privacy']
        legal_links['privacy'] = url
      elsif url.downcase.include?('terms') && !legal_links['terms']
        legal_links['terms'] = url
      end
    end
  end
  
  legal_links
end

def update_legal_links(app_data, app)
  # Extraer enlaces legales de la descripción de la app
  legal_links = extract_legal_links_from_description(app['description'])
  
  if legal_links.any?
    # Inicializar sección legal si no existe
    app_data['legal'] ||= {}
    
    # Actualizar enlaces encontrados
    legal_links.each do |type, url|
      app_data['legal'][type] = url
      puts "  🔗 Found #{type} link: #{url}"
    end
  else
    puts "  ⚠️  No legal links found in description"
  end
end

def update_config_with_apps(apps)
  # Leer configuración actual
  config = YAML.load_file(CONFIG_FILE)
  ios_apps = config['ios_apps'] || {}
  
  # Crear un hash de apps por ID para búsqueda rápida
  apps_by_id = {}
  apps.each do |app|
    apps_by_id[app['trackId'].to_s] = app
  end
  
  ios_apps.each do |config_key, app_data|
    app_id = app_data['id']
    
    if app_id && apps_by_id[app_id.to_s]
      app = apps_by_id[app_id.to_s]
      app_name = app['trackName']
      
      puts "📱 Processing: #{app_name} (#{config_key}) - ID: #{app_id}"
      
      # Verificar si tiene versión Mac
      has_mac_version = app['supportedDevices']&.include?('Mac') || false
      
      # Actualizar datos de la app preservando descripción existente
      app_data.update({
        'name' => app_name,
        'description' => app_data['description'] || app['description'] || '',
        'subtitle' => app['subtitle'] || app_data['subtitle'] || '',
        'rating' => app['averageUserRating'] || 0.0,
        'ratings_count' => app['userRatingCount'] || 0,
        'has_mac_version' => has_mac_version,
        'last_updated' => app['currentVersionReleaseDate'],
        'release_date' => app['releaseDate']
      })
      
      # Actualizar enlaces legales desde la descripción
      update_legal_links(app_data, app)
      
      # Descargar ícono si no existe
      if app['artworkUrl512'] && !File.exist?(app_data['icon'].sub('/', ''))
        icon_path = app_data['icon'].sub('/', '')
        download_image(app['artworkUrl512'], icon_path)
      end
      
      last_updated = app['currentVersionReleaseDate'] ? Time.parse(app['currentVersionReleaseDate']).strftime('%Y-%m-%d') : 'Unknown'
      puts "  ✅ Updated: #{app_name} (Mac version: #{has_mac_version}, Last update: #{last_updated})"
    else
      puts "⚠️  App not found in iTunes: #{config_key} (ID: #{app_id})"
    end
  end
  
  # Ordenar apps por fecha de última actualización (más reciente primero)
  sorted_apps = ios_apps.sort_by { |key, app_data| 
    if app_data['last_updated']
      Time.parse(app_data['last_updated'])
    else
      Time.at(0) # Apps sin fecha van al final
    end
  }.reverse.to_h
  
  # Escribir configuración actualizada y ordenada
  config['ios_apps'] = sorted_apps
  File.write(CONFIG_FILE, config.to_yaml)
  
  puts "\n✅ Configuration updated and sorted by last update: #{CONFIG_FILE}"
  
  # Mostrar el orden final
  puts "\n📱 Apps ordered by last update (newest first):"
  sorted_apps.each do |key, app_data|
    if app_data['last_updated']
      date = Time.parse(app_data['last_updated']).strftime('%Y-%m-%d')
      puts "  #{date} - #{app_data['name']} (#{key})"
    else
      puts "  No date - #{app_data['name']} (#{key})"
    end
  end
end

def main
  puts "🚀 Fetching apps for developer ID: #{DEVELOPER_ID}"
  
  # Obtener apps del desarrollador
  apps = fetch_developer_apps(DEVELOPER_ID)
  
  if apps.empty?
    puts "❌ No apps found for developer ID: #{DEVELOPER_ID}"
    return
  end
  
  puts "📱 Found #{apps.length} apps:"
  apps.each { |app| puts "  - #{app['trackName']} (ID: #{app['trackId']})" }
  
  puts "\n🔄 Updating configuration and downloading icons..."
  update_config_with_apps(apps)
  
  puts "\n🎉 Update complete!"
  puts "📝 Review #{CONFIG_FILE} and adjust any mappings if needed"
end

if __FILE__ == $0
  main
end 