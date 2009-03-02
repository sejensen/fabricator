package <%= base_package%>.modules.authentication.view
{
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;
	import <%= base_package%>.modules.authentication.view.components.SignInView;
	import <%= base_package%>.modules.authentication.model.AuthenticationProxy;
	
	import mx.controls.Button;
	import flash.events.MouseEvent;

	import flash.events.Event;
	
	/*import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;*/
	
	public class SignInViewMediator extends FlexMediator	{
		
		public static const NAME:String = "SignInViewMediator";
		
		public function SignInViewMediator( viewComponent:SignInView )
		{
			super( NAME, viewComponent );
		}
	
		/**
		 * The viewComponent cast to type SignInView.
		 */
		private function get signInView():SignInView
		{
			return viewComponent as SignInView;
		}
		
		public function get signInButton():Button {
		   return signInView.signInButton as Button;
		}

		public function reactToSignInButtonClick(e:MouseEvent):void {
			signInView.enabled = false;
			trace("sign in clicked");
			var authenticationProxy:AuthenticationProxy = retrieveProxy(AuthenticationProxy.NAME) as AuthenticationProxy;
			authenticationProxy.signIn(signInView.usernameTI.text, signInView.passwordTI.text);
			signInView.usernameTI.text = "";
			signInView.passwordTI.text = "";
			signInButton.enabled = false
			signInView.enabled = true;
		}
		
	}
}