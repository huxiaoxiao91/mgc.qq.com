package
{
	import com.junkbyte.console.Cc;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.Security;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;

	import view.components.SurpriseTreasurePane;

	[SWF(width = "91", height = "45")]
	/**
	 * 惊喜宝箱。新皮肤换肤，新皮肤id从280接口通知界面
	 * @author gaolei
	 * 
	 */	
	public class SurpriseTreasureSwf extends Sprite
	{
		public var surpriseTreasurePane:SurpriseTreasurePane;
		public var facade:ApplicationFacade;

		public function SurpriseTreasureSwf()
		{
			Security.allowDomain("*");

			//清除右键菜单
			var myContextMenu:ContextMenu = new ContextMenu();
			myContextMenu.hideBuiltInItems();
			this.contextMenu = myContextMenu;

			addEventListener(Event.ADDED_TO_STAGE, addHandler);
		}

		private var version_number:String = "version:3388.2.27.1";

		private function addHandler(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addHandler);

			surpriseTreasurePane = new SurpriseTreasurePane(this);
			surpriseTreasurePane.setSize(this.stage.stageWidth, this.stage.stageHeight);
			surpriseTreasurePane.visible = false;
			facade = ApplicationFacade.getInstance();
			facade.sendNotification(ApplicationFacade.STARTUP, this);
//			var obj:Object = {"op_type":226,"activity_id":1,"active":true,"left_open_box_times":0,"need_flower_count":2,"total_cd_seconds":10,"percent":0,"nest_left_open_times":6,"cd_seconds":0};
//			(facade.retrieveProxy(DataProxy.NAME) as DataProxy).request_as(obj);

			var lastIndex:int = stage.loaderInfo.url.indexOf("/", 7);
			var domain:String = stage.loaderInfo.url.substring(0, lastIndex);
			new VersionConfigLoader().loadConfig(loadVersionConfigCompleted, domain + VersionConfigLoader.DEFAULT_CONFIG_URL);
		}

		private function loadVersionConfigCompleted(loader:VersionConfigLoader):void
		{
			if (loader != null)
			{
				version_number = loader.stClientVer;

				initVersion();
//				ExternalInterface.call("alert", "读取版本配置信息成功。webClientVer:"+JSON.stringify(loader));
			}
			else
			{
				Cc.log("load version_config faile");
			}
		}

		private function initVersion():void
		{
			var myContextMenu:ContextMenu = new ContextMenu();
			myContextMenu.hideBuiltInItems();
			this.contextMenu = myContextMenu;

			var item:ContextMenuItem = new ContextMenuItem(version_number);
			myContextMenu.customItems.push(item);
		}
	}
}
