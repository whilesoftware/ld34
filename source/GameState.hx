package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.util.FlxPoint;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;
import flixel.util.FlxColorUtil;
import flixel.tweens.FlxEase;
import flixel.util.FlxRandom;

/**
 * ...
 * @author while(software)
 */
class GameState extends FlxState {
	public var frame:Int;
	
	public var bgcolor:Int = 0xff000000;
	
	public var bgcolor_timeline:Timeline;
	
	public var trees:Array<Tree>;
	var treegroup:FlxGroup;
	var next_tree_spawn_time:Int = 0;
	
	var grasses:FlxGroup;
	public var gun_group:FlxGroup;
	
	public var waters:FlxGroup;
	
	var dude:Dude;
	
	var ground:FlxSprite;
	
	public var state:Int = -1;
	
	public function water_stuff(xpos:Float) {
		// look for trees within a few pixels of this x location
		for(tree in trees) {
			if (Math.abs(xpos - tree.x) > 8) {
				// too far away, ignore this tree
				continue;
			}

			// for each, give it some love
			if (state == 0) {
				state = 1;
			}
		}
		
	}
	
	override public function create():Void {
		frame = -1;
		
		Reg.gamestate = this;

		//FlxG.mouse.visible = false;
		//var sprite = new FlxSprite();
		//sprite.loadGraphic("assets/images/crosshair.png", false, 45, 45);
		// Load the sprite's graphic to the cursor
		//FlxG.mouse.load(sprite.pixels);
		
		// 3 minutes => 180 seconds
		bgcolor_timeline = new Timeline();
		bgcolor_timeline.type = TimeNodeType.color;
		// start black
		bgcolor_timeline.nodes.push(new TimeNode(0, FlxColorUtil.getColor32(255, 0, 0, 0), FlxEase.cubeOut));
		// fade quickly towards red
		bgcolor_timeline.nodes.push(new TimeNode(2 * 60, 0xff570f01, FlxEase.cubeOut));
		// fade to yellow
		bgcolor_timeline.nodes.push(new TimeNode(6 * 60, 0xfffecf27, FlxEase.cubeOut));
		// lighten up to mid-day
		bgcolor_timeline.nodes.push(new TimeNode(8 * 60, 0xffffd5a0, FlxEase.sineOut));
		// mid-day blue
		bgcolor_timeline.nodes.push(new TimeNode(10 * 60, 0xff0f8ecf, FlxEase.sineOut));
		// afternoon
		bgcolor_timeline.nodes.push(new TimeNode(120 * 60, 0xff89739d, FlxEase.quintIn));
		// evening
		bgcolor_timeline.nodes.push(new TimeNode(160 * 60, 0xff261b44, FlxEase.sineOut));
		// night time
		bgcolor_timeline.nodes.push(new TimeNode(170 * 60, 0xff03031f, FlxEase.sineOut));
		// game over
		bgcolor_timeline.nodes.push(new TimeNode(180 * 60, 0xff000000, FlxEase.sineOut));
		
		treegroup = new FlxGroup();
		add(treegroup);

		gun_group = new FlxGroup();
		
		// create character
		dude = new Dude();
		dude.reset();
		add(dude);
		
				
		waters = new FlxGroup();
		add(waters);
		
		
		add(gun_group);
		
		// create ground
		ground = new FlxSprite();
		ground.loadGraphic("assets/images/ground.png", false, 320, 20);
		MathHelper.CenterSprite(ground, "x");
		ground.y = FlxG.height - 20;
		add(ground);

		
		// TODO: create title
		
		// TODO: create grass
		grasses = new FlxGroup();
		add(grasses);
		
		
		// create a few trees at shrub state
		trees = new Array<Tree>();
		for (n in 0...2) {
			var newtree:Tree = new Tree(FlxRandom.intRanged(40, 280));
			treegroup.add(newtree);
			trees.push(newtree);
		}
		
		state = 0;
		
	}

	override public function update():Void {
		
		FlxG.camera.bgColor = bgcolor;
		
		switch(state) {
			case 0:
				// we're waiting for the game to start

			case 1:
				// the game is running, update the frame count
				frame++;
				
				// set new bgcolor
				bgcolor = bgcolor_timeline.value(frame);
				FlxG.camera.bgColor = bgcolor;
			case 2:
				// the game just ended
				// throw up the end-game UI
				
		}
		
		
		
		super.update();
		
		Reg.update();

	}
}
