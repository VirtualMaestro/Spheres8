/**
 * User: VirtualMaestro
 * Date: 15.08.13
 * Time: 23:38
 */
package spheres
{
	import bb.core.BBNode;

	/**
	 */
	public class CrystalNode
	{
		private var _contactNode:CrystalNode;
		private var _crystal:BBNode;

		/**
		 */
		public function set crystal(p_val:BBNode):void
		{
			_crystal = p_val;
		}

		public function get crystal():BBNode
		{
			return _crystal;
		}

		/**
		 */
		public function addContactNode(p_node:CrystalNode):void
		{
			_contactNode = p_node;
			p_node._contactNode = this;
			p_node.updateColorFromContact();
		}

		/**
		 */
		public function set color(p_val:uint):void
		{
			_crystal.transform.color = p_val;
			if (_contactNode) _contactNode.updateColorFromContact();
		}

		/**
		 */
		public function get color():uint
		{
			return _crystal.transform.color;
		}

		/**
		 */
		public function updateColorFromContact():void
		{
			if (_contactNode) _crystal.transform.color = _contactNode.color;
		}
	}
}
