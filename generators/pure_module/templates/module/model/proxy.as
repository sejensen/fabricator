package <%= base_package%>.modules.<%= module_folder%>.model {
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.proxy.FabricationProxy;	
	import <%= base_package%>.common.<%= name%>Constants;
	
	public class <%= module_name%>Proxy extends FabricationProxy {

		static public const NAME:String = "<%= module_name%>Proxy";
	
		
		public function <%= module_name%>Proxy(name:String = NAME) {
			super(name);
		}
		
		
		public function calcData(input:String):void {

		}
	}
}
