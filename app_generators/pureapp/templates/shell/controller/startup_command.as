package <%= base_package%>.shell.controller {
 	import <%= base_package%>.shell.view.<%= name%>ShellMediator;	
	import <%= base_package%>.shell.model.ListProxy;
	import <%= base_package%>.shell.model.LoadModulesProxy;
	import <%= base_package%>.shell.model.SelectionProxy;
	import <%= base_package%>.shell.model.ModuleDescriptor;
	import <%= base_package%>.shell.<%= name%>ShellConstants;	

	import org.puremvc.as3.multicore.interfaces.INotification;	
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.command.SimpleFabricationCommand;	
	import org.puremvc.as3.multicore.utilities.startupmanager.controller.StartupResourceLoadedCommand;
 	import org.puremvc.as3.multicore.utilities.startupmanager.interfaces.IStartupProxy;
 	import org.puremvc.as3.multicore.utilities.startupmanager.model.StartupMonitorProxy;
 	import org.puremvc.as3.multicore.utilities.startupmanager.model.StartupResourceProxy;

	public class <%= startup_command_name %> extends SimpleFabricationCommand {
		private var _monitor:StartupMonitorProxy;
		private var loadModulesProxy:IStartupProxy;
		
		override public function execute(note:INotification):void {
			trace("starting up");
			registerProxy( new ListProxy() );
			registerProxy( new StartupMonitorProxy() );
			registerProxy( new LoadModulesProxy() );
			registerProxy( new SelectionProxy() );
			
			registerCommand(<%= name%>ShellConstants.ADD_MODULE, AddModuleCommand);
			registerCommand(<%= name%>ShellConstants.REMOVE_MODULE, RemoveModuleCommand);
			registerCommand(<%= name%>ShellConstants.SELECT_MODULE, ChangeSelectedModuleCommand);
			
			registerCommand(<%= name%>ShellConstants.LOAD_DASHBOARD_MODULE, LoadDashboardModuleCommand);
			registerCommand(<%= name%>ShellConstants.SHELL_LOAD_ALL_MODULES, LoadAllModulesCommand);
			registerCommand(<%= name%>ShellConstants.MODULE_LOADED, ModuleLoadedCommand);
			registerCommand(<%= name%>ShellConstants.MODULES_LOADED, StartupResourceLoadedCommand);
			
			
			registerMediator(new <%= name%>ShellMediator(note.getBody() as <%= name%>Shell));
			
			_monitor = retrieveProxy( StartupMonitorProxy.NAME ) as StartupMonitorProxy;
			loadModulesProxy = retrieveProxy( LoadModulesProxy.NAME ) as LoadModulesProxy;
			var rLoadModulesProxy:StartupResourceProxy = makeAndRegisterStartupResource( LoadModulesProxy.SRNAME, loadModulesProxy );
			
			//FIXME test add of authentication module
			var moduleDescriptor:ModuleDescriptor = new ModuleDescriptor("AuthenticationModule.swf");
			sendNotification(<%= name%>ShellConstants.ADD_MODULE, moduleDescriptor);
		}
		
		private function makeAndRegisterStartupResource( proxyName:String, appResourceProxy:IStartupProxy ):StartupResourceProxy {
			var r:StartupResourceProxy = new StartupResourceProxy( proxyName, appResourceProxy );
		    registerProxy( r );
		    _monitor.addResource( r );
		    return r;
		}
		
	}
}