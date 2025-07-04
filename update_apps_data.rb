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

def extract_app_key_from_url(url)
  # Extraer el ID de la app de la URL
  match = url.match(/id(\d+)/)
  return match[1] if match
  
  # Si no hay ID, usar el nombre de la app como fallback
  match = url.match(/\/([^\/]+)\/?$/)
  return match[1] if match
  
  nil
end

def map_app_to_config_key(app)
  # Mapear nombres de apps a las claves de configuración
  app_name = app['trackName'].downcase
  
  case app_name
  when /qr.*code.*reader/i
    'qr_code_reader'
  when /qr.*scanner/i
    'qr'
  when /app.*lock/i
    'app_lock'
  when /storage.*cleaner/i
    'storage_cleaner'
  when /clean.*up.*iphone/i
    'clean_up_iphone'
  when /photo.*vault/i
    'photo_vault_x'
  when /focus.*app/i
    'focus_app'
  when /screenfree/i
    'screenfree'
  else
    # Crear clave basada en el nombre
    app_name.gsub(/[^a-z0-9]/, '_')
  end
end

def update_config_with_apps(apps)
  # Leer configuración actual
  config = YAML.load_file(CONFIG_FILE)
  ios_apps = config['ios_apps'] || {}
  
  apps.each do |app|
    app_id = app['trackId']
    app_name = app['trackName']
    app_url = app['trackViewUrl']
    
    # Determinar clave de configuración
    config_key = map_app_to_config_key(app)
    
    puts "📱 Processing: #{app_name} (#{config_key})"
    
    # Preparar datos de la app
    app_data = {
      'url' => app_url,
      'name' => app_name,
      'description' => app['description'] || ios_apps.dig(config_key, 'description') || '',
      'subtitle' => app['subtitle'] || ios_apps.dig(config_key, 'subtitle') || '',
      'rating' => app['averageUserRating'] || 0.0,
      'ratings_count' => app['userRatingCount'] || 0,
      'icon' => "/#{ASSETS_DIR}/#{config_key}/app-icon.webp",
      'included_in_pro' => ios_apps.dig(config_key, 'included_in_pro') || false,
      'page' => ios_apps.dig(config_key, 'page'),
      'published' => ios_apps.dig(config_key, 'published') != false
    }
    
    # Descargar ícono
    if app['artworkUrl512']
      icon_path = "#{ASSETS_DIR}/#{config_key}/app-icon.webp"
      download_image(app['artworkUrl512'], icon_path)
    end
    
    # Actualizar configuración
    ios_apps[config_key] = app_data
  end
  
  # Escribir configuración actualizada
  config['ios_apps'] = ios_apps
  File.write(CONFIG_FILE, config.to_yaml)
  
  puts "\n✅ Configuration updated: #{CONFIG_FILE}"
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
  apps.each { |app| puts "  - #{app['trackName']}" }
  
  puts "\n🔄 Updating configuration and downloading icons..."
  update_config_with_apps(apps)
  
  puts "\n🎉 Update complete!"
  puts "📝 Review #{CONFIG_FILE} and adjust any mappings if needed"
end

if __FILE__ == $0
  main
end 