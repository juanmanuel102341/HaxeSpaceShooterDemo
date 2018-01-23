package;
import flash.display.Loader;
import flash.display.MovieClip;
import flash.net.URLRequest;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.math.FlxMath;
import flixel.util.FlxTimer;
import flixel.FlxG;
import flixel.ui.FlxBar;
/**
 * ...
 * @author juan manuel sala
 */
class Kamikace extends Enemy_base
{
	//private var posxJugador:Float;
	//private var posyJugador:Float;
	private var propX:Float;
	private var propY:Float;
	private var distancia_jugador:Int;
	
	private var distanciaLimite:Int = 300;// distancia en q el enemigo se activa
	//private var velocity:Float;
	private var direccionY:Int;
	private var calculoFin:Bool = false;
	private var persecucionActiva:Bool = false;
//	private var tiempoPersecuta:FlxTimer;
//	private var _load:Loader;
	//private var _url:URLRequest;
	public function new(_posX:Float,_posY:Float,_vida:Int,_damage:Int,_velocity_enemy:Float,_grafic:FlxGraphicAsset) {
				super(x, y,_grafic);
			//reptil
		
			 posX = _posX;
			posY = _posY;
		//	vida_inicio = _vida;
		
			 damage = _damage;
			 velocity_enemy = _velocity_enemy;
			//grafic = _grafic;
			setPosition(posX, posY);
			loadGraphic(_grafic);
			vida = _vida;
		
			propX = 1;//mov rectilineo
			propY = 0;
			direccionY = 1;
		
			var ancho:Int =Math.round( this.width)-10;
			guiVida = new FlxBar(0, 0, FlxBarFillDirection.LEFT_TO_RIGHT,ancho , 2, this, "vida", 0, vida, false);
			guiVida.x = this.x;
			guiVida.y = this.y-2;
			
			FlxG.state.add(guiVida);
			
			Inicio();
			Eventos();
		
		
			
		
	}
	
	public override function Eventos(){
trace("eventos kamikaze");
	}
 	public override function Inicio(){
	
	dead_really = false;
	render = false;
	persecucionActiva = true;
	if(!guiVida.alive){
		guiVida.revive();
		guiVida.x = this.x;
		guiVida.y = this.y - 2;
	}
	}
	public override function Move() 
	{
	guiVida.x = this.x;
	guiVida.y = this.y-2;
	this.x -= velocity_enemy * propX;//siempre -
	this.y += velocity_enemy * propY*direccionY;
	

	
	CalculoMomentoRectilineo();
	if(persecucionActiva){
	Persiguiendo();
	}else{
		Rectilineo();
	}
//	trace("fin "+explosion.animation.finished);
	
	}
	
	
	public override function Dead() 
	{
	
		trace("dead A kamikaze");
		
		guiVida.kill();
	 if(!explosion.alive){
		explosion.revive();
			}
		explosion.x = this.x;
		explosion.y = this.y;
	
		explosion.animation.play("explosion_01");
		
		//animation.play("explosion_01");
		FlxG.state.add(explosion);
		timeFinExplosion = new FlxTimer();
		timeFinExplosion.start(1.5, OnfinExplosion, 1);
		
	//	tiempoPersecuta.cancel();
		//tiempoPersecuta.destroy();
		dead_really = true;
		this.kill();
		
	}

	private function CalculoProporcionX():Float{
		//parte x 
		var proporcionX:Float;
	//trace("posx jugador " + posPlayer.x);
		proporcionX = (this.x - posPlayer.x)/distancia_jugador;
	//	trace("prop x "+proporcionX);
		
		return proporcionX = Math.abs(proporcionX);
		
	}
	
	private function CalculoProporcionY():Float{
		var proporcionY:Float;
		
		proporcionY = (this.y - posPlayer.y) / distancia_jugador;
		//trace("prop y " + proporcionY); 
		return proporcionY = Math.abs(proporcionY);
	}
	
	private function CalculoDireccionX():Int{
	var direccion:Int;
		if(this.x>posPlayer.x){
		return direccion = -1;
		}else if(this.x<posPlayer.x){
			return direccion =1;
		}else{
			return direccion = 0;
		}
					
	}
	private function CalculoDireccionY():Int{
	var direccion:Int;
		if(this.y>posPlayer.y){
		return direccion = -1;
		}else if(this.y<posPlayer.y){
			return direccion =1;
		}else{
			return direccion = 0;
		}
					
	}
	private function CalculoDistanciaPlayer():Int{
		
	//	trace("distancia");
		//	trace("pos player " + posPlayer);
		var n:Int=FlxMath.distanceToPoint(this,posPlayer);
	//	trace("distancia " + n );
		return n;
	}
	private function CalculoMomentoRectilineo():Void{
		//xra q jugador pueda esquivarlo
		//criterio distancia
		if(CalculoDistanciaPlayer()<80){
		trace("render a");

	persecucionActiva = false;
		}
			
	}
	private function OnComplete(t:FlxTimer){
		trace("persiguiendo!!!!!!!!!!!!!!!!!!");
		persecucionActiva = true;	
		
		
	}
	private function Persiguiendo(){
		
		distancia_jugador = CalculoDistanciaPlayer();
		propX =CalculoProporcionX();
		propY = CalculoProporcionY();
		direccionY =CalculoDireccionY();	
		
	}
	private function Rectilineo(){
	propX = 1;//mov rectilineo
	propY = 0;
	direccionY = 1;
	}
	private function OnfinExplosion(t:FlxTimer){
		trace("fin explosion");
		
		explosion.kill();
	timeFinExplosion.destroy();
		
	}
	
	
}