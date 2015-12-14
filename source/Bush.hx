package;
import flixel.FlxG;
import flixel.FlxSprite;


import flixel.util.FlxRandom;
import openfl.display.BlendMode;

/**
 * ...
 * @author ...
 */
class Bush extends FlxSprite {
	
	public var offset_x:Int = 0;
	public var offset_y:Int = 0;
	
	public var parent:Tree;
	
	var size:Int = 0;
	
	var floating:Bool = false;

	public function new() 
	{
		super();
		
	}
	
	public override function update() {
		super.update();
		
		if (Reg.gamestate.state != 2) {
			x = parent.x + offset_x - size / 2;
			y = FlxG.height - Reg.ground_height - parent.height + offset_y - size / 2;
		}else {
			// the game is over!
			
			if (! floating) {
				floating = true;
				// start them floating away
				velocity.set(FlxRandom.floatRanged(-50, 50), FlxRandom.floatRanged(-50, 50));
			}else {
				if (x < -30 || x > FlxG.width + 30 || y < -30 || y > FlxG.height + 30) {
					kill();
				}
			}
		}
	}
	
	public function activate_new() {
		visible = true;
		
		// how big should it be?
		var abc:Int = parent.get_active_bush_count();
		if (abc < 5) {
			size = 4;
		}else if (abc < 8) {
			size = 8;
		}else if (abc < 12) {
			size = 16;
		}else if (abc < 16) {
			size = 24;
		}else {
			size = 32;
		}
		
		// randomize it's position theta
		var theta:Float = FlxRandom.floatRanged(0, Math.PI * 2);
		
		/*
		
			*/
			
			//this.replaceColor(0xffffffff, 0xffff0000);
		
		// give it a position
		offset_x = Std.int(size * parent.width_modifier * FlxRandom.floatRanged(0.3, 0.6) * Math.cos(theta));
		offset_y = Std.int(size * parent.height_modifier * FlxRandom.floatRanged(0.3, 0.6) * Math.sin(theta));
		
		// give it a rotation
		angle = FlxRandom.floatRanged(0, 360);
		
		// assign it one of our spritesheets and an animation
		loadGraphic("assets/images/bush-" + Std.string(size) + ".png", true, size, size, true);
		
		if (parent.colorize) {
			this.replaceColor(0xffffffff, 
				(0xff << 24) |
				(FlxRandom.intRanged(0, 255) << 16) |
				(FlxRandom.intRanged(0, 255) << 8) |
				(FlxRandom.intRanged(0, 255)) );
		}
			
		alpha = FlxRandom.floatRanged(0.5, 1);
		blend = BlendMode.LIGHTEN;
			
		animation.add("throb", [0, 1, 2, 3, 4], 4, true);
		
		// start the animation
		animation.play("throb", false, -1);
		
		x = parent.x + offset_x - size / 2;
		y = FlxG.height - Reg.ground_height - parent.height + offset_y - size / 2;
	}
	
}