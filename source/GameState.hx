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
	
	//var trees:Array<Tree>;
	var dude:Dude;
	
	override public function create():Void {
		frame = -1;

		FlxG.mouse.visible = false;
		FlxG.camera.bgColor = 0xff1e202d;
		
		// create ground
		
		// create character
		dude = new Dude();
		add(dude);
		
		// create title
		
		// create grass
		
		// create a few trees at shrub state
		
	}

	//override public function update(elapsed:Float):Void {
	override public function update():Void {
		frame++;
		
		super.update();

	}
}
