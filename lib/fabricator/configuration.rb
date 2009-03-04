module Fabricator
  module Configuration
     APP_ROOT = File.expand_path(".")
     
     def extract_config()
       begin      
           puts "loading config file #{APP_ROOT}/script/fabricator.yml"
           config = YAML.load(File.open("#{APP_ROOT}/script/fabricator.yml"))
           puts config.inspect
           app_name = config['app_name'] 
           base_package_folder = config['base_package_folder']
           base_package = base_package_folder.gsub('.', '/').gsub(/\s/, '')
           module_names = config['module_names']
         rescue
           #base_folder = base_package = project_name_downcase
           #controller_name = "ApplicationController"
         end
         [app_name, base_package_folder, base_package, module_names]
     end     
  end
end