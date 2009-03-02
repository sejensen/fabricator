package <%= base_package%>.shell.model {
	import mx.collections.ArrayCollection;
	
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.proxy.FabricationProxy;		

	public class ListProxy extends FabricationProxy {
		
		static public const NAME:String = "ListProxy";
		static public const ADDED_TO_LIST:String = "addedToList";
		static public const REMOVED_FROM_LIST:String = "removedFromList";
		
		public function ListProxy(name:String = NAME, _list:ArrayCollection = null) {
			super(name, _list != null ? _list : new ArrayCollection());
		}
		
		public function get list():ArrayCollection {
			return data as ArrayCollection;
		}
		
		public function add(element:IListElement):void {
			if (!exists(element)) {
				list.addItem(element);
				sendNotification(ADDED_TO_LIST, element);
			}
		}
		
		public function remove(element:IListElement):void {
			if (exists(element)) {
				var index:int = list.getItemIndex(element);
				list.removeItemAt(index);
				sendNotification(REMOVED_FROM_LIST, element);
			}
		}
		
		public function exists(element:IListElement):Boolean {
			return list.contains(element);
		}
		
		public function find(elementID:String):IListElement {
			var n:int = list.length;
			var element:IListElement;
			for (var i:int = 0; i < n; i++) {
				element = list.getItemAt(i) as IListElement;
				if (element.getElementID() == elementID) {
					return element;
				}
			}
			
			return null;
		}		
		
	}
}
