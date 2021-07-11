import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.FlxCamera;
import flixel.math.FlxPoint;
import flixel.FlxObject;
#if windows
import Discord.DiscordClient;
import sys.thread.Thread;
#end

import flixel.group.FlxGroup.FlxTypedGroup;
import openfl.ui.Keyboard;
import flixel.FlxSprite;
import flixel.FlxG;

class OffestCustomizeState extends MusicBeatState
{

    var defaultX:Float = FlxG.width * 0.55 - 135;
    var defaultY:Float = FlxG.height / 2 - 50;

    var background:FlxSprite;
    var curt:FlxSprite;
    var front:FlxSprite;

    var text:FlxText;
    var blackBorder:FlxSprite;

    var dad:Character;
    var dadAnim = 7;
    var dadChar = 'flippy';

    var arrayOffest:Array<Int> = [
        0, 0,
    ];

    private var camHUD:FlxCamera;
    
    public override function create() {
        #if windows
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Customizing Gameplay", null);
		#end

        background = new FlxSprite(-600, -200).loadGraphic(Paths.image('stageback','shared'));
        curt = new FlxSprite(-500, -300).loadGraphic(Paths.image('stagecurtains','shared'));
        front = new FlxSprite(-650, 600).loadGraphic(Paths.image('stagefront','shared'));

		Conductor.changeBPM(102);
		persistentUpdate = true;

        super.create();

		camHUD = new FlxCamera();
		camHUD.bgColor.alpha = 0;
        FlxG.cameras.add(camHUD);

        background.scrollFactor.set(0.9,0.9);
        curt.scrollFactor.set(0.9,0.9);
        front.scrollFactor.set(0.9,0.9);

        add(background);
        add(front);
        add(curt);

		var camFollow = new FlxObject(0, 0, 1, 1);

        dad = new Character(100, 100, dadChar, 'default', false, true, arrayOffest[0], arrayOffest[1]);
        dad.scrollFactor.set();
        dad.screenCenter();
        
        add(dad);

        switch (dadChar)
		{
			case "flippy":
				dad.y += 100;
			case "flippy-crazy":
				dad.y += 320;
				dad.x += 20;
			case 'pico':
				dad.y += 300;
			case 'senpai':
				dad.x += 150;
				dad.y += 360;
		}

		var camPos:FlxPoint = new FlxPoint(dad.getGraphicMidpoint().x + 400, dad.getGraphicMidpoint().y);

		camFollow.setPosition(camPos.x, camPos.y);

		add(camFollow);

		FlxG.camera.follow(camFollow, LOCKON, 0.01);
		// FlxG.camera.setScrollBounds(0, FlxG.width, 0, FlxG.height);
		FlxG.camera.zoom = 0.9;
		FlxG.camera.focusOn(camFollow.getPosition());

        text = new FlxText(5, FlxG.height + 40, 0, 'Character Offest():' + Std.string(arrayOffest[dadAnim]) + ', ' + Std.string(arrayOffest[dadAnim+1]), 12);
		text.scrollFactor.set();
		text.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        
        blackBorder = new FlxSprite(-30,FlxG.height + 40).makeGraphic((Std.int(text.width + 900)),Std.int(text.height + 600),FlxColor.BLACK);
		blackBorder.alpha = 0.5;

		add(blackBorder);

		add(text);

		FlxTween.tween(text,{y: FlxG.height - 18},2,{ease: FlxEase.elasticInOut});
		FlxTween.tween(blackBorder,{y: FlxG.height - 18},2, {ease: FlxEase.elasticInOut});

        FlxG.mouse.visible = true;

    }

    override function update(elapsed:Float) {
		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;

        super.update(elapsed);

        FlxG.camera.zoom = FlxMath.lerp(0.9, FlxG.camera.zoom, 0.95);
        camHUD.zoom = FlxMath.lerp(1, camHUD.zoom, 0.95);

        if (FlxG.keys.justPressed.W)
            {
				dadAnim = 0;
                updateOffest();
            }
        if (FlxG.keys.justPressed.A)
            {
				dadAnim = 2;
                updateOffest();
            }
        if (FlxG.keys.justPressed.S)
            {
				dadAnim = 4;
                updateOffest();
            }
        if (FlxG.keys.justPressed.D)
            {
                dadAnim = 6;
                updateOffest();
            }
         if (FlxG.keys.justPressed.F)
            {
                dadAnim = 8;
            }

        if (FlxG.keys.justPressed.LEFT)
            {
                arrayOffest[0] --;
                updateOffest();
            }
        if (FlxG.keys.justPressed.RIGHT)
            {
                arrayOffest[0] ++;
                updateOffest();
            }
         if (FlxG.keys.justPressed.UP)
            {
                arrayOffest[1] ++;
                updateOffest();
            }
        if (FlxG.keys.justPressed.DOWN)
            {
                arrayOffest[1] --;
                updateOffest();
            }

        if (FlxG.keys.justPressed.R)
            {
                updateCharacter();
            }

        if (controls.BACK)
        {
            FlxG.mouse.visible = false;
            FlxG.sound.play(Paths.sound('cancelMenu'));
			FlxG.switchState(new OptionsMenu());
        }

    }

    override function beatHit() 
    {
        super.beatHit();

        switch(dadAnim){
            case 0:
                dad.playAnim('singUP', true);
            case 2:
                dad.playAnim('singLEFT', true);
            case 4:
                dad.playAnim('singDOWN', true);
            case 6:
                dad.playAnim('singRIGHT', true);
            default:
                dad.dance();
        }

        FlxG.camera.zoom += 0.015;
        camHUD.zoom += 0.010;

        trace('beat');

    }
    
    function updateOffest():Void{
        text.text = 'Character Offest():' + Std.string(arrayOffest[0]) + ', ' + Std.string(arrayOffest[1]);
    }

    function updateCharacter():Void{
        remove(dad);
        dad = new Character(100, 100, dadChar, 'default', false, true, arrayOffest[0], arrayOffest[1]);
        dad.scrollFactor.set();
        dad.screenCenter();
        
        add(dad);
    }
}