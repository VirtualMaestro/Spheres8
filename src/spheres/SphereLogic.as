/**
 * User: VirtualMaestro
 * Date: 15.08.13
 * Time: 23:41
 */
package spheres
{
	import bb.core.BBComponent;

	/**
	 */
	public class SphereLogic extends BBComponent
	{
		public var leftTop:CrystalNode;
		public var rightTop:CrystalNode;
		public var leftBottom:CrystalNode;
		public var rightBottom:CrystalNode;

		/**
		 */
		public function SphereLogic()
		{
			super();

			leftTop = new CrystalNode();
			rightTop = new CrystalNode();
			leftBottom = new CrystalNode();
			rightBottom = new CrystalNode();
		}

		/**
		 */
		public function rotate():void
		{
			var ltColor:uint = leftTop.color;
			var rtColor:uint = rightTop.color;
			var lbColor:uint = leftBottom.color;
			var rbColor:uint = rightBottom.color;

			leftTop.color = rtColor;
			leftBottom.color = ltColor;
			rightBottom.color = lbColor;
			rightTop.color = rbColor;
		}
	}
}
