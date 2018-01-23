package;

import flixel.FlxGame;
import openfl.Lib;
import openfl.display.Sprite;

class Main extends Sprite
{
	var ancho_juego:Int = 960;
	var alto_juego:Int = 640;
	//var initialState:Class<FlxState>= PlayState;
	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, MenuState));
	//	addChild(new FlxGame(0, 0, PlayState));
	}
}
