package view.mediators {

	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;


	public class ApplicationMediator extends Mediator implements IMediator {

		public static const NAME:String = "ApplicationMediator";

		public function ApplicationMediator(viewComponent:Object) {
			super(NAME, viewComponent);

			facade.registerMediator(new MessagePaneMediator(component.messagePane));
			facade.registerMediator(new BottomPaneMediator(component.bottomPane));
			facade.registerMediator(new GiftPaneMediator(component.giftPane));
			facade.registerMediator(new EffectPaneMediator(component.effectPane));
			facade.registerMediator(new NumberPaneMediator(component.numberPane));
			facade.registerMediator(new FlyInputPaneMediator(component.flyInputPane));
			facade.registerMediator(new FacePaneMediator(component.facePane));
		}

		override public function listNotificationInterests():Array {
			return new Array();
		}

		override public function handleNotification(notification:INotification):void {

		}

		public function get component():x51VideoGift {
			return viewComponent as x51VideoGift;
		}
	}
}
