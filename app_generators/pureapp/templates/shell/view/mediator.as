package <%= base_package%>.shell.view {
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;
	
	import <%= base_package%>.shell.view.components.ModulesContainer;
	import <%= base_package%>.shell.<%= name%>ShellConstants;
	import <%= base_package%>.common.<%= name%>Constants;
	
	import org.puremvc.as3.multicore.interfaces.INotification;		

	public class <%= name%>ShellMediator extends FlexMediator {

		static public const NAME:String = "<%= name%>ShellMediator";
		
		public function <%= name%>ShellMediator(viewComponent:<%= name%>Shell) {
			super(NAME, viewComponent);
		}
		
		public function get application():<%= name%>Shell {
			return viewComponent as <%= name%>Shell;
		}
		
		public function get modulesContainer():ModulesContainer {
			return application.modulesContainer as ModulesContainer;
		}
		
		override public function onRegister():void {
			registerMediator(new ModulesContainerMediator(modulesContainer));
		}
		
		public function respondToValidLogin(note:INotification):void {
			trace("shell received valid_login routed message");
			sendNotification(<%= name%>ShellConstants.LOAD_DASHBOARD_MODULE);
		}
		
		public function respondToLoadAllModules(note:INotification):void {
			trace('Received routed notification: loadAllModules');
			sendNotification(<%= name%>ShellConstants.SHELL_LOAD_ALL_MODULES);
		}

		public function respondToSmLoadingComplete(note:INotification):void {
			trace('respondToLoadingComplete');
			routeNotification(<%= name%>Constants.MODULES_LOADED_SUCCESSFULLY, null, null, "*");
		}
		
	}
}