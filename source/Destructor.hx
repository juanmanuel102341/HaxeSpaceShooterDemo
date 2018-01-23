package;
import flash.desktop.Clipboard;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.math.FlxPoint;
import flixel.math.FlxAngle;
import flixel.util.FlxTimer;
import flixel.FlxG;
import flixel.ui.FlxBar;
/**
 * ...
 * @author juan manuel sala
 */
class Destructor extends Enemy_base
{
   public var posInicialY:Float;
	
	
	private var propX:Float;
	private var propY:Float;
	private var direccionY:Int;
	
	public function new(_posX:Float,_posY:Float,_vida:Int,_damage:Int,_velocity_enemy:Float,_grafic:FlxGraphicAsset) 
	{//***************************************lenta*******************
		 super(x,y,_grafic);
	posX = _posX;
	posY = _posY;
//	vida_inicio = _vida;
	 
	 damage = _damage;
	 velocity_enemy = _velocity_enemy;
	//grafic = _grafic;
	setPosition(posX, posY);
	loadGraphic(_grafic);
	direccionY = 1;	
	//this.angle = -10;
	propX = 1;
	propY = 0.5;
	vida = _vida;
	var ancho:Int =Math.round( this.width)-10;
	
	guiVida = new FlxBar(0, 0, FlxBarFillDirection.LEFT_TO_RIGHT,ancho , 2, this, "vida", 0, vida, false);
	guiVida.x = this.x;
	guiVida.y = this.y-2;
		FlxG.state.add(guiVida);
	
	Inicio();
	Eventos(); 
	
	
	
	}
	public override function Eventos(){
	timeFireRate = new FlxTimer();
	timeFireRate.start(Reg.fireRate_destructor, OnFire, 0);
	}
 	public override function Inicio(){
	dead_really = false;
	
	render = false;
	
	if(!guiVida.alive){
			guiVida.revive();
			guiVida.x = this.x;
			guiVida.y = this.y - 2;
		}
			
			
	}	
	

	public override function Move() 
	{
		guiVida.x = this.x;
		guiVida.y = this.y-3;
		this.x -= velocity_enemy*propX;
		this.y += velocity_enemy*propY*direccionY;
		
		if(this.y+this.height+100>Reg.altoJuego){
			direccionY =-1;
		}
		if(this.y-200<0){
			direccionY = 1;
		}
			
		//trace("enemy move C "+velocity_enemy);
	}
	

	public override function Dead() 
	{
		
		guiVida.kill();
	if(!explosion.alive){
		explosion.revive();
			}
		explosion.x = this.x;
		explosion.y = this.y;
		
		
		explosion.animation.play("explosion_01");
		//animation.play("explosion_01");
		FlxG.state.add(explosion);
		dead_really = true;
		
		timeFinExplosion = new FlxTimer();
		timeFinExplosion.start(1.5, OnfinExplosion, 1);
		
		timeFireRate.cancel();
		//timeFireRate.destroy();
		
		this.kill();
		
	}
	private function OnFire(t:FlxTimer){
	//	trace("disparo enemy c");
	if(render&&this.x+this.width<=Reg.anchoJuego&&this.x>posPlayer.x){
	var aux:Bullet = new Bullet(this.x, this.y, AssetPaths.bullet_enemy_jms__png, -1, 0, 100,damage, 1, 0,posPlayer);
		
			FlxG.state.add(aux);	
		groupBulletEnemy.add(aux);
	
		}
		
		
	}
	private function OnfinExplosion(t:FlxTimer){
		trace("fin explosion destructor");
		
		explosion.kill();
	timeFinExplosion.destroy();
		
	}
	 
}