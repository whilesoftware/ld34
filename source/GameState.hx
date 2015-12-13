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
	
	public var trees:Array<Tree>;
	var treegroup:FlxGroup;
	var next_tree_spawn_time:Int = 0;
	
	var grasses:FlxGroup;
	
	var dude:Dude;
	
	var ground:FlxSprite;
	
	var state:Int = -1;
	
	override public function create():Void {
		frame = -1;
		
		Reg.gamestate = this;

		//FlxG.mouse.visible = false;
		//var sprite = new FlxSprite();
		//sprite.loadGraphic("assets/images/crosshair.png", false, 45, 45);
		// Load the sprite's graphic to the cursor
		//FlxG.mouse.load(sprite.pixels);
		
		FlxG.camera.bgColor = 0xff1e202d;
		
		treegroup = new FlxGroup();
		add(treegroup);
		
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

		
		// TODO: create title
		
		// TODO: create grass
		grasses = new FlxGroup();
		add(grasses);
		
		
		// create a few trees at shrub state
		trees = new Array<Tree>();
		for (n in 0...2) {
			var newtree:Tree = new Tree(FlxRandom.intRanged(40, 280));
			treegroup.add(newtree);
		}
		
		state = 1;
		
	}

	//override public function update(elapsed:Float):Void {
	override public function update():Void {
		switch(state) {
			case 0:
				// we're waiting for the game to start
			case 1:
				// the game is running, update the frame count
				frame++;
				
				if (frame == next_tree_spawn_time) {
					// create a new tree
					
					// randomize time until next tree is created
				}
			case 2:
				// the game just ended
				// throw up the end-game UI
			case 3:
				// the user hit reset, restart the game
				
		}
		
		
		
		super.update();
		
		Reg.update();

	}
}
