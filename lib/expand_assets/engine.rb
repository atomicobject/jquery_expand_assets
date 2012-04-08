module ExpandAssets
  class Engine < ::Rails::Engine
    initializer "sprockets.jquery-expand", :after => "sprockets.environment", :group => :all do |app|
      next unless app.assets
      app.assets.register_engine('.expand', ExpandProcessor)
    end
  end
end
