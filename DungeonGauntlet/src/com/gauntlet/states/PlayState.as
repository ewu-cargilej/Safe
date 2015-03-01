package com.gauntlet.states
{
	import com.gauntlet.objects.enemies.BaseEnemy;
	import com.gauntlet.objects.enemies.Bat;
	import com.gauntlet.objects.enemies.Ghost;
	import com.gauntlet.objects.enemies.Lumberer;
	import com.gauntlet.objects.enemies.Spider;
	import com.gauntlet.objects.player.Hero;
	import flash.display.BlendMode;
	import org.flixel.*;

	/**
	 * Play state.
	 * Title Scree/Level 0
	 * Gameplay
	 * 
	 * @author Casey Sliger
	 */
	public class PlayState extends FlxState
	{
		[Embed(source = '../../../../embeded_resources/Game_Screen/Level_Building/Rock_Tile.png')]private static var Tiles:Class;
		[Embed(source = '../../../../embeded_resources/Game_Screen/Maps/empty_map.txt', mimeType = 'application/octet-stream')]private static var EmptyMap:Class;
		[Embed(source = '../../../../embeded_resources/Title_Screen/TitleScreen_Logo.png')]private static var TitleLogo:Class;
		[Embed(source = '../../../../embeded_resources/Title_Screen/Button_Play.png')]private static var PlayButton:Class;
		[Embed(source = '../../../../embeded_resources/Title_Screen/Button_Credits.png')]private static var CreditsButton:Class;
		[Embed(source = '../../../../embeded_resources/Title_Screen/Icon_Jump.png')]private static var ImgJump:Class;
		[Embed(source = '../../../../embeded_resources/Title_Screen/Icon_MoveLeft.png')]private static var ImgLeft:Class;
		[Embed(source = '../../../../embeded_resources/Title_Screen/Icon_MoveRight.png')]private static var ImgRight:Class;
		[Embed(source = '../../../../embeded_resources/Title_Screen/Icon_Pause.png')]private static var ImgPause:Class;
		
		/** Level Complete flag. */
		protected var	_bLevelComplete	:Boolean;
		
		/** Map for level generation */
		protected var levelMap			:FlxTilemap;
		
		/** Player. */
		protected var mcHero			:Hero;
		protected var mcBat			:Bat;///////////////////////////////////////////////////////////////////////////////////test
		/**	Show current health. */
		protected var _txtHealth		:FlxText;
		
		/**	Show current score. */
		protected var _txtScore			:FlxText;
		
		/**	Show current rune. */
		protected var _txtRune			:FlxText;
		
		/** Current level number. */
		protected var _nLevelNumber		:int;
		
		/** Holder for Title components */
		protected var	_aTitleStuff	:Array;
		
		/** Flag for if the title screen is active */
		protected var	_bShowTitle		:Boolean;
		
		/**
		 * Set up the state.
		 */
		override public function create():void
		{
			FlxG.mouse.show();
			
			this._bLevelComplete = false;
			this._nLevelNumber = 0;
			this._aTitleStuff = new Array();
			this._bShowTitle = true;
			
			setupPlayer();
			
			levelMap = new FlxTilemap();
			this.generateRoomTiles(false);
			
			this.createTitle();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		
		/**
		 * Called every frame.
		 */
		override public function update():void
		{
			super.update();
			
			if (FlxG.keys.justPressed("K"))
				this._bLevelComplete = true;
			
			if (this._bLevelComplete)
			{
				//open door
				this.levelMap.setTile(levelMap.widthInTiles - 1, levelMap.heightInTiles - 2, 0);
			}
			
			FlxG.collide(mcHero, levelMap);
			FlxG.collide(mcBat, levelMap);///////////////////////////////////////////////////////////////////////////////test
			FlxG.overlap(mcHero, mcBat, CollideDamage);//////////////////////////////////////////////////////////////////test

			wrap();
		}
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////test function
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * @private
		 * Hero takes damage and is immune until flicker is finished.
		 */
		private function CollideDamage($hero:Hero,$enemy:BaseEnemy):void
		{
		if (!$hero.flickering)
		{
			$hero.flicker();
			trace("I took damage");
			$enemy.flicker();
		}
		
		}
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * @private
		 * Initially create and place the hero.
		 */
		protected function setupPlayer():void
		{
			mcHero = new Hero(FlxG.width/2 - 16, 640);
			
			add(mcHero);
			
			mcBat = new Bat(184, FlxG.height-192);/////////////////////////////////////////////////////////test
			add(mcBat);////////////////////////////////////////////////////////////////////////////////////////test
			//mcBat.acquireTarget(mcHero);////////////////////////////////////////////////////////////////////////test
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		
		/**
		 * @private
		 * Check for the hero exiting the room and create a new room if it does.
		 * Also wraps the hero when exiting the room.
		 * 
		 */
		protected function wrap():void
		{
			if (this.mcHero.x > FlxG.width)
			{
				this.mcHero.x = 32;
				
				if (this._nLevelNumber == 12)//go to results
					FlxG.switchState(new ResultState());
				else
					this.generateRoomTiles(this._nLevelNumber < 11);
			}
				
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		
		/**
		 * @private
		 * Create a new room with option to place platforms.
		 * 
		 * @param $bMakePlatforms		Whether or not to generate platforms.
		 */
		protected function generateRoomTiles($bMakePlatforms:Boolean):void
		{
			levelMap.loadMap(new EmptyMap(), Tiles, 32, 32, FlxTilemap.OFF);
			
			if ($bMakePlatforms)
			{
				for (var x :int = 1; x < levelMap.widthInTiles - 1; x++)
				{
					for (var y :int = 3; y < levelMap.heightInTiles - 2; y+=3)
					{
						if(Math.random() * 20 > 5)
							levelMap.setTile(x, y, 1);
					}
				}
			}
			this._nLevelNumber++;
			
			this._bLevelComplete = false;
			
			add(levelMap);
		}
		
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * @private
		 * Place enemies on the map.
		 */
		protected function placeEnemies():void
		{
			
		}
		
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * @private
		 * Place stuff for Title Screen.
		 *
		 */
		protected function createTitle():void
		{
			var tmpSprite :FlxSprite = new FlxSprite(FlxG.width / 2 - 225, FlxG.height / 2 - 300, TitleLogo);
			this._aTitleStuff.push(tmpSprite);
			add(tmpSprite);
			
			tmpSprite = new FlxSprite(FlxG.width / 2 - 35, FlxG.height / 2 + 50, ImgJump);
			this._aTitleStuff.push(tmpSprite);
			add(tmpSprite);
			
			tmpSprite = new FlxSprite(FlxG.width / 2 + 70, FlxG.height / 2 + 150, ImgRight);
			this._aTitleStuff.push(tmpSprite);
			add(tmpSprite);
			
			tmpSprite = new FlxSprite(FlxG.width / 2 - 140, FlxG.height / 2 + 150, ImgLeft);
			this._aTitleStuff.push(tmpSprite);
			add(tmpSprite);
			
			tmpSprite = new FlxSprite(FlxG.width / 2 - 95, FlxG.height - 68, ImgPause);
			this._aTitleStuff.push(tmpSprite);
			add(tmpSprite);
			
			var tmpButton :FlxButton = new FlxButton(FlxG.width - 350, FlxG.height / 2, "", removeTitle);
			tmpButton.loadGraphic(PlayButton);
			this._aTitleStuff.push(tmpButton);
			add(tmpButton);
			
			tmpButton = new FlxButton(60, FlxG.height / 2, "", goToCredits);
			tmpButton.loadGraphic(CreditsButton);
			this._aTitleStuff.push(tmpButton);
			add(tmpButton);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * @private
		 * Remove stuff for Title Screen.
		 * Add stuff for UI.
		 */
		protected function removeTitle():void
		{
			this._bLevelComplete = true;
			
			var tmpObj: FlxObject;
			
			while (this._aTitleStuff.length > 0)
			{
				tmpObj = this._aTitleStuff.pop();
				tmpObj.destroy();
				remove(tmpObj);
			}
			
			_txtHealth = new FlxText(64, FlxG.height - 48, 150, "Health:");
			_txtHealth.size = 24;
			add(_txtHealth);
			
			_txtScore = new FlxText(FlxG.width/2 - 64, FlxG.height - 48, 150, "Score:");
			_txtScore.size = 24;
			add(_txtScore);
			
			_txtRune = new FlxText(FlxG.width - 192, FlxG.height - 48, 150, "Rune:");
			_txtRune.size = 24;
			add(_txtRune);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * @private
		 * Go to credits.
		 *
		 */
		protected function goToCredits():void
		{
			FlxG.switchState(new CreditsState());
		}
	}
}
