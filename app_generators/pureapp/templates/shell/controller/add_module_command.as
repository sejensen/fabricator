package <%= base_package%>.shell.controller {
	import <%= base_package%>.shell.model.ListProxy;	
	import <%= base_package%>.shell.<%= name%>ShellConstants;	
	import <%= base_package%>.shell.model.ModuleDescriptor;	
	
	import org.puremvc.as3.multicore.interfaces.INotification;	
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.command.SimpleFabricationCommand;	
	
	public class AddModuleCommand extends SimpleFabricationCommand {
		
		override public function execute(note:INotification):void {
			var moduleDescriptor:ModuleDescriptor = note.getBody() as ModuleDescriptor;
			var moduleListProxy:ListProxy = retrieveProxy(ListProxy.NAME) as ListProxy;
			
			moduleListProxy.add(moduleDescriptor);
		}
	}
}
