package <%= base_package%>.modules.<%= module_folder%>.view
{
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;
	import <%= base_package%>.modules.<%= module_folder%>.view.components.<%= module_name%>View;
	import <%= base_package%>.modules.<%= module_folder%>.model.<%= module_name%>Proxy;
	
	import mx.controls.Button;
	import flash.events.MouseEvent;

	import flash.events.Event;
	
	public class <%= module_name%>ViewMediator extends FlexMediator	{
		
		public static const NAME:String = "<%= module_name%>ViewMediator";
		
		public function <%= module_name%>ViewMediator( viewComponent:<%= module_name%>View )
		{
			super( NAME, viewComponent );
		}
	
		/**
		 * The viewComponent cast to type SignInView.
		 */
		private function get <%= module_folder%>View():<%= module_name%>View
		{
			return viewComponent as <%= module_name%>View;
		}
		
		public function get moduleButton():Button {
		   return <%= module_folder%>View.moduleButton as Button;
		}

		public function reactToModuleButtonClick(e:MouseEvent):void {
			
		}
		
	}
}