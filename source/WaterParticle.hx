package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.util.FlxSpriteUtil;
import lime.math.Vector2;
import flixel.tweens.FlxEase;
import flixel.util.FlxRandom;

/**
 * ...
 * @author ...
 */
class WaterParticle extends FlxSprite
{
	
	var _velocity:Vector2 = new Vector2();
	
	var speed:Float = 200;
	
	var size:Int;

    public function new()
    {
        super();
        size = MathHelper.RandomRangeInt(1, 3);
		
        var rancolor:Int = MathHelper.RandomRangeInt(0, 2);
        if (rancolor == 0) {
            makeGraphic(size, size , 0xff00aeef);
        }else if (rancolor == 1) {
            makeGraphic(size, size , 0xffa3dbf1);
        }else {
            makeGraphic(size, size , 0xffb1b1f2);
        }
    }

    public function gobabygo(xpos:Float, ypos:Float, xdir:Float, ydir:Float) {
		x = xpos - size/2;
		y = ypos - size / 2;
		
		_velocity.x = xdir + FlxRandom.floatRanged(-0.1, 0.1);
		_velocity.y = ydir + FlxRandom.floatRanged( -0.1, 0.1);
		
		_velocity.normalize(1);
		
		_velocity.x *= speed;
		_velocity.y *= speed;
    }
	
	public override function update() {
		// set the new position as a function of velocity and gravity
		
		var newx:Float;
		var newy:Float;
		
		newx = x + _velocity.x * Reg.frame_delta;
		newy = y + _velocity.y * Reg.frame_delta + 250 * Math.pow(Reg.frame_delta, 2);
		
		_velocity.x = (newx - x) / Reg.frame_delta;
		_velocity.y = (newy - y) / Reg.frame_delta;
		
		// did we hit the ground?
		if (newy >= FlxG.height - Reg.ground_height) {
			// we hit the ground!
			
			// tell the gamestate to water anything nearby
			Reg.gamestate.water_stuff(newx);
			
			kill();
		}
		
		x = newx;
		y = newy;
	}
}
