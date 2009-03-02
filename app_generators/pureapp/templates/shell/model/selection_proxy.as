package <%= base_package%>.shell.model {
	import mx.collections.ArrayCollection;
	
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.proxy.FabricationProxy;		

	public class SelectionProxy extends FabricationProxy {
		
		static public const NAME:String = "SelectionProxy";
		static public const SELECTION_CHANGED:String = "selectionChanged";
		
		public function SelectionProxy(name:String = NAME, _selection:ArrayCollection = null) {
			super(name, _selection != null ? _selection : new ArrayCollection());
		}
		
		public function changeSelection(newSelection:Object):Boolean {
			if (selection != newSelection) {
				setData(newSelection);
				sendNotification(SELECTION_CHANGED, newSelection);
				return true;
			} else {
				return false;
			}
		}
		
		public function get selection():Object {
			return data;
		}
		
	}
}
