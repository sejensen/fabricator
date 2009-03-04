package <%= base_package%>.shell.controller {
	import <%= base_package%>.shell.<%= name%>ShellConstants;	
	import <%= base_package%>.shell.model.ModuleDescriptor;
	
	import org.puremvc.as3.multicore.interfaces.INotification;	
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.command.SimpleFabricationCommand;	
	
	public class LoadAllModulesCommand extends SimpleFabricationCommand {
		
		override public function execute(note:INotification):void {
			var moduleDescriptor:ModuleDescriptor = null;
		<%grid_modules = modules - ["Dashboard", "Authentication"] %>
		<%if grid_modules.empty?%>
			trace("no modules but Dashboard, and Authentication created yet. run ruby script/generate pure_module MyNewModule in the root of the project")
		<%end%>
		<%for modul in grid_modules%>
			trace("loading <%=modul.downcase%> module")
			moduleDescriptor = new ModuleDescriptor("<%=modul%>Module.swf");
			sendNotification(<%= name%>ShellConstants.ADD_MODULE, moduleDescriptor);
		<%end%>
		}
	}
}