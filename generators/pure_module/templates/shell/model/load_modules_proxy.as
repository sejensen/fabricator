<%'Generator note: This is a clone of the proxy from the pureapp application generator, please do not add changes here but in the original and then copy here.'%>
package <%= base_package%>.shell.model {
	import <%= base_package%>.shell.<%= name%>ShellConstants;
	
	import flash.events.Event;
	
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.proxy.FabricationProxy;
	import org.puremvc.as3.multicore.utilities.startupmanager.interfaces.IStartupProxy;
	import org.puremvc.as3.multicore.utilities.startupmanager.model.StartupResourceProxy;

	public class LoadModulesProxy extends FabricationProxy implements IStartupProxy
	{
		public static const NAME:String = "LoadModulesProxy";
		public static const SRNAME:String = "LoadModulesSRProxy";
	<%grid_modules = modules - ["Dashboard", "Authentication"] %>
	<%if grid_modules.empty?%>
		trace("no modules but Dashboard, and Authentication created yet. run ruby script/generate pure_module MyNewModule in the root of the project")
	<%end%>
		//one boolean for each module
	<%for modul in grid_modules%>
		private var <%=modul.downcase%>ModuleLoaded:Boolean = false;
	<%end%>
		public function LoadModulesProxy(name:String = NAME, data:Object=null)
		{
			super(name, data);
		}
		
		
		protected function sendLoadedNotification( noteName:String, noteBody:String, srName:String ):void
	    {
         	var srProxy:StartupResourceProxy = facade.retrieveProxy( srName ) as StartupResourceProxy;
	        if ( ! srProxy.isTimedOut() )
	        {
	            sendNotification( noteName, noteBody );
         	}
      	}

		
		public function load():void
		{
			trace('load modules');
			var moduleDescriptor:ModuleDescriptor = null;
			//repeat for all modules
		<%for modul in grid_modules%>
			trace("loading <%=modul.downcase%> module")
			moduleDescriptor = new ModuleDescriptor("<%=modul%>Module.swf");
			sendNotification(<%= name%>ShellConstants.ADD_MODULE, moduleDescriptor);
		<%end%>
		}
		
		public function moduleLoaded(loadedModuleDescriptor:ModuleDescriptor):void {
			trace('respondToModuleLoaded');
			switch (loadedModuleDescriptor.url) {
			<%for modul in grid_modules%>
				case "<%=modul%>Module.swf":
					<%=modul.downcase%>ModuleLoaded = true;
					break;
			<%end%>		
			}
			if (<%for modul in grid_modules%><%=modul.downcase%>ModuleLoaded && <%end%>true) { // include && modulename for every modules
				trace('modules loaded - sendLoadedNotification');
				sendLoadedNotification( <%= name%>ShellConstants.MODULES_LOADED, NAME, SRNAME );
			}
		}
		
		private function loaderCompleteHandler(event:Event):void
	    {
	         trace('modules loaded');
	         sendLoadedNotification( <%= name%>ShellConstants.MODULES_LOADED, NAME, SRNAME );
      	}
	}
}