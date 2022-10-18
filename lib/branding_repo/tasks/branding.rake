BRANDING_TEMPLATE=<<TEMPLATE
files:
  - app/views/layouts/application.html.erb
TEMPLATE

CURRENT_BRAND_FILE_NAME=".current_brand"

namespace :branding do
  desc 'create'
  task create: :environment do
    create_config_unless_exist!

    brand_name = brand_name!(task: :create)

    config = read_config

    if File.exists?(Rails.root.join("config","brands", brand_name))
      puts "Brand #{brand_name} already exists, please use rails branding:push #{brand_name}"
      exit(1)
    end

    Dir.mkdir(Rails.root.join("config","brands", brand_name))

    exit
  end

  desc 'push: update an existing brand with the current status of the brand files in the working directory'
  task push: :environment do
    config = read_config

    brand_name = brand_name!(task: :push)

    config["files"].each do |file|
      if File.exist?(Rails.root.join(file))
        mkdir_with_parents(File.dirname( Rails.root.join("config","brands", brand_name, file)))
        ::FileUtils.cp(Rails.root.join(file), File.dirname(Rails.root.join("config","brands", brand_name, file)))
      else
        puts "Skipping #{file} ... (does not exist in current environment)"
      end
    end

    exit
  end

  desc 'pull: update current working directory with an brand files from an existing brand'
  task pull: :environment do
    config = read_config

    brand_name = brand_name!(task: :pull)

    config["files"].each do |file|
      if File.exist?(Rails.root.join("config","brands", brand_name, file))
        ::FileUtils.cp(Rails.root.join("config","brands", brand_name, file), File.dirname(Rails.root.join(file)))
      else
        puts "Skipping #{file} ... (does not exist in brand)"
      end
    end

    exit
  end
end

def brand_name!(task: :taskname)
  brand_name = ARGV[0]
  brand_name ||= File.read(Rails.root.join(CURRENT_BRAND_FILE_NAME)).strip
  unless brand_name
    puts "A brand name is required: rails branding:#{task} brand_name"
    exit(1)
  end
  File.write(Rails.root.join(CURRENT_BRAND_FILE_NAME), ARGV[0].strip) if ARGV[0]
  brand_name
end

def create_config_unless_exist!
  unless File.exist?(Rails.root.join("config","branding.yml"))
    puts "Creating config/branding.yml as it did not exist..."
    File.write(Rails.root.join("config","branding.yml"), BRANDING_TEMPLATE)
  end
  unless File.exist?(Rails.root.join("config","brands"))
    puts "Creating config/brands as it did not exist..."

    Dir.mkdir(Rails.root.join("config","brands"))
    File.write(Rails.root.join("config","brands",".keep"),"")
  end
end

def read_config
  config = YAML.load(File.read(Rails.root.join("config","branding.yml")))
  if config["files"]
    return config
  else
    puts "Invalid config/branding.yml, make sure a files section exists"
    exit(1)
  end
end

def mkdir_with_parents(path)
  dirname = File.dirname(path)
  if Dir.exist?(dirname) and !Dir.exist?(path)
    Dir.mkdir(path)
  elsif !Dir.exist?(dirname)
    mkdir_with_parents(dirname)
    mkdir_with_parents(path)
  end
end