package <%= base_package%>.shell.controller {
	import <%= base_package%>.shell.<%= name%>ShellConstants;	
	import <%= base_package%>.shell.model.ModuleDescriptor;
	
	import org.puremvc.as3.multicore.interfaces.INotification;	
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.command.SimpleFabricationCommand;	
	
	public class LoadDashboardModuleCommand extends SimpleFabricationCommand {
		
		override public function execute(note:INotification):void {
			trace("Loading dashboard module")
			var moduleDescriptor:ModuleDescriptor = new ModuleDescriptor("DashboardModule.swf");
			sendNotification(<%= name%>ShellConstants.ADD_MODULE, moduleDescriptor);
		}
	}
}