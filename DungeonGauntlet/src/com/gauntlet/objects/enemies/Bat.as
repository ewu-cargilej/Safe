package com.gauntlet.objects.enemies
{
	import flash.utils.Timer;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	/**
	 * Bat enemy.
	 * 
	 * @author Casey Sliger
	 */
	public class Bat extends BaseEnemy
	{
		[Embed(source = "../../../../../embeded_resources/Game_Screen/Enemies/Bat.png")] private static var ImgBat:Class;
		
		/** Counts the number of frames. */
		protected var	_nFrame: int = 60;
		/** Stores a random number from 0-100, used for bat movement. */
		protected var	_nMoveValue: int = 0;
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * Constructs the Bat object.
		 * 
		 * @param	X				The initial X position of the sprite.
		 * @param	Y				The initial Y position of the sprite.
		 */
		public function Bat(X:Number=0,Y:Number=0)
		{
			super(X, Y, 40, 20, 1);
			
			this.loadGraphic(ImgBat, true, true, 64, 32);
			
			//bounding box tweaks
			this.width = 60;
			this.height = 30;
			this.offset.x = 2;
			this.offset.y = 1;
			
			//basic player physics
			this.drag.x = 2000;
			this.acceleration.y = 0;
			this.maxVelocity.x = 60;
			this.maxVelocity.y = 30;
			this.drag.y = 2000;
			
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
			this.acceleration.x = 0;
			this.acceleration.y = 0;
			this.play("idle");
			_nFrame++;
			if (_nFrame >= 15)//every 15 frames get a new move value
			{
			_nFrame = 0;
			_nMoveValue = int(Math.random() * 100);
			}
			if (_nMoveValue>=0 && _nMoveValue<25)//move left
			{
				if (this.x<=32)//dont go off screen
				{
				this.acceleration.x += this.drag.x;
				}
				else
				{
				this.acceleration.x -= this.drag.x;	
				}
			}
			if (_nMoveValue>=25 && _nMoveValue<50)//move right
			{
				if (this.x>=(FlxG.width-32-this.width))//dont go off screen
				{
				this.acceleration.x -= this.drag.x;	
				}
				else
				{
				this.acceleration.x += this.drag.x;	
				}
			}
			if (_nMoveValue>=50 && _nMoveValue<75)//move up
			{
				if (this.y<=32)//dont go off screen
				{
				this.acceleration.y += this.drag.y;	
				}
				else
				{
				this.acceleration.y -= this.drag.y;	
				}	
			}
			if (_nMoveValue>=75 && _nMoveValue<100)//move down
			{
				if (this.y>=(FlxG.height-96-this.height))//dont go off screen
				{
				this.acceleration.y -= this.drag.y;		
				}
				else
				{
				this.acceleration.y += this.drag.y;		
				}
			}
		}
		
		
	}
}

