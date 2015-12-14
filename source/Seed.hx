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
class Seed extends FlxSprite
{

    public function new()
    {
        super();
		
		// get random position somewhere in the air to the right or left of the screen
		if (FlxRandom.float() > 0.5) {
			// right of the screen
			y = FlxRandom.intRanged(30, FlxG.height - 60);
			x = FlxG.width + 10;
			velocity.set( -50, 0);
		}else {
			// left of the screen
			// right of the screen
			y = FlxRandom.intRanged(30, FlxG.height - 60);
			x = -10;
			velocity.set( 50, 0);
		}
		
		loadGraphic("assets/images/seed.png", true, 8, 8);
		animation.add("sparkle", [0, 1, 2, 3, 4, 5], 15, true);
		animation.play("sparkle");
		
    }

	public override function update() {
		super.update();
		
		// did we hit the ground?
		if (velocity.x < 0 && x < -10) {
			kill();
		}
		
		if (velocity.x > 0 && x > FlxG.width + 10) {
			kill();
		}
	}
}
