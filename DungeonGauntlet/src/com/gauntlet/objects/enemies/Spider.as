package com.gauntlet.objects.enemies
{
	
	/**
	 * Spider enemy
	 * 
	 * @author Casey Sliger
	 */
	public class Spider extends BaseEnemy
	{
		[Embed(source = "../../../../../embeded_resources/Game_Screen/Enemies/Spider.png")] private static var ImgSpider:Class;
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * Constructs the Spider object.
		 * 
		 * @param	X				The initial X position of the sprite.
		 * @param	Y				The initial Y position of the sprite.
		 */
		public function Spider(X:Number=0,Y:Number=0)
		{
			super(X, Y, 60, 20);
			
			this.loadGraphic(ImgSpider, true, true, 32, 32);
			
			//bounding box tweaks
			this.width = 28;
			this.height = 30;
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

