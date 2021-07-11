package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;

using StringTools;

class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';
	public var curStage:String = 'default';

	public var holdTimer:Float = 0;

	public var customOffest:Bool = false;
	public var customOffestX:Int = 0;
	public var customOffestY:Int = 0;

	public function new(x:Float, y:Float, ?character:String = "bf", ?stage:String = "default", ?isPlayer:Bool = false, ?offest:Bool = false, offestY:Int = 0, offestX:Int = 0)
	{
		super(x, y);

		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		curStage = stage;

		customOffest = offest;
		customOffestX = offestX;
		customOffestY = offestY;

		this.isPlayer = isPlayer;

		var tex:FlxAtlasFrames;
		antialiasing = true;

		switch (curCharacter)
		{
			case 'gf':
				// GIRLFRIEND CODE
				switch(curStage){		
					default:
						tex = Paths.getSparrowAtlas('characters/GF_assets');
					case 'land-destroyed':
						tex = Paths.getSparrowAtlas('characters/GF_Hurt_assets');
					case 'land-cute', 'land-deadbodys':
						tex = Paths.getSparrowAtlas('characters/GF_statue_assets');
				}
				
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				playAnim('danceRight');

			case 'bf':
				var tex;
				switch(curStage){		
					default:
						tex = Paths.getSparrowAtlas('characters/BOYFRIEND', 'shared');
					case 'land-deadbodys', 'land-destroyed':
						tex = Paths.getSparrowAtlas('characters/BOYFRIEND_SCARED', 'shared');
					case 'land-lol':
						tex = Paths.getSparrowAtlas('characters/BOYFRIEND_HAPPY', 'shared');
				}
				
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				playAnim('idle');

				flipX = true;
			
			case 'flippy':
				switch(curStage){		
					default:
						tex = Paths.getSparrowAtlas('characters/Flippy', 'shared');			
					case 'land-destroyed':
						tex = Paths.getSparrowAtlas('characters/Psycho-Fliqpy', 'shared');
					case 'land-cute':
						tex = Paths.getSparrowAtlas('characters/Fliqpy', 'shared');
				}
				frames = tex;
				animation.addByPrefix('idle', 'Pico Idle Dance', 24);
				animation.addByPrefix('singUP', 'pico Up note', 24);
				animation.addByPrefix('singRIGHT', 'Pico NOTE LEFT', 24);
				animation.addByPrefix('singDOWN', 'Pico Down Note', 24);
				animation.addByPrefix('singLEFT', 'Pico Note Right', 24);
				
				animation.addByPrefix('singUP-alt', 'SCREAM up note', 24);
				animation.addByPrefix('singDOWN-alt', 'SCREAM up note', 24);
				animation.addByPrefix('singLEFT-alt', 'SCREAM note', 24);
				animation.addByPrefix('singRIGHT-alt', 'SCREAM note', 24);

				addOffset('idle');

				playAnim('idle');

				flipX = true;

			case 'flippy-crazy':
				tex = Paths.getSparrowAtlas('characters/Fliqpy-Crazy', 'shared');

				frames = tex;
				animation.addByPrefix('idle', 'FliqpyBLOOD Idle', 24);
				animation.addByPrefix('singUP', 'FliqpyBLOOD Up note', 24);
				animation.addByPrefix('singRIGHT', 'FliqpyBLOOD NOTE LEFT', 24);
				animation.addByPrefix('singDOWN', 'FliqpyBLOOD Down Note', 24);
				animation.addByPrefix('singLEFT', 'FliqpyBLOOD Note Right', 24);

				playAnim('idle');

				flipX = true;

			case 'dad':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/DADDY_DEAREST', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'Dad idle dance', 24);
				animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);

				addOffset('idle');

				playAnim('idle');
		}

		//Offest Mayor Arriba, Menor Abajo
		//Offest Mayor Izquierda, Menor Derecha
		if(!customOffest){
			switch(curCharacter){
				case 'gf':{
					addOffset('cheer');
					addOffset('sad', -2, -2);
					addOffset('danceLeft', 0, -9);
					addOffset('danceRight', 0, -9);

					addOffset("singUP", 0, 4);
					addOffset("singRIGHT", 0, -20);
					addOffset("singLEFT", 0, -19);
					addOffset("singDOWN", 0, -20);
					addOffset('hairBlow', 45, -8);
					addOffset('hairFall', 0, -9);

					addOffset('scared', -2, -17);
				}
				case 'bf':{
					addOffset('idle', -5);
					addOffset("singUP", -29, 27);
					addOffset("singRIGHT", -38, -7);
					addOffset("singLEFT", 12, -6);
					addOffset("singDOWN", -10, -50);
					addOffset("singUPmiss", -29, 27);
					addOffset("singRIGHTmiss", -30, 21);
					addOffset("singLEFTmiss", 12, 24);
					addOffset("singDOWNmiss", -11, -19);
					addOffset("hey", 7, 4);
					addOffset('firstDeath', 37, 11);
					addOffset('deathLoop', 37, 5);
					addOffset('deathConfirm', 37, 69);
					addOffset('scared', -4);
				}
				case 'flippy':{
					switch(curStage){
						case 'land-cute':
							addOffset("singUP", -20, 33);
							addOffset("singRIGHT", -50, -10);
							addOffset("singLEFT", 75, -10);
							addOffset("singDOWN", 190, -80);
						case 'land-destroyed':
							addOffset("singUP", -6, 39);
							addOffset("singRIGHT", -25, 10);
							addOffset("singLEFT", 39, -16);
							addOffset("singDOWN", 2, -61);
							addOffset("singUP-alt", 0, 0);
							addOffset("singRIGHT-alt", 0, 0);
							addOffset("singLEFT-alt", 0, 0);
							addOffset("singDOWN-alt", 0, 0);
						default:
							addOffset("singUP", -30, 40);
							addOffset("singRIGHT", -95, -5);
							addOffset("singLEFT", 60, 5);
							addOffset("singDOWN", 183, -15);
					}
				}
				case 'flippy-crazy':{
					addOffset('idle');
					addOffset("singUP", 7, 48);
					addOffset("singRIGHT", 25, 8);
					addOffset("singLEFT", 80, 9);
					addOffset("singDOWN", -15, -75);
				}
				case 'dad':{
					addOffset("singUP", -6, 50);
					addOffset("singRIGHT", 0, 27);
					addOffset("singLEFT", -10, 10);
					addOffset("singDOWN", 0, -30);
				}
			}
		}else{
			addOffset("singUP", customOffestX, customOffestY);
			addOffset("singRIGHT", customOffestX, customOffestY);
			addOffset("singLEFT", customOffestX, customOffestY);
			addOffset("singDOWN", customOffestX, customOffestY);
		}

		dance();

		if (isPlayer)
		{
			flipX = !flipX;

			// Doesn't flip for BF, since his are already in the right place???
			if (!curCharacter.startsWith('bf'))
			{
				// var animArray
				var oldRight = animation.getByName('singRIGHT').frames;
				animation.getByName('singRIGHT').frames = animation.getByName('singLEFT').frames;
				animation.getByName('singLEFT').frames = oldRight;

				// IF THEY HAVE MISS ANIMATIONS??
				if (animation.getByName('singRIGHTmiss') != null)
				{
					var oldMiss = animation.getByName('singRIGHTmiss').frames;
					animation.getByName('singRIGHTmiss').frames = animation.getByName('singLEFTmiss').frames;
					animation.getByName('singLEFTmiss').frames = oldMiss;
				}
			}
		}
	}

	override function update(elapsed:Float)
	{
		if (!curCharacter.startsWith('bf'))
		{
			if (animation.curAnim.name.startsWith('sing'))
			{
				holdTimer += elapsed;
			}

			var dadVar:Float = 4;

			if (curCharacter == 'dad')
				dadVar = 6.1;
			if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001)
			{
				trace('dance');
				dance();
				holdTimer = 0;
			}
		}

		switch (curCharacter)
		{
			case 'gf':
				if (animation.curAnim.name == 'hairFall' && animation.curAnim.finished)
					playAnim('danceRight');
		}

		super.update(elapsed);
	}

	private var danced:Bool = false;

	/**
	 * FOR GF DANCING SHIT
	 */
	public function dance()
	{
		if (!debugMode)
		{
			switch (curCharacter)
			{
				case 'gf':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'gf-christmas':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'gf-car':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}
				case 'gf-pixel':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'spooky':
					danced = !danced;

					if (danced)
						playAnim('danceRight');
					else
						playAnim('danceLeft');
				default:
					playAnim('idle');
			}
		}
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		animation.play(AnimName, Force, Reversed, Frame);

		var daOffset = animOffsets.get(AnimName);
		if (animOffsets.exists(AnimName))
		{
			offset.set(daOffset[0], daOffset[1]);
		}
		else
			offset.set(0, 0);

		if (curCharacter == 'gf')
		{
			if (AnimName == 'singLEFT')
			{
				danced = true;
			}
			else if (AnimName == 'singRIGHT')
			{
				danced = false;
			}

			if (AnimName == 'singUP' || AnimName == 'singDOWN')
			{
				danced = !danced;
			}
		}
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}
