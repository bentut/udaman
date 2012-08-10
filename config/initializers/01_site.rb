SITE = HashWithIndifferentAccess.new(YAML.load(File.open(File.join(Rails.root, 'config', 'site.yml'))))
