module Fabricator
  module Configuration
     APP_ROOT = File.expand_path(".")
     
     def extract_config()
       begin      
           config = YAML.load(File.open("#{APP_ROOT}/script/fabricator.yml"))
           app_name = config['app_name'] 
           base_package = config['base-package']
           base_folder = base_package.gsub('.', '/').gsub(/\s/, '')
           module_names = config['module-names']
         rescue
           #base_folder = base_package = project_name_downcase
           #controller_name = "ApplicationController"
         end
         [app_name, base_package, base_folder, module_names]
     end     
  end
end