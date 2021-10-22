require 'branding_repo'
require 'rails'

module BrandingRepo
  class Railtie < Rails::Railtie
    railtie_name :branding_repo

    rake_tasks do
      path = File.expand_path(__dir__)
      Dir.glob("#{path}/tasks/**/*.rake").each { |f| load f }
    end
  end
end