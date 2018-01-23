package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

class PlayState extends FlxState
{
	
	private var score:FlxText;
	private var gameManager:GameManager; 
	
	override public function create():Void
	{
		super.create();
		trace("playstate");
	
	
		
		//score = new FlxText(10, 10, 200, "score= 0", 20);
		//add(score);
		
		gameManager = new GameManager();
		add(gameManager);
	
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

	
	}
	
	
	
}
