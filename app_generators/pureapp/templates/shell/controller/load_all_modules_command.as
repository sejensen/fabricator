package <%= base_package%>.shell.controller {
	import <%= base_package%>.shell.<%= name%>ShellConstants;
	import <%= base_package%>.shell.model.LoadModulesProxy;	
	import <%= base_package%>.shell.model.ModuleDescriptor;
	
	import org.puremvc.as3.multicore.interfaces.INotification;	
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.command.SimpleFabricationCommand;
	import org.puremvc.as3.multicore.utilities.startupmanager.interfaces.IStartupProxy;
	import org.puremvc.as3.multicore.utilities.startupmanager.model.StartupMonitorProxy;
	import org.puremvc.as3.multicore.utilities.startupmanager.model.StartupResourceProxy;
	
	public class LoadAllModulesCommand extends SimpleFabricationCommand {
		private var _monitor:StartupMonitorProxy;
		
		override public function execute(note:INotification):void {
			_monitor = retrieveProxy( StartupMonitorProxy.NAME ) as StartupMonitorProxy;
			_monitor.loadResources();
		}
	}
}