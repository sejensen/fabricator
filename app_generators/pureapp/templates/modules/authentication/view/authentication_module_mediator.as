package <%= base_package%>.modules.authentication.view {
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;
	
	import <%= base_package%>.modules.authentication.view.components.SignInView;

	public class AuthenticationModuleMediator extends FlexMediator {
		
		static public const NAME:String = "AuthenticationModuleMediator";
		
		static public function getDefinitionByName(path:String):Object {
			return getDefinitionByName(path);
		}
		
		public function AuthenticationModuleMediator(viewComponent:AuthenticationModule) {
			super(NAME, viewComponent);
		}
		
		public function get application():AuthenticationModule {
			return viewComponent as AuthenticationModule;
		}
		
		public function get signInView():SignInView {
			return application.signInView as SignInView;
		}
		
		override public function onRegister():void {
			registerMediator(new SignInViewMediator(signInView));
		} 
		
	}
}
