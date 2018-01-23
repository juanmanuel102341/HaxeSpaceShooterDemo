package;
import flash.desktop.Clipboard;
import flixel.ui.FlxButton;
import flixel.ui.FlxSpriteButton;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.input.mouse.FlxMouse;
import flixel.FlxG;
/**
 * ...
 * @author juan manuel sala
 */
class Screen extends FlxSprite
{
	private var fondo_screen:FlxSprite;
	private var loose_screen:FlxSprite;
	private var botonQuit:FlxButton;
	private var boton_p_again:FlxButton;
	
	private var cartelWin:FlxSprite;
	
	private var replay:Bool=false;
	public var eleccion_01:Bool = false;
	private var win:Bool = false;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		fondo_screen = new FlxSprite(0, 0, AssetPaths.p_menu_base__png);
	FlxG.state.add(fondo_screen);
		
	}
	public function ScreenWin(){
	win = true;	
	var botonPlayAgain:FlxSprite;
	
	cartelWin = new FlxSprite(0, 0, AssetPaths.p_menu_won__png);
	cartelWin.x = Reg.anchoJuego / 2 - cartelWin.width / 2;
	cartelWin.y = cartelWin.height + 50;
	ButtonPlayAgain();
	
	
	FlxG.state.add(cartelWin);
			
	}
	public function ScreenLoose(){
		trace("perdiste");
	win = false;
	
	loose_screen = new FlxSprite();
	loose_screen.loadGraphic(AssetPaths.p_menu_loose__png);
	loose_screen.x=Reg.anchoJuego / 2 - loose_screen.width / 2;
	loose_screen.y = loose_screen.height + 50;
	ButtonPlayAgain();
	ButtonQuit();
	FlxG.state.add(loose_screen);
	}
	private function PlayAgain(){
		trace("jugando de nuevo");
		eleccion_01 = true;//ya decidio
		replay = true;//jugar de nuevo
	}
	private function Quit_01(){
		trace("quit");
	eleccion_01 = true;
	replay = false;	
	}
	public function Eleccion():Bool{
		//elige su juega d nuevo o se va 
		
		return replay;
	}
	public function Dead(){
		trace("dead m");
		fondo_screen.destroy();
		if(win){
		cartelWin.destroy();
		boton_p_again.destroy();
		
		}else{
			trace("muerte loose");
			loose_screen.destroy();
			boton_p_again.destroy();
			botonQuit.destroy();
			
		}
	}
	private function ButtonPlayAgain(){
		boton_p_again = new FlxButton(0, 0,PlayAgain);
	boton_p_again.loadGraphic(AssetPaths.spriteSheet_p_again__png,true,75,75,false);
	boton_p_again.x = Reg.anchoJuego - boton_p_again.width - 50;
	boton_p_again.y = Reg.altoJuego - boton_p_again.height;
	
	FlxG.state.add(boton_p_again);
	}

	private function ButtonQuit(){
		botonQuit = new FlxButton(0, 0, Quit_01);
		botonQuit.loadGraphic(AssetPaths.spriteSheet_button_quit__png, true, 70, 70, false);
		botonQuit.x = 50;
		botonQuit.y = Reg.altoJuego - botonQuit.height;
		FlxG.state.add(botonQuit);
	}

	
}