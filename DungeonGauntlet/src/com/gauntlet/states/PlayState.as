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
	 * Gameplay
	 * 
	 * @author Casey Sliger
	 */
	public class PlayState extends FlxState
	{
		[Embed(source = '../../../../embeded_resources/Game_Screen/Level_Building/Tiles.png')]private static var Tiles:Class;
		[Embed(source = '../../../../embeded_resources/Game_Screen/Maps/empty_map.txt', mimeType = 'application/octet-stream')]private static var EmptyMap:Class;
		
		[Embed(source = '../../../../embeded_resources/Music/Play.mp3')]private static var MusicPlay:Class;
		[Embed(source = '../../../../embeded_resources/Music/Boss.mp3')]private static var MusicBoss:Class;
		
		/** Level Complete flag. */
		protected var	_bLevelComplete	:Boolean;
		
		/** Map for level generation */
		protected var levelMap			:FlxTilemap;
		
		/** Player. */
		protected var mcHero			:Hero;
		
		/** All enemies on the screen. */
		protected var _enemyGroup		:FlxGroup;
		
		/** Show current health. */
		protected var _txtHealth		:FlxText;
		
		/**	Show current score. */
		protected var _txtScore			:FlxText;
		
		/**	Show current rune. */
		protected var _txtRune			:FlxText;
		
		/** Current level number. */
		protected var _nLevelNumber		:int;
		
		/**
		 * Set up the state.
		 */
		override public function create():void
		{
			FlxG.playMusic(MusicPlay);
			
			FlxG.mouse.show();
			
			this._bLevelComplete = false;
			this._nLevelNumber = 1;
			this._enemyGroup = new FlxGroup();
			add(_enemyGroup);
			
			setupPlayer();
			
			levelMap = new FlxTilemap();
			this.generateRoomTiles(true);
			this.placeEnemies();
			
			
			_txtHealth = new FlxText(64, FlxG.height - 48, 150, "HP: " + this.mcHero.health);
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
		 * Called every frame.
		 */
		override public function update():void
		{
			super.update();
			
			if (FlxG.keys.justPressed("K"))
			{
				this._bLevelComplete = true;
				this._enemyGroup.kill();
				this._enemyGroup.clear();
			}
			
			if (this._bLevelComplete)
			{
				//open door
				this.levelMap.setTile(levelMap.widthInTiles - 1, levelMap.heightInTiles - 2, 0);
			}
			
			FlxG.collide(mcHero, levelMap);
			
			FlxG.collide(_enemyGroup, levelMap);
			
			FlxG.overlap(mcHero, _enemyGroup, collideDamage);

			wrap();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * @private
		 * Hero takes damage and is immune until flicker is finished.
		 */
		private function collideDamage($hero:Hero,$enemy:BaseEnemy):void
		{
			if (!$hero.flickering)
			{
				$hero.flicker();
				$hero.hurt($enemy.getContact());
				
				this._txtHealth.text = "HP: " + this.mcHero.health;
			}
		}
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * @private
		 * Initially create and place the hero.
		 */
		protected function setupPlayer():void
		{
			mcHero = new Hero(32, 640);
			
			add(mcHero);
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
				
				if (this._nLevelNumber == 11)
					FlxG.switchState(new ResultState());
				else
				{
					if (this._nLevelNumber < 10)
					{
						this.generateRoomTiles(true);
						this.placeEnemies();
						this._nLevelNumber++;
						this._txtRune.text = this._nLevelNumber + "";
					}
					else
					{
						this.generateRoomTiles(false);
						this._nLevelNumber++;
						
						FlxG.music.stop();
						FlxG.playMusic(MusicBoss);
					}
				}
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
							levelMap.setTile(x, y - 1 + int(Math.random() * 2), int(Math.random() * 4 + 1));
					}
				}
			}
			
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
			for (var x :int = 7; x < levelMap.widthInTiles - 2; x++)
			{
				for (var y :int = 2; y < levelMap.heightInTiles - 2; y+=3)
				{
					if (levelMap.getTile(x,y) == 0 && Math.random() * 20 > 19)
					{
						var n :int = int(Math.random() * 3);
						
						if (n == 0)
						{
							var mcBat :Bat = new Bat(x * 32, y * 32);
							this._enemyGroup.add(mcBat);
							add(mcBat);
						}
						else if (n == 1)
						{
							var mcSpider :Spider = new Spider(x * 32, y * 32);
							this._enemyGroup.add(mcSpider);
							add(mcSpider);
							mcSpider.acquireTarget(mcHero);
						}
						else
						{
							var mcLumberer :Lumberer = new Lumberer(x * 32, y * 32);
							this._enemyGroup.add(mcLumberer);
							add(mcLumberer);
							mcLumberer.acquireTarget(mcHero);
						}
						
					}
				}
			}
			
		}
	}
}
