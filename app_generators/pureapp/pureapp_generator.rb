class PureappGenerator < RubiGen::Base

  DEFAULT_SHEBANG = File.join(Config::CONFIG['bindir'],
                              Config::CONFIG['ruby_install_name'])

  default_options :author => nil

  attr_reader :name,
              :title,
              :base_package,
              :base_folder,
              :base_src_folder,
              :base_package_folder,
              :startup_command_name,
              :modules
              

  def initialize(runtime_args, runtime_options = {})
    super
    usage if args.empty?
    @name = args.shift
    @destination_root = File.expand_path(@name)
    @base_package = args.shift || "org.puremvc.multicore.fabrication.app"
    @title = args.shift || @name
    @base_src_folder = "src/main/flex/"
    @base_package_folder = @base_package.gsub('.', '/').gsub(/\s/, '')
    @base_folder = @base_src_folder + @base_package_folder
    @startup_command_name = "#{@name}ShellStartupCommand"
    @modules = ["Authentication","Dashboard"]
    extract_options
  end

  def manifest
    record do |m|
      # Ensure appropriate folder(s) exists
      #m.directory "#{@name}"
      m.directory @base_folder
      m.directory @base_folder +"/shell/controller"
      m.directory @base_folder +"/shell/model"
      m.directory @base_folder +"/shell/view/components"
      m.directory @base_folder +"/common"
      m.directory @base_folder +"/modules/authentication/model"
      m.directory @base_folder +"/modules/authentication/view/components"
      m.directory @base_folder +"/modules/authentication/controller"
      m.directory @base_folder +"/modules/dashboard/model"
      m.directory @base_folder +"/modules/dashboard/view/components"
      m.directory @base_folder +"/modules/dashboard/controller"
      BASEDIRS.each { |path| m.directory path }
      
      # Setup Flex project
      m.file 'flex.properties', '.flexProperties'
      m.template 'actionscript.properties', '.actionScriptProperties'
      m.template 'project.properties', '.project'
      m.directory 'html-template/history'      
      %w(index.template.html AC_OETags.js playerProductInstall.swf).each do |file|
        m.file "html-template/#{file}", "html-template/#{file}"
      end
      
      # Save generator properties for component generators.
      m.template "fabricator.yml", "/script/fabricator.yml" 
      
      # Create template files
      %w(history.css history.js historyFrame.html).each do |file|
        m.file "html-template/history/#{file}", "html-template/history/#{file}"
      end
     
      # Copy needed swc's and their licenses
      %w(puremvc_multicore_license.txt puremvc_pipes_license.txt PureMVC_AS3_MultiCore_1_0_5.swc Utility_AS3_MultiCore_Pipes_1_1.swc fabrication-0.6-flex.swc fabrication_license.txt).each do |file|
        m.file "libs/#{file}", "libs/#{file}"
      end
     
      # Create stubs
      m.template "mainapp.mxml", "#{@base_src_folder + @name}Shell.mxml"
      m.template "common/constants.as", "#{@base_folder}/common/#{@name}Constants.as"
      
      # Create shell stubs
      m.template "shell/shell_constants.as", "#{@base_folder}/shell/#{@name}ShellConstants.as"
      m.template "shell/controller/startup_command.as", "#{@base_folder}/shell/controller/#{@startup_command_name}.as"
      m.template "shell/controller/add_module_command.as", "#{@base_folder}/shell/controller/AddModuleCommand.as"
      m.template "shell/controller/remove_module_command.as", "#{@base_folder}/shell/controller/RemoveModuleCommand.as"
      m.template "shell/controller/change_selected_module_command.as", "#{@base_folder}/shell/controller/ChangeSelectedModuleCommand.as" 
      m.template "shell/view/mediator.as", "#{@base_folder}/shell/view/#{@name}ShellMediator.as"
      m.file "shell/view/components/modules_container.mxml", "#{@base_folder}/shell/view/components/ModulesContainer.mxml"
      m.template "shell/view/modules_container_mediator.as", "#{@base_folder}/shell/view/ModulesContainerMediator.as"
      m.template "shell/model/list_proxy.as", "#{@base_folder}/shell/model/ListProxy.as"
      m.template "shell/model/selection_proxy.as", "#{@base_folder}/shell/model/SelectionProxy.as"
      m.template "shell/model/i_list_element.as", "#{@base_folder}/shell/model/IListElement.as"
      m.template "shell/model/module_descriptor.as", "#{@base_folder}/shell/model/ModuleDescriptor.as"
      
      #Create authentication module
      m.template "authentication_module.mxml", "#{@base_src_folder}/AuthenticationModule.mxml"
      m.template "modules/authentication/controller/authentication_module_startup_command.as","#{@base_folder}/modules/authentication/controller/AuthenticationModuleStartupCommand.as"  
      m.template "modules/authentication/view/authentication_module_mediator.as", "#{@base_folder}/modules/authentication/view/AuthenticationModuleMediator.as" 
      m.template "modules/authentication/view/components/sign_in_view.mxml", "#{@base_folder}/modules/authentication/view/components/SignInView.mxml"
      m.template "modules/authentication/view/sign_in_view_mediator.as", "#{@base_folder}/modules/authentication/view/SignInViewMediator.as"
      m.template "modules/authentication/model/authentication_proxy.as", "#{@base_folder}/modules/authentication/model/AuthenticationProxy.as" 
      
      #Create dashboard module
      m.template "dashboard_module.mxml", "#{@base_src_folder}/DashboardModule.mxml"
      m.template "modules/dashboard/controller/dashboard_module_startup_command.as","#{@base_folder}/modules/dashboard/controller/DashboardModuleStartupCommand.as"  
      m.template "modules/dashboard/view/dashboard_module_mediator.as", "#{@base_folder}/modules/dashboard/view/DashboardModuleMediator.as" 
      m.template "shell/controller/load_dashboard_module_command.as", "#{@base_folder}/shell/controller/LoadDashboardModuleCommand.as"
      m.template "modules/dashboard/view/components/nav_bar.mxml", "#{@base_folder}/modules/dashboard/view/components/NavBar.mxml"
      m.template "modules/dashboard/view/nav_bar_mediator.as", "#{@base_folder}/modules/dashboard/view/NavBarMediator.as"
      m.template "modules/dashboard/view/components/todo_list.mxml", "#{@base_folder}/modules/dashboard/view/components/TodoList.mxml"
      m.template "modules/dashboard/view/todo_list_mediator.as", "#{@base_folder}/modules/dashboard/view/TodoListMediator.as"
      
      # Create stubs
      # m.template "template.rb",  "some_file_after_erb.rb"
      # m.template_copy_each ["template.rb", "template2.rb"]
      # m.file     "file",         "some_file_copied"
      # m.file_copy_each ["path/to/file", "path/to/file2"]

      m.dependency "install_rubigen_scripts", [destination_root, 'pureapp'],
        :shebang => options[:shebang], :collision => :force
    end
  end

  protected
    def banner
      <<-EOS
Creates a ...

USAGE: #{spec.name} name
EOS
    end

    def add_options!(opts)
      opts.separator ''
      opts.separator 'Options:'
      # For each option below, place the default
      # at the top of the file next to "default_options"
      # opts.on("-a", "--author=\"Your Name\"", String,
      #         "Some comment about this option",
      #         "Default: none") { |o| options[:author] = o }
      opts.on("-v", "--version", "Show the #{File.basename($0)} version number and quit.")
    end

    def extract_options
      # for each option, extract it into a local variable (and create an "attr_reader :author" at the top)
      # Templates can access these value via the attr_reader-generated methods, but not the
      # raw instance variable value.
      # @author = options[:author]
    end

    # Installation skeleton.  Intermediate directories are automatically
    # created so don't sweat their absence here.
    BASEDIRS = %w(
      bin
      libs
      script
      src/main/flex
    )
end