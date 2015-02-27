package
{
	import com.gauntlet.states.PlayState;
	import org.flixel.*;
	[Frame(factoryClass="com.gauntlet.loading.Preloader")]
	
	/**
	 * Main class.
	 * 
	 * @author Casey Sliger
	 */
	public class Main extends FlxGame 
	{
		/**
		 * Entry point.
		 */
		public function Main() 
		{
			super(1024, 768, PlayState, 1, 30, 30);
		}
		
	}
	
}