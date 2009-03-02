package <%= base_package%>.shell.controller {
 	import <%= base_package%>.shell.view.<%= name%>ShellMediator;	
		
	import org.puremvc.as3.multicore.interfaces.INotification;	
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.command.SimpleFabricationCommand;	
	import <%= base_package%>.shell.model.ListProxy;
	import <%= base_package%>.shell.model.ModuleDescriptor;
	import <%= base_package%>.shell.<%= name%>ShellConstants;	

	public class <%= startup_command_name %> extends SimpleFabricationCommand {
		
		override public function execute(note:INotification):void {
			trace("starting up");
			registerProxy(new ListProxy());
			
			registerCommand(<%= name%>ShellConstants.ADD_MODULE, AddModuleCommand);
			registerCommand(<%= name%>ShellConstants.REMOVE_MODULE, RemoveModuleCommand);
			registerCommand(<%= name%>ShellConstants.SELECT_MODULE, ChangeSelectedModuleCommand);
			
			registerCommand(<%= name%>ShellConstants.LOAD_DASHBOARD_MODULE, LoadDashboardModuleCommand);
			
			
			registerMediator(new <%= name%>ShellMediator(note.getBody() as <%= name%>Shell));
			
			//FIXME test add of authentication module
			var moduleDescriptor:ModuleDescriptor = new ModuleDescriptor("AuthenticationModule.swf");
			sendNotification(<%= name%>ShellConstants.ADD_MODULE, moduleDescriptor);
		}
	}
}