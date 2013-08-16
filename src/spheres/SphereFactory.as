/**
 * User: VirtualMaestro
 * Date: 15.08.13
 * Time: 23:34
 */
package spheres
{
	import bb.core.BBNode;
	import bb.render.components.BBSprite;
	import bb.render.textures.BBTexture;

	/**
	 */
	public class SphereFactory
	{
		/**
		 */
		static public function createSphere(p_leftTopColor:uint = 0xffffff, p_leftBottomColor:uint = 0xffffff, p_rightBottomColor:uint = 0xffffff, p_rightTopColor:uint = 0xffffff, p_isEtalon:Boolean = false):BBNode
		{
			var sphere:BBNode = BBNode.get("sphere");
			var sprite:BBSprite = BBSprite.get(BBTexture.getTextureById(Assets.SPHERE_ID));
			sphere.addComponent(sprite);

			var len:Number = Config.sphereRadius * 0.707;
			var sphereLogic:SphereLogic = sphere.addComponent(SphereLogic) as SphereLogic;

			sphereLogic.leftTop.crystal = createCrystal(p_leftTopColor);
			sphereLogic.leftTop.crystal.transform.setPosition(-len, -len);
			sphere.addChild(sphereLogic.leftTop.crystal);

			sphereLogic.rightTop.crystal = createCrystal(p_rightTopColor);
			sphereLogic.rightTop.crystal.transform.setPosition(len, -len);
			sphere.addChild(sphereLogic.rightTop.crystal);

			sphereLogic.leftBottom.crystal = createCrystal(p_leftBottomColor);
			sphereLogic.leftBottom.crystal.transform.setPosition(-len, len);
			sphere.addChild(sphereLogic.leftBottom.crystal);

			sphereLogic.rightBottom.crystal = createCrystal(p_rightBottomColor);
			sphereLogic.rightBottom.crystal.transform.setPosition(len, len);
			sphere.addChild(sphereLogic.rightBottom.crystal);

			if (!p_isEtalon)
			{
				var backArrow:BBNode = BBNode.get("backArrow");
				sprite = BBSprite.get(BBTexture.getTextureById(Assets.BACK_ARROW_ID));
				var scaleFactor:Number = Config.sphereRadius / sprite.getTexture().width;
				sprite.scaleX = sprite.scaleY = scaleFactor;
				backArrow.addComponent(sprite);
				backArrow.mouseEnabled = true;
				sphere.addChild(backArrow);
				sphere.mouseChildren = true;
			}
			else
			{
				sphere.transform.setScale(Config.etalonScale, Config.etalonScale);
			}

			return sphere;
		}

		/**
		 */
		static private function createCrystal(p_color:uint):BBNode
		{
			var crystal:BBNode = BBNode.get("crystal");
			var sprite:BBSprite = BBSprite.get(BBTexture.getTextureById(Assets.CRYSTAL_ID));
			crystal.addComponent(sprite);
			crystal.transform.color = p_color;

			return crystal;
		}
	}
}
