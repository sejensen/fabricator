package <%= base_package%>.modules.<%= module_folder%>.view {
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;
	
	import <%= base_package%>.modules.<%= module_folder%>.view.components.<%= module_name%>View;

	public class <%= module_name%>MonameduleMediator extends FlexMediator {
		
		static public const NAME:String = "<%= module_name%>ModuleMediator";
		
		static public function getDefinitionByName(path:String):Object {
			return getDefinitionByName(path);
		}
		
		public function <%= module_name%>ModuleMediator(viewComponent:<%= module_name%>Module) {
			super(NAME, viewComponent);
		}
		
		public function get application():<%= module_name%>Module {
			return viewComponent as <%= module_name%>Module;
		}
		
		public function get <%= module_folder%>View():<%= module_name%>View {
			return application.<%= module_folder%>View as <%= module_name%>View;
		}
		
		override public function onRegister():void {
			registerMediator(new <%= module_name%>ViewMediator(<%= module_name%>View));
		} 
		
	}
}
