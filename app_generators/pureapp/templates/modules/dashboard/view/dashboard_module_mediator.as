package <%= base_package%>.modules.dashboard.view {
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;
	
	import <%= base_package%>.modules.dashboard.view.components.NavBar;
	import <%= base_package%>.modules.dashboard.view.components.TodoList;
	import <%= base_package%>.modules.dashboard.DashboardModuleConstants;
	
	import org.puremvc.as3.multicore.interfaces.INotification;

	public class DashboardModuleMediator extends FlexMediator {
		
		static public const NAME:String = "DashboardModuleMediator";
		
		static public function getDefinitionByName(path:String):Object {
			return getDefinitionByName(path);
		}
		
		public function DashboardModuleMediator(viewComponent:DashboardModule) {
			super(NAME, viewComponent);
		}
		
		public function get application():DashboardModule {
			return viewComponent as DashboardModule;
		}
		
		public function get navBar():NavBar {
			return application.navBar as NavBar;
		}
		
		public function get todoList():TodoList {
			return application.todoList as TodoList;
		}
		
		override public function onRegister():void {
			registerMediator(new NavBarMediator(navBar));
			registerMediator(new TodoListMediator(todoList));
		} 
		
		public function respondToModulesLoadedSuccessfully(note:INotification):void {
			trace('received routed notification: modulesLoadedSuccessfully');
			sendNotification(DashboardModuleConstants.REQUEST_DASHBOARD_VIEW_FROM_LOADED_MODULES);
			//FIXME nothing happens yet
		}
		
	}
}
