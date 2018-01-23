package;

import flash.media.SoundTransform;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.text.FlxTextField;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.util.FlxSort;
import flixel.FlxGame;
import flixel.ui.FlxButton;
import flixel.system.FlxSound;
import flixel.util.FlxTimer;
import openfl.media.SoundChannel;
import flixel.util.FlxColor;
class MenuState extends FlxState
	{
		private var pantalla_base:FlxSprite;
		private var boton_credits:FlxButton;
		private var boton_how_to_play:FlxButton;
		private var boton_quit:FlxButton;
		private var botonVolver:FlxButton;
		private var boton_loose:FlxSprite;
		private var boton_victory:FlxSprite;
		private var screenCredits:FlxSprite;
		private var screenHowToPlay:FlxSprite;
		private var butonNewGame:FlxButton;
		private var flxgame:FlxGame;
		private var boton_sound:FlxSound;
		private var menu_sound:SoundTransform;
		private var currentScreen:String;
		private var numText:FlxText;
		private var timerSpawnPantallaKill:FlxTimer;
		override public function create():Void
	{
		super.create();
    
		timerSpawnPantallaKill = new FlxTimer();
		
		boton_sound = FlxG.sound.load(AssetPaths.buton2__wav);
	
		FlxG.sound.playMusic(AssetPaths.m3__wav,0.5, true);
	
		AddMainMenu();
		
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	
		
	}
	private function OnMouseDown_newGame(){
		trace("click new game");
	boton_sound.play();
	RemoveElements_menu();
	//var s:FlxState = new FlxState(new PlayState);
	//PantallaKill();
	
	FlxG.switchState(new PlayState());
	}

	private function OnMouseDown_credits(){
	trace("credits");
	currentScreen = "credits";
	boton_sound.play();
	RemoveElements_menu();
	
	screenCredits = new FlxSprite(0, 0, AssetPaths.p_menu_SCREEN_CREDITS__png);
	add(screenCredits);
	
	botonVolver = new FlxButton(0, 0,OnMouseDownMenu);
	botonVolver.loadGraphic(AssetPaths.spriteSheet_menu__png,true,70,70,false);
	botonVolver.x = Reg.anchoJuego - botonVolver.width - 50;
	botonVolver.y = Reg.altoJuego - botonVolver.height;
	add(botonVolver);
	
	}
	private function OnMouseDown_How_to_play(){
		trace("how to play ");
	
	currentScreen = "how";
	boton_sound.play();
	RemoveElements_menu();
	AddHowToPlay();
	}
	private function RemoveElements_menu(){
	
	
	

	
	pantalla_base.destroy();
	butonNewGame.destroy();
	boton_credits.destroy();
	boton_how_to_play.destroy();
	
	}
	private function RemoveCredits(){
		
		screenCredits.destroy();
		botonVolver.destroy();
		
	}
	private function AddMainMenu(){
		
		
		
		
		pantalla_base = new FlxSprite(0, 0, AssetPaths.p_menu_base__png);
	
		
		butonNewGame = new FlxButton(0, 0, "", OnMouseDown_newGame);
	
		
		butonNewGame.loadGraphic(AssetPaths.spriteSheet_new_game__png,true,100, 100, false);
		butonNewGame.x = Reg.anchoJuego / 2 - butonNewGame.width / 2;
		butonNewGame.y=Reg.altoJuego/2-butonNewGame.height/2-50;
		
		//flxgame = new FlxGame(960,640);
	
		boton_how_to_play = new FlxButton(0, 0, "", OnMouseDown_How_to_play);
		boton_how_to_play.loadGraphic(AssetPaths.spriteSheet_how_play__png, true, 70, 70, false);
		boton_how_to_play.x =boton_how_to_play.width;
		boton_how_to_play.y = Reg.altoJuego - boton_how_to_play.height-50;

		
		boton_credits = new FlxButton(0, 0, "", OnMouseDown_credits);
		boton_credits.loadGraphic(AssetPaths.spriteSheet_credits__png, true, 50, 50, false);
		boton_credits.x = Reg.anchoJuego-boton_credits.width-50;
		boton_credits.y = Reg.altoJuego  - boton_credits.height-50;
		
		add(pantalla_base);
		//add(boton_new_game);
	
		add(butonNewGame);
		add(boton_how_to_play);
		add(boton_credits);
		//trace("menu");
	

		
	}
	private function AddHowToPlay(){
	screenHowToPlay = new FlxSprite(0, 0, AssetPaths.p_SCREEN_HOW_to_PLAY__png);
	
	botonVolver = new FlxButton(0, 0,OnMouseDownMenu);
	botonVolver.loadGraphic(AssetPaths.spriteSheet_menu__png,true,70,70,false);
	botonVolver.x = Reg.anchoJuego - botonVolver.width - 50;
	botonVolver.y = Reg.altoJuego - botonVolver.height;
	
	
	add(screenHowToPlay);	
	add(botonVolver);
	
	}
	
	private function Remove_How(){
	
		screenHowToPlay.destroy();
		botonVolver.destroy();
	}
	private function OnMouseDownMenu(){
		
		trace("menu vuelta");
		
		boton_sound.play();
		if(currentScreen=="credits"){
		RemoveCredits();
		}else{
		Remove_How();	
		}
		AddMainMenu();
				
	}
	private function OnMouseDownMenu_how(){
		boton_sound.play();
		Remove_How();
		AddMainMenu();
	}
	
	private function PantallaKill(){
		var obj:FlxSprite=new FlxSprite();
		obj.loadGraphic(AssetPaths.p_menu_KILL__png);
		add(obj);
		}
	
		private function OnStart(t:FlxTimer){
			trace("empieza juego");
			
			//FlxG.switchState(new PlayState());
		}	
		
		
	}