package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.system.FlxSound;
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
	
	var title:FlxSprite;
	
	var overandout:Bool = false;
	
	var grasses:FlxGroup;
	public var gun_group:FlxGroup;
	
	public var waters:FlxGroup;
	public var seeds:FlxGroup;
	
	var dude:Dude;
	
	var ground:FlxSprite;
	
	public var state:Int = -1;
	
	var music:FlxSound;
	var noise:FlxSound;
	public var watersound:FlxSound;
	
	var time_to_seed:Int = 0;
	
	
	public var goodsounds:Array<FlxSound>;
	public var goodsounds2:Array<FlxSound>;
	var gs_index:Int = 0;
	
	public function goodsound() {
		goodsounds[gs_index].play();
		gs_index++;
		
		if (gs_index == 8) {
			gs_index = 0;
		}
	}
	
	public function greatsound() {
		
		for (n in 0...8) {
			new FlxTimer().start(0.1 * n).complete = function(t:FlxTimer):Void {
				goodsounds2[n].play();
			}
		}
		
	}
	
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
				
				// fade out the noise track
				FlxTween.tween(noise, { volume:0 }, 2);
				
				// play the music track
				FlxTween.tween(music, { volume:1 }, 2);
				music.play();
				
				FlxTween.tween(title, { alpha: 0 }, 2);
				
				time_to_seed = 10 * 60;
			}
			
			tree.grow();
		}
		
	}
	
	override public function create():Void {
		frame = -1;
		
		Reg.gamestate = this;
		
		// 3 minutes => 180 seconds
		bgcolor_timeline = new Timeline();
		bgcolor_timeline.type = TimeNodeType.color;
		
		bgcolor_timeline.nodes.push(new TimeNode(0, FlxColorUtil.getColor32(255, 0, 0, 0), FlxEase.cubeOut));
		bgcolor_timeline.nodes.push(new TimeNode(20 * 60, 0xff0f8ecf, FlxEase.cubeOut));
		bgcolor_timeline.nodes.push(new TimeNode(175 * 60, 0xff261b44, FlxEase.sineOut));
		bgcolor_timeline.nodes.push(new TimeNode(180 * 60, 0xff000000, FlxEase.quintInOut));
		
		treegroup = new FlxGroup();
		add(treegroup);

		gun_group = new FlxGroup();
		
		// create character
		dude = new Dude();
		dude.reset();
		add(dude);
		
		seeds = new FlxGroup();
		add(seeds);
		
		waters = new FlxGroup();
		add(waters);
		
		add(gun_group);
		
		// create ground
		ground = new FlxSprite();
		ground.loadGraphic("assets/images/ground.png", false, 640, 20);
		MathHelper.CenterSprite(ground, "x");
		ground.y = FlxG.height - 20;
		add(ground);

		
		// title
		title = new FlxSprite();
		title.loadGraphic("assets/images/title.png", true, 160, 64);
		title.animation.add("title", [0, 1, 2, 3], 8, true);
		title.animation.add("ending", [4, 5, 6, 7], 8, true);
		MathHelper.CenterSprite(title, "x");
		title.y = 10;
		title.animation.play("title");
		add(title);
		
		// create grass
		grasses = new FlxGroup();
		add(grasses);
		
		for (n in 0...40) {
			var grass:Grass = new Grass();
			grasses.add(grass);
		}
		
		
		// create a few trees at shrub state
		trees = new Array<Tree>();
		newtree(-1);
		
		state = 0;
		
		noise = FlxG.sound.load("noise", 0, true);
		noise.play();
		FlxTween.tween(noise, { volume: 0.8 }, 3);
		
		watersound = FlxG.sound.load("noise2", 0, true);
		watersound.play();
		
		music = FlxG.sound.load("awful", 0, false, true, false);
		
		goodsounds = new Array<FlxSound>();
		goodsounds2 = new Array<FlxSound>();
		for( n in 0...8) {
			goodsounds.push(FlxG.sound.load("good-" + Std.string(n), 0.4, false));
			goodsounds2.push(FlxG.sound.load("good-" + Std.string(n), 0.4, false));
		}
		
	}
	
	public function newtree(xpos:Int) {
		var newtree:Tree;
		if (xpos == -1) {
			newtree = new Tree(FlxRandom.intRanged(40, 280));
		}else {
			newtree = new Tree(xpos);
		}
		treegroup.add(newtree);
		trees.push(newtree);
	}

	override public function update():Void {
		
		FlxG.camera.bgColor = bgcolor;
		
		switch(state) {
			case 0:
				// we're waiting for the game to start

			case 1:
				// the game is running, update the frame count
				frame++;
				
				time_to_seed--;
				
				if (time_to_seed == 0) {
					// create a new seed
					var seed:Seed = new Seed();
					seeds.add(seed);
					
					trace("created a new seed!");
					
					// reset time
					time_to_seed = FlxRandom.intRanged(30, 100) * 6;
				}
				
				// set new bgcolor
				bgcolor = bgcolor_timeline.value(frame);
				FlxG.camera.bgColor = bgcolor;
				
				FlxG.overlap(waters, seeds, dropSeed);
				
				if (frame == 180 * 60) {
					state = 2;
				}
				
			case 2:
				// the game just ended
				if (! overandout) {
					FlxTween.tween(noise, { volume: 0.8 }, 2);
				
					// throw up the end-game UI	
					new FlxTimer(2).complete = function(t:FlxTimer) {
						FlxTween.tween(title, { alpha: 1 }, 2);
						title.animation.play("ending");
					}
					overandout = true;
				}
		}
		
		
		
		super.update();
		
		Reg.update();

	}
	
	function dropSeed(water:WaterParticle, seed:Seed) {
		seed.velocity.set(0, 100);
	}
	
}