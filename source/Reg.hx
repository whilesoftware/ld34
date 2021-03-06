package;

import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import flixel.util.FlxSave;


class Reg
{
	
	public static var frame_number:Int = 0;
	public static var frame_delta:Float = 1 / 60;
	
	public static var gamestate:GameState;
	
	public static var ground_height:Int = 19;
	
	public static function update() {
		frame_number++;
	}
	
	public static function timenow():Float {
		return frame_number * frame_delta;
	}
}