package <%= base_package%>.modules.dashboard.view
{
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;
	import <%= base_package%>.modules.dashboard.view.components.TodoList;
	
	public class TodoListMediator extends FlexMediator	{
		
		public static const NAME:String = "TodoListMediator";
		
		public function TodoListMediator( viewComponent:TodoList )
		{
			super( NAME, viewComponent );
		}
	
		/**
		 * The viewComponent cast to type TodoList.
		 */
		private function get todoList():TodoList
		{
			return viewComponent as TodoList;
		}
	}
}