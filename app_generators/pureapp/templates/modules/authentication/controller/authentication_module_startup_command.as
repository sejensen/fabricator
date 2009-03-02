package <%= base_package%>.modules.authentication.controller {
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.command.SimpleFabricationCommand;
	
	import <%= base_package%>.common.<%= name%>Constants;
	import <%= base_package%>.modules.authentication.model.AuthenticationProxy;
	
	import AuthenticationModule;
	import <%= base_package%>.modules.authentication.view.AuthenticationModuleMediator;		

	public class AuthenticationModuleStartupCommand extends SimpleFabricationCommand {
		
		override public function execute(note:INotification):void {
			trace("starting authentication module")
			registerProxy(new AuthenticationProxy());
			/*registerCommand(FabricationRoutingDemoConstants.RECEIVE_MESSAGE, UpdateMessageCountsCommand);
			*/
			registerMediator(new AuthenticationModuleMediator(note.getBody() as AuthenticationModule));
		}
		
	}
}
