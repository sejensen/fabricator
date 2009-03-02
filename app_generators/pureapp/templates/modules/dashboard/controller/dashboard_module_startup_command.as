package <%= base_package%>.modules.dashboard.controller {
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.command.SimpleFabricationCommand;
	
	import <%= base_package%>.common.<%= name%>Constants;
	//import <%= base_package%>.modules.dashboard.model.DashboardProxy;
	
	import DashboardModule;
	import <%= base_package%>.modules.dashboard.view.DashboardModuleMediator;		

	public class DashboardModuleStartupCommand extends SimpleFabricationCommand {
		
		override public function execute(note:INotification):void {
			trace("starting dashboard module")
			//registerProxy(new DashboardProxy());
			/*registerCommand(FabricationRoutingDemoConstants.RECEIVE_MESSAGE, UpdateMessageCountsCommand);
			*/
			registerMediator(new DashboardModuleMediator(note.getBody() as DashboardModule));
		}
		
	}
}
