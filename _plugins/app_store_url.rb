module Jekyll
  module AppStoreUrlFilter
    def app_store_url(app_id)
      "https://apps.apple.com/us/app/id#{app_id}?uo=4"
    end
  end
end

Liquid::Template.register_filter(Jekyll::AppStoreUrlFilter) 