package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.util.FlxRandom;

/**
 * ...
 * @author ...
 */
class Tree extends FlxGroup 
{
	// the tree's x position
	public var x:Int;
	
	public var colorize:Bool = false;
	
	public var width_modifier:Float;
	public var height_modifier:Float;
	
	// the tree's spawn time
	var spawn_time:Int;
	
	// the max number of bushes
	var max_bushes:Int = 10;
	
	// the tree's current height (the center of the bushes
	public var height:Int = 0;
	
	// all the bushes attached to this tree
	var bushes:Array<Bush>;
	
	// the tree's trunk
	var trunk:FlxSprite;
	
	var health:Int = 0;
	
	var next_bush_index:Int = 0;
	
	var next_grow_time:Int = 180;
	var next_bush_time:Int = 360;
	
	var height_timeout:Int = 1;
	var bush_timeout:Int = 1;
	
	var height_points:Int = 0;
	var bush_points:Int = 0;
	
	var max_height:Int = 0;
	
	var total_bush_count:Int = 0;
	
	public function get_active_bush_count() {
		return total_bush_count;
		/*
		var retval:Int = 0;
		for (n in 0...bushes.length) {
			if (bushes[n].visible) {
				retval++;
			}
		}
		return retval;
		*/
	}
	
	// helper to set/modify a bush
	function activate_a_bush() {
		total_bush_count++;
		
		next_bush_index++;
		if (next_bush_index == bushes.length) {
			next_bush_index = 0;
		}
		
		var bush:Bush = bushes[next_bush_index];
			
		bush.activate_new();
	}
	
	function recreate_trunk() {
		trunk.makeGraphic(1, height, 0xffd1d1d1);
		trunk.y = FlxG.height - Reg.ground_height - height;
	}

	public function new(_x:Int) 
	{
		super();
		
		// create the trunk
		height = 24;
		trunk = new FlxSprite();
		recreate_trunk();
		trunk.x = _x;
		x = _x;
		add(trunk);
		
		bushes = new Array<Bush>();
		
		height_timeout = FlxRandom.intRanged(5, 8);
		bush_timeout = FlxRandom.intRanged(10, 20);
		max_height = FlxRandom.intRanged(60, 140);
		
		width_modifier = FlxRandom.floatRanged(0.8, 1.2);
		height_modifier = FlxRandom.floatRanged(0.8, 1.2);
		
		height_points = height_timeout;
		bush_points = bush_timeout;
		
		// create the bushes
		for (n in 0...max_bushes) {
			var newbush:Bush = new Bush();
			newbush.visible = false;
			newbush.parent = this;
			add(newbush);
			bushes.push(newbush);
		}
		
		// activate a few of the bushes
		for (n in 0...FlxRandom.intRanged(2,4)) {
			activate_a_bush();
		}
	}
	
	public override function update() {
		super.update();
		
		/*
		// possible grow, create new bushes, take damage, change colors, etc.
		if (Reg.gamestate.frame == next_grow_time) {
			// make the tree 1 pixel taller
			height++;
			recreate_trunk();
			
			// set the next grow time
			if (height < 110) {
				next_grow_time+=10;
			}
		}
		if (Reg.gamestate.frame == next_bush_time) {
			activate_a_bush();
			next_bush_time += 60;
		}
		*/
		
	}
	
	public function grow() {
		height_timeout--;
		bush_timeout--;
		
		if (height_timeout == 0 && height < max_height) {
			height++;
			recreate_trunk();
			height_timeout = height_points;
		}
		
		if (bush_timeout == 0) {
			activate_a_bush();
			bush_timeout = bush_points;
		}
		
		if (height == max_height) {
			if (!colorize) {
				Reg.gamestate.greatsound();
			}
			colorize = true;
		}
	}
	
}