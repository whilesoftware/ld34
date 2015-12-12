package;
import flixel.FlxSprite;
import flixel.group.FlxGroup;

/**
 * ...
 * @author ...
 */
class Dude extends FlxGroup {
	
	var body:FlxSprite = new FlxSprite();

	public function new() 
	{
		super();
		
		body.loadGraphic("assets/images/dude-clean.png", true, 32, 32);
		body.animation.add("cycle", [ 0, 1, 2, 3, 4], 10, true);
		add(body);
		body.animation.play("cycle");
	}
	
	public override function update() {
		trace("updating dude");
		super.update();
	}
	
}