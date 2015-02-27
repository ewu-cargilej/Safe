package com.gauntlet.objects.enemies
{
	
	/**
	 * Bat enemy.
	 * 
	 * @author Casey Sliger
	 */
	public class Bat extends BaseEnemy
	{
		[Embed(source = "../../../../../embeded_resources/Game_Screen/Enemies/Bat.png")] private static var ImgBat:Class;
		
		/** Whether the bat is moving left. */
		protected var	_bMovingLeft	:Boolean;
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * Constructs the Bat object.
		 * 
		 * @param	X				The initial X position of the sprite.
		 * @param	Y				The initial Y position of the sprite.
		 */
		public function Bat(X:Number=0,Y:Number=0)
		{
			super(X, Y, 40, 20);
			
			this._bMovingLeft = true;
			
			this.loadGraphic(ImgBat, true, true, 64, 32);
			
			//bounding box tweaks
			this.width = 60;
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
			
			if (Math.random() * 100 < 20)
				this._bMovingLeft = ! this._bMovingLeft;
			
			if (this._bMovingLeft)
				this.acceleration.x -= this.drag.x;
			else
				this.acceleration.x += this.drag.x;
		}
		
	}
}

