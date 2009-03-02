package <%= base_package%>.modules.authentication.model {
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.proxy.FabricationProxy;	
	import <%= base_package%>.common.<%= name%>Constants;
	
	public class AuthenticationProxy extends FabricationProxy {

		static public const NAME:String = "AuthenticationProxy";
	
		
		public function AuthenticationProxy(name:String = NAME) {
			super(name);
		}
		
		
		public function signIn(username:String, password:String):void {
			trace("signing in with username "+username);
			routeNotification(<%= name%>Constants.VALID_LOGIN, username, "securityToken","*");
		}
	}
}
