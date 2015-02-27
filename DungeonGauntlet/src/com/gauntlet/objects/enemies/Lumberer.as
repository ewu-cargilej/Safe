package com.gauntlet.objects.enemies
{
	
	/**
	 * Lumberer enemy
	 * 
	 * @author Casey Sliger
	 */
	public class Lumberer extends BaseEnemy
	{
		[Embed(source = "../../../../../embeded_resources/Game_Screen/Enemies/Lumberer.png")] private static var ImgLumberer:Class;
		
		/** Attack damage. Different from contact damage. */
		protected var	_nAttackDamage	:int;
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * Constructs the Lumberer object.
		 * 
		 * @param	X				The initial X position of the sprite.
		 * @param	Y				The initial Y position of the sprite.
		 */
		public function Lumberer(X:Number=0,Y:Number=0)
		{
			super(X, Y, 90, 25);
			
			this._nAttackDamage = 40;
			
			this.loadGraphic(ImgLumberer, true, true, 64, 64);
			
			//bounding box tweaks
			this.width = 60;
			this.height = 62;
			this.offset.x = 2;
			this.offset.y = 1;
			
			//basic player physics
			this.drag.x = 2000;
			this.acceleration.y = 500;
			this.maxVelocity.x = 120;
			this.maxVelocity.y = 0;
			
			//animations
			this.addAnimation("idle", [0]);
		}
		
		/**
		 * Called every frame.
		 * Update the Enemy position and other stuff.
		 */
		override public function update():void
		{
			super.update();
			
			this.play("idle");
		}
	}
}

