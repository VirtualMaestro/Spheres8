/**
 * User: VirtualMaestro
 * Date: 15.08.13
 * Time: 23:29
 */
package
{
	import bb.render.textures.BBTexture;
	import treefortress.sound.SoundAS;

	/**
	 */
	public class Assets
	{
		// TEXTURES
		[Embed(source="../assets/backArrow.png")]
		static private var backArrow:Class;

		[Embed(source="../assets/splash.jpg")]
		static private var splash:Class;

		[Embed(source="../assets/playBackground.jpg")]
		static private var playBackground:Class;

		// SOUNDS
		[Embed(source="../assets/loop.mp3")]
		static private var loopSnd:Class;

		[Embed(source="../assets/win.mp3")]
		static private var winSnd:Class;

		[Embed(source="../assets/click.mp3")]
		static private var clickSnd:Class;

		//
		static public var SPHERE_ID:String = "SPHERE_ID";
		static public var CRYSTAL_ID:String = "CRYSTAL_ID";
		static public var BACK_ARROW_ID:String = "BACK_ARROW_ID";
		static public var SPLASH_ID:String = "SPLASH_ID";
		static public var BACKGROUND_WIN_ID:String = "BACKGROUND_WIN_ID";
		static public var BACKGROUND_PLAY_ID:String = "BACKGROUND_PLAY_ID";

		static public var LOOP_SND:String = "LOOP_SND";
		static public var WIN_SND:String = "WIN_SND";
		static public var CLICK_SND:String = "CLICK_SND";

		/**
		 */
		static public function init():void
		{
			BBTexture.createFromColorCircle(Config.sphereRadius, SPHERE_ID, 0x00000000, 0xff000000, 2);
			BBTexture.createFromColorCircle(Config.crystalRadius, CRYSTAL_ID, 0xffffffff);
			BBTexture.createFromAsset(backArrow, BACK_ARROW_ID);
			BBTexture.createFromAsset(splash, SPLASH_ID);
			BBTexture.createFromAsset(playBackground, BACKGROUND_PLAY_ID);
			BBTexture.createFromColorRect(400, 200, BACKGROUND_WIN_ID, 0xaa00FF00);

			SoundAS.addSound(LOOP_SND, new loopSnd());
			SoundAS.addSound(WIN_SND, new winSnd());
			SoundAS.addSound(CLICK_SND, new clickSnd());
		}
	}
}
