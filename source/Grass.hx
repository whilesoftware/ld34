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
class Grass extends FlxSprite {
    public function new()
    {
        super();
		
		loadGraphic("assets/images/grass.png", true, 8, 16, true);
		animation.add("small", [0, 1, 2, 3, 2, 1], 2, true);
		animation.add("big", [4, 5, 6, 7, 8, 9, 8, 7, 6, 5], 3, true);
		
		y = FlxG.height - Reg.ground_height - 12;
		
		x = FlxRandom.intRanged(0, FlxG.width);
		
		if (FlxRandom.float() > 0.5) {
			animation.play("small",true, FlxRandom.intRanged(0, 5));
		}else {
			animation.play("big", true, FlxRandom.intRanged(0, 9));
		}
    }
}