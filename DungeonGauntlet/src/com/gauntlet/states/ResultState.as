package com.gauntlet.states
{
	import com.gauntlet.states.PlayState;
	import org.flixel.*;

	/**
	 * Show results and high scores.
	 * 
	 * @author Casey Sliger
	 */
	public class ResultState extends FlxState
	{
		/**
		 * Set up the state.
		 */
		override public function create():void
		{
			var t:FlxText;
			t = new FlxText(0, FlxG.height / 2 - 32, FlxG.width, "Results Screen");
			t.size = 64;
			t.alignment = "center";
			add(t);
			t = new FlxText(FlxG.width/2-100,FlxG.height-100,200,"click to go back to title");
			t.size = 24;
			t.alignment = "center";
			add(t);
			
			FlxG.mouse.show();
		}

		/**
		 * Called every frame.
		 * 
		 */
		override public function update():void
		{
			super.update();

			if(FlxG.mouse.justPressed())
				FlxG.switchState(new PlayState());
		}
	}
}