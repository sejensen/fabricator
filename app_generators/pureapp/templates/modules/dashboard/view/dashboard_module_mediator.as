package <%= base_package%>.modules.dashboard.view {
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;
	
	import <%= base_package%>.modules.dashboard.view.components.NavBar;
	import <%= base_package%>.modules.dashboard.view.components.TodoList;

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
		
	}
}
