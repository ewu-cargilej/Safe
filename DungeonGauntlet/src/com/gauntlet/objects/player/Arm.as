package com.gauntlet.objects.player
{
	import org.flixel.FlxSprite;

	
	/**
	 * Hero arm.
	 * 
	 * @author Casey Sliger
	 */
	public class Arm extends FlxSprite
	{
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * Constructs the Arm object.
		 * 
		 * @param	X				The initial X position of the sprite.
		 * @param	Y				The initial Y position of the sprite.
		 * @param	SimpleGraphic	The graphic you want to display (OPTIONAL - for simple stuff only, do NOT use for animated images!).
		 */
		public function Arm(X:Number=0,Y:Number=0,SimpleGraphic:Class=null)
		{
			super(X, Y, SimpleGraphic);
		}
		
	}
}

