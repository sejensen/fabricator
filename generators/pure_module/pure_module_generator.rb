require File.join(File.dirname(__FILE__), '..', '..', 'lib', 'fabricator') if !defined?(Fabricator)

class PureModuleGenerator < RubiGen::Base
  include Fabricator::Configuration

  default_options :author => nil

  attr_reader :name,
              :module_name,
              :module_folder,
              :app_name,
              :base_src_folder,
              :base_package_folder,
              :base_package,
              :modules

  def initialize(runtime_args, runtime_options = {})
    super
    usage if args.empty?
    @module_name = args.shift.capitalize
    @module_folder = @module_name.downcase
    
    @name, @base_src_folder, @base_package_folder, @base_package, @modules = extract_config
    @base_folder = @base_src_folder + @base_package_folder
    modules << @module_name
    extract_options
  end

  def manifest
    record do |m|
      # Ensure appropriate folder(s) exists
      m.directory @base_folder +"/modules/#{@module_folder}/model"
      m.directory @base_folder +"/modules/#{@module_folder}/view/components"
      m.directory @base_folder +"/modules/#{@module_folder}/controller"

      # Create module
      m.template "module.mxml", "#{@base_src_folder}/#{module_name}Module.mxml"
      m.template "module/controller/module_startup_command.as","#{@base_folder}/modules/#{@module_folder}/controller/#{module_name}ModuleStartupCommand.as"  
      m.template "module/view/module_mediator.as", "#{@base_folder}/modules/#{@module_folder}/view/#{module_name}ModuleMediator.as" 
      m.template "module/view/components/view.mxml", "#{@base_folder}/modules/#{@module_folder}/view/components/#{module_name}View.mxml" #fixme
      m.template "module/view/view_mediator.as", "#{@base_folder}/modules/#{@module_folder}/view/#{module_name}ViewMediator.as" #fixme
      m.template "module/model/proxy.as", "#{@base_folder}/modules/#{@module_folder}/model/#{module_name}Proxy.as"

      # Recreate .actionscriptproperty file with all modules
      m.template 'actionscript.properties', '.actionScriptProperties' #TODO remove common template files to common dir
      # Resave generator properties for component generators.
      m.template "fabricator.yml", "/script/fabricator.yml" #TODO remove common template files to common dir
      # Rebuild load_all_modules_command
       m.template "shell/controller/load_all_modules_command.as", "#{@base_folder}/shell/controller/LoadAllModulesCommand.as" #TODO remove common template files to common dir
      
      # Create stubs
      # m.template           "template.rb.erb", "some_file_after_erb.rb"
      # m.template_copy_each ["template.rb", "template2.rb"]
      # m.template_copy_each ["template.rb", "template2.rb"], "some/path"
      # m.file           "file", "some_file_copied"
      # m.file_copy_each ["path/to/file", "path/to/file2"]
      # m.file_copy_each ["path/to/file", "path/to/file2"], "some/path"
    end
  end

  protected
    def banner
      <<-EOS
Creates a ...

USAGE: #{$0} #{spec.name} name
EOS
    end

    def add_options!(opts)
      # opts.separator ''
      # opts.separator 'Options:'
      # For each option below, place the default
      # at the top of the file next to "default_options"
      # opts.on("-a", "--author=\"Your Name\"", String,
      #         "Some comment about this option",
      #         "Default: none") { |o| options[:author] = o }
      # opts.on("-v", "--version", "Show the #{File.basename($0)} version number and quit.")
    end

    def extract_options
      # for each option, extract it into a local variable (and create an "attr_reader :author" at the top)
      # Templates can access these value via the attr_reader-generated methods, but not the
      # raw instance variable value.
      # @author = options[:author]
    end
end