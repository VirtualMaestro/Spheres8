/**
 * User: VirtualMaestro
 * Date: 15.08.13
 * Time: 23:27
 */
package modules
{
	import bb.camera.components.BBCamera;
	import bb.core.BBNode;
	import bb.layer.BBLayerModule;
	import bb.layer.constants.BBLayerNames;
	import bb.modules.BBModule;
	import bb.mouse.events.BBMouseEvent;
	import bb.render.components.BBSprite;
	import bb.render.textures.BBTexture;
	import bb.signals.BBSignal;
	import bb.ui.BBButton;
	import bb.ui.BBLabel;
	import bb.world.BBWorldModule;

	import nape.geom.Vec2;

	import spheres.SphereFactory;
	import spheres.SphereLogic;
	import spheres.SpheresData;

	import treefortress.sound.SoundAS;

	import ui.ButtonsFactory;

	/**
	 */
	public class GameLoop extends BBModule
	{
		private var _world:BBWorldModule;
		private var _initialSpheres:Vector.<BBNode>;
		private var _etalonSpheres:Vector.<BBNode>;

		/**
		 */
		public function GameLoop()
		{
			super();

			onReadyToUse.add(readyToUse);
		}

		/**
		 */
		private function readyToUse(p_signal:BBSignal):void
		{
			_world = getModule(BBWorldModule) as BBWorldModule;
			_initialSpheres = new <BBNode>[];
			_etalonSpheres = new <BBNode>[];

			Assets.init();

			initLayerAndCamera();

			initSplash();
		}

		/**
		 */
		private function initLayerAndCamera():void
		{
			var cameraMain:BBCamera = BBCamera.get(BBLayerNames.MAIN);
			(getModule(BBLayerModule) as BBLayerModule).add(BBLayerNames.MAIN, true).attachCamera(cameraMain);
			cameraMain.mouseEnable = true;
		}

		/**
		 */
		private function initSplash():void
		{
			_world.add(BBSprite.getWithNode(BBTexture.getTextureById(Assets.SPLASH_ID)).node, BBLayerNames.MAIN);
			var startGameButton:BBButton = ButtonsFactory.getUIButton("START GAME");
			startGameButton.node.onMouseUp.add(startGame);
			_world.add(startGameButton.node, BBLayerNames.MAIN);

			SoundAS.playLoop(Assets.LOOP_SND, 0.5);
		}

		/**
		 */
		private function startGame(p_signal:BBSignal):void
		{
			(p_signal.params as BBMouseEvent).propagation = false;
			destroySplash();

			createLevel();
		}

		/**
		 */
		private function destroySplash():void
		{
			_world.clear(BBLayerNames.MAIN);
		}

		/**
		 */
		private function createLevel():void
		{
			SoundAS.playLoop(Assets.LOOP_SND, 1.0);

			_world.add(BBSprite.getWithNode(BBTexture.getTextureById(Assets.BACKGROUND_PLAY_ID)).node, BBLayerNames.MAIN);

			if (_etalonSpheres.length > 0) _etalonSpheres.length = 0;
			if (_initialSpheres.length > 0) _initialSpheres.length = 0;

			var etalonPosition:Vec2 = Vec2.get(270, -250);
			var initialPosition:Vec2 = Vec2.get(-100, -150);

			createSpheresTree(etalonPosition, true);
			createSpheresTree(initialPosition, false);
		}

		/**
		 */
		private function createSpheresTree(p_position:Vec2, p_isEtalon:Boolean = false):void
		{
			var list:Vector.<SpheresData> = p_isEtalon ? Config.etalon : Config.initial;

			var sphere_1:BBNode = getSphereByData(list[0], p_isEtalon);
			var sphere_2:BBNode = getSphereByData(list[1], p_isEtalon);
			var sphere_3:BBNode = getSphereByData(list[2], p_isEtalon);
			var sphere_4:BBNode = getSphereByData(list[3], p_isEtalon);
			var sphere_5:BBNode = getSphereByData(list[4], p_isEtalon);
			var sphere_6:BBNode = getSphereByData(list[5], p_isEtalon);
			var sphere_7:BBNode = getSphereByData(list[6], p_isEtalon);
			var sphere_8:BBNode = getSphereByData(list[7], p_isEtalon);

			sphere_1.transform.setPosition(p_position.x, p_position.y);

			addSphereToWorld(attachSphere(sphere_1, null, true, p_isEtalon), p_isEtalon);
			addSphereToWorld(attachSphere(sphere_2, sphere_1, true, p_isEtalon), p_isEtalon);
			addSphereToWorld(attachSphere(sphere_3, sphere_1, false, p_isEtalon), p_isEtalon);
			addSphereToWorld(attachSphere(sphere_4, sphere_2, true, p_isEtalon), p_isEtalon);
			addSphereToWorld(attachSphere(sphere_5, sphere_3, false, p_isEtalon), p_isEtalon);
			addSphereToWorld(attachSphere(sphere_6, sphere_4, false, p_isEtalon), p_isEtalon);
			addSphereToWorld(attachSphere(sphere_7, sphere_5, true, p_isEtalon), p_isEtalon);
			addSphereToWorld(attachSphere(sphere_8, sphere_6, false, p_isEtalon), p_isEtalon);
			addSphereToWorld(attachSphere(sphere_8, sphere_7, true, p_isEtalon), p_isEtalon);
		}

		/**
		 */
		static private function getSphereByData(p_sphereData:SpheresData, p_isEtalon:Boolean):BBNode
		{
			return SphereFactory.createSphere(p_sphereData.ltColor, p_sphereData.lbColor, p_sphereData.rbColor, p_sphereData.rtColor, p_isEtalon);
		}

		/**
		 */
		static private function attachSphere(p_sphere:BBNode, p_attachToSphere:BBNode = null, p_isLeft:Boolean = true, p_isEtalon:Boolean = false):BBNode
		{
			if (p_attachToSphere)
			{
				var sphereLogic:SphereLogic = p_sphere.getComponent(SphereLogic) as SphereLogic;
				var attachToSphereLogic:SphereLogic = p_attachToSphere.getComponent(SphereLogic) as SphereLogic;
				var attachToSpherePosition:Vec2 = p_attachToSphere.transform.getPosition();
				var distance:Number = Config.sphereRadius * 0.707 * 2 * (p_isEtalon ? Config.etalonScale : 1);
				attachToSpherePosition.y += distance;

				if (p_isLeft)
				{
					attachToSphereLogic.leftBottom.addContactNode(sphereLogic.rightTop);
					attachToSpherePosition.x -= distance;
				}
				else
				{
					attachToSphereLogic.rightBottom.addContactNode(sphereLogic.leftTop);
					attachToSpherePosition.x += distance;
				}

				p_sphere.transform.setPosition(attachToSpherePosition.x, attachToSpherePosition.y);
			}

			return p_sphere;
		}

		/**
		 */
		private function addSphereToWorld(p_sphere:BBNode, p_isEtalon:Boolean = false):void
		{
			if (!p_sphere.isOnStage)
			{
				_world.add(p_sphere, BBLayerNames.MAIN);

				if (p_isEtalon)
				{
					_etalonSpheres.push(p_sphere);
				}
				else
				{
					p_sphere.getChildByName("backArrow").onMouseUp.add(rotateSphere);
					_initialSpheres.push(p_sphere);
				}
			}
		}

		/**
		 */
		private function rotateSphere(p_signal:BBSignal):void
		{
			var sphere:BBNode = (p_signal.dispatcher as BBNode).parent;
			var logic:SphereLogic = sphere.getComponent(SphereLogic) as SphereLogic;

			SoundAS.playFx(Assets.CLICK_SND, 1.0);

			logic.rotate();

			if (checkComplete())
			{
				createWinDialog();
			}
		}

		/**
		 */
		private function checkComplete():Boolean
		{
			var len:int = _etalonSpheres.length;
			var etalonSphere:SphereLogic;
			var currentSphere:SphereLogic;

			for (var i:int = 0; i < len; i++)
			{
				etalonSphere = _etalonSpheres[i].getComponent(SphereLogic) as SphereLogic;
				currentSphere = _initialSpheres[i].getComponent(SphereLogic) as SphereLogic;

				if (etalonSphere.leftTop.color != currentSphere.leftTop.color) return false;
				else if (etalonSphere.leftBottom.color != currentSphere.leftBottom.color) return false;
				else if (etalonSphere.rightBottom.color != currentSphere.rightBottom.color) return false;
				else if (etalonSphere.rightTop.color != currentSphere.rightTop.color) return false;
			}

			return true;
		}

		/**
		 */
		private function createWinDialog():void
		{
			_world.add(BBSprite.getWithNode(BBTexture.getTextureById(Assets.BACKGROUND_WIN_ID)).node, BBLayerNames.MAIN);
			var label:BBLabel = BBLabel.getWithNode("YOU WIN! TRY AGAIN", true, 16);
			label.node.transform.setPosition(0, -50);
			_world.add(label.node, BBLayerNames.MAIN);
			var tryAgainButton:BBButton = ButtonsFactory.getUIButton("TRY AGAIN");
			tryAgainButton.node.transform.setPosition(0, 50);
			_world.add(tryAgainButton.node, BBLayerNames.MAIN);
			tryAgainButton.node.onMouseUp.add(tryAgainHandler);

			SoundAS.stopAll();
			SoundAS.playFx(Assets.WIN_SND, 1.0);
		}

		/**
		 */
		private function tryAgainHandler(p_signal:BBSignal):void
		{
			(p_signal.params as BBMouseEvent).propagation = false;
			_world.clear(BBLayerNames.MAIN);
			createLevel();
		}
	}
}
