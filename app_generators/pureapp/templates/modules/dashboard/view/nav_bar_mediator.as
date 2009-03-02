package <%= base_package%>.modules.dashboard.view
{
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;
	
	import <%= base_package%>.common.<%= name%>Constants;
	import <%= base_package%>.modules.dashboard.view.components.NavBar;
	
	import mx.controls.Button;
	import flash.events.MouseEvent;

	import flash.events.Event;
	
	/*import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;*/
	
	public class NavBarMediator extends FlexMediator	{
		
		public static const NAME:String = "NavBarMediator";
		
		public function NavBarMediator( viewComponent:NavBar )
		{
			super( NAME, viewComponent );
		}
	
		/**
		 * The viewComponent cast to type ControlBar.
		 */
		private function get navBar():NavBar
		{
			return viewComponent as NavBar;
		}
		
		public function get signOutButton():Button {
		   return navBar.signOutButton as Button;
		}


		public function reactToSignOutButtonClick(e:MouseEvent):void {
			trace("sign out button clicked")
			routeNotification(<%= name%>Constants.SIGN_OUT, null, null,"*");
			
		}
		
	}
}