package;
import flash.display.MovieClip;
import flash.geom.Point;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.effects.chainable.FlxOutlineEffect.FlxOutlineMode;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxTimer;
import flash.display.DisplayObject;
import flixel.ui.FlxBar;
/**
 * ...
 * @author juan manuel sala
 */

 class Enemy_base extends FlxSprite{
	
	 
	 var posX:Float;
	 var posY:Float;
	
	
	var velocity_enemy:Float;
	//var grafic:FlxGraphicAsset;
	public var posPlayer:FlxPoint;
	public var groupBulletEnemy:FlxTypedGroup<Bullet>;
	
	private var timeFireRate:FlxTimer;
	private var timeFinExplosion:FlxTimer;
	
	public var damage:Int;
	public var vida:Int;
	public var dead_really:Bool = false;
	public var render:Bool = false;
	private var explosion:FlxSprite;
	private var guiVida:FlxBar;
	//private var vida_inicio:Int;
	
	public function new(?X:Float=0, ?Y:Float=0,?SimpleGraphic:FlxGraphicAsset) {
			 super(x,y);
			 groupBulletEnemy = new FlxTypedGroup<Bullet>();
			
			 explosion = new FlxSprite();
			explosion.loadGraphic(AssetPaths.sprites_Expl__png, true, 50, 50, false);
		 explosion.animation.add("explosion_01", [0, 1, 2, 3, 4, 5, 6, 7], 9,false);
			posPlayer = new FlxPoint();
		
	}
	
	public function ResSpawn(){
	//	FlxG.state.add(grafic);
	setPosition(posX, posY);
	
	}
	public function Inicio(){
		trace("inicio papa");
	}
	public function Eventos(){
		trace("eventos papa");
	}	
	
	public function Move(){}
		
		
	
	public function Dead(){
		trace("muerte basse");
		
		
	}
	public function ObtainPlayerPosition(_p:FlxPoint){
		posPlayer = _p;
	}
	public function Limit():Bool{
		if(this.x+this.width<0){
		//trace("killllllll");
			//this.kill();
			Dead();
		return true;	
	}
	return false;
	}
	//public function ObtainCantidadEnemy():Int{
		//
		//
	//}
	//
		
	

}
