package <%= base_package%>.modules.<%= module_folder%>.controller {
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.command.SimpleFabricationCommand;
	
	import <%= base_package%>.common.<%= name%>Constants;
	import <%= base_package%>.modules.<%= module_folder%>.model.<%= module_name%>Proxy;
	
	import <%= module_name%>Module;
	import <%= base_package%>.modules.<%= module_folder%>.view.<%= module_name%>ModuleMediator;		

	public class <%= module_name%>ModuleStartupCommand extends SimpleFabricationCommand {
		
		override public function execute(note:INotification):void {
			trace("starting <%= module_folder%> module")
			registerProxy(new <%= module_name%>Proxy());
			registerMediator(new <%= module_name%>ModuleMediator(note.getBody() as <%= module_name%>Module));
		}
		
	}
}
