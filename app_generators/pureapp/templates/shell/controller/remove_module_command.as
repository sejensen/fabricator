package <%= base_package%>.shell.controller {
	import org.puremvc.as3.multicore.patterns.observer.Notification;	
	
	import <%= base_package%>.shell.<%= name%>ShellConstants;	
	import <%= base_package%>.shell.model.ModuleDescriptor;	
	import <%= base_package%>.shell.model.ListProxy;	
	
	import org.puremvc.as3.multicore.interfaces.INotification;	
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.command.SimpleFabricationCommand;	
	
	public class RemoveModuleCommand extends SimpleFabricationCommand {
		
		override public function execute(note:INotification):void {
			var moduleDescriptor:ModuleDescriptor = note.getBody() as ModuleDescriptor;
			var moduleListProxy:ListProxy = retrieveProxy(ListProxy.NAME) as ListProxy;
			
			moduleListProxy.remove(moduleDescriptor);
			executeCommand(ChangeSelectedModuleCommand, null);
		}
	}
}
