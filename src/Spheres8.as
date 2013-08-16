package
{
	import bb.config.BBConfig;
	import bb.core.BabyBox;
	import bb.mouse.constants.BBMouseActions;
	import bb.signals.BBSignal;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	import modules.GameLoop;

	import spheres.SphereColors;
	import spheres.SpheresData;

	/**
	 */
	[SWF(width="800", height="600", frameRate="30")]
	public class Spheres8 extends Sprite
	{
		private var _babyBox:BabyBox;

		/**
		 */
		public function Spheres8()
		{
			if (stage) loadSettings();
			else addEventListener(Event.ADDED_TO_STAGE, loadSettings);
		}

		/**
		 */
		private function loadSettings(p_event:Event = null):void
		{
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, parseSettings);
			loader.load(new URLRequest("settings.txt"));
		}

		/**
		 */
		private function parseSettings(p_event:Event):void
		{
			var loader:URLLoader = (p_event.target as URLLoader);
			loader.removeEventListener(Event.COMPLETE, parseSettings);

			var settings:Object = JSON.parse(loader.data);
			var etalon:Object = settings.etalon;
			Config.etalon.push(parseSphere(etalon.s1));
			Config.etalon.push(parseSphere(etalon.s2));
			Config.etalon.push(parseSphere(etalon.s3));
			Config.etalon.push(parseSphere(etalon.s4));
			Config.etalon.push(parseSphere(etalon.s5));
			Config.etalon.push(parseSphere(etalon.s6));
			Config.etalon.push(parseSphere(etalon.s7));
			Config.etalon.push(parseSphere(etalon.s8));

			var initial:Object = settings.initial;
			Config.initial.push(parseSphere(initial.s1));
			Config.initial.push(parseSphere(initial.s2));
			Config.initial.push(parseSphere(initial.s3));
			Config.initial.push(parseSphere(initial.s4));
			Config.initial.push(parseSphere(initial.s5));
			Config.initial.push(parseSphere(initial.s6));
			Config.initial.push(parseSphere(initial.s7));
			Config.initial.push(parseSphere(initial.s8));

			Config.sphereRadius = settings.sphereRadius;
			Config.crystalRadius = settings.crystalRadius;
			Config.etalonScale = settings.etalonScale;

			//
			initEngine();
		}

		/**
		 */
		static private function parseSphere(p_sphere:Object):SpheresData
		{
			var data:SpheresData = new SpheresData();
			data.ltColor = SphereColors.colorsMapping[p_sphere.lt];
			data.lbColor = SphereColors.colorsMapping[p_sphere.lb];
			data.rbColor = SphereColors.colorsMapping[p_sphere.rb];
			data.rtColor = SphereColors.colorsMapping[p_sphere.rt];

			return data;
		}

		/**
		 */
		private function initEngine(p_event:Event = null):void
		{
			var config:BBConfig = new BBConfig(800, 600, 30);
			config.mouseSettings = BBMouseActions.UP | BBMouseActions.DOWN;
			config.mouseNodeSettings = BBMouseActions.UP | BBMouseActions.DOWN;

			_babyBox = BabyBox.get();
			_babyBox.onInitialized.add(startGame);
			_babyBox.init(stage, config);
		}

		/**
		 */
		private function startGame(p_signa:BBSignal):void
		{
			_babyBox.addModule(GameLoop);
		}
	}
}
