package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxPoint;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;
import flixel.util.FlxColorUtil;
import flixel.tweens.FlxEase;

/**
 * ...
 * @author while(software)
 */
class GameState extends FlxState {
	var frame:Int;
	
	public var trees:Array<Tree>;
	var dude:Dude;
	
	var ground:FlxSprite;
	
	override public function create():Void {
		frame = -1;

		//FlxG.mouse.visible = false;
		//var sprite = new FlxSprite();
		//sprite.loadGraphic("assets/images/crosshair.png", false, 45, 45);
		// Load the sprite's graphic to the cursor
		//FlxG.mouse.load(sprite.pixels);
		
		FlxG.camera.bgColor = 0xff1e202d;
		
		// create character
		dude = new Dude();
		dude.reset();
		add(dude);
		
		// create ground
		ground = new FlxSprite();
		ground.loadGraphic("assets/images/ground.png", false, 320, 20);
		MathHelper.CenterSprite(ground, "x");
		ground.y = FlxG.height - 20;
		add(ground);

		
		// create title
		
		// create grass
		
		// create a few trees at shrub state
		
	}

	//override public function update(elapsed:Float):Void {
	override public function update():Void {
		frame++;
		
		super.update();
		
		Reg.update();

	}
}
