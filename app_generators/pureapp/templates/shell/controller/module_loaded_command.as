package <%= base_package%>.shell.controller {
	import <%= base_package%>.shell.model.LoadModulesProxy;	
	import <%= base_package%>.shell.<%= name%>ShellConstants;	
	import <%= base_package%>.shell.model.ModuleDescriptor;	
	
	import org.puremvc.as3.multicore.interfaces.INotification;	
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.command.SimpleFabricationCommand;	
	
	public class ModuleLoadedCommand extends SimpleFabricationCommand {
		
		override public function execute(note:INotification):void {
			var moduleDescriptor:ModuleDescriptor = note.getBody() as ModuleDescriptor;
			var loadModulesProxy:LoadModulesProxy = retrieveProxy(LoadModulesProxy.NAME) as LoadModulesProxy;
			
			loadModulesProxy.moduleLoaded(moduleDescriptor);
		}
	}
}