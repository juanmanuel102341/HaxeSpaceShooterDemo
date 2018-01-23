package;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxTimer;
import flixel.FlxG;
import flixel.ui.FlxBar;
/**
 * ...
 * @author juan manuel sala
 */
class Ondulante extends Enemy_base
{
	private var propX:Float =0.7;//achato parabola 
	private var propY:Float =0.8;//subo parabola
	public var posInicialY:Float;
	private var acumulativoGravedad:Float = 0.0;
	private var gravedad:Float = 1.2;
	private var timerGravedad:FlxTimer;
	
	public function new(_posX:Float,_posY:Float,_vida:Int,_damage:Int,_velocity_enemy:Float,_grafic:FlxGraphicAsset) 
	{//**************************saltarin*********************************
	 super(x,y,_grafic);
			posX = _posX;
			posY = _posY;
		//	vida_inicio = _vida;
			
			damage = _damage;
			 velocity_enemy = _velocity_enemy;
		//	grafic = _grafic;
			setPosition(posX, posY);
			loadGraphic(_grafic);
		
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
		timerGravedad = new FlxTimer();
	timerGravedad.start(0.1, OnGravedad, 0);
	timeFireRate.start(Reg.FireRate_ondulante, OnFire,0);
	}
	public override function Inicio(){

		dead_really = false;
		posInicialY = this.y;
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
		guiVida.y = this.y-5;
		this.x -=velocity_enemy*propX;
		this.y -= velocity_enemy*propY;
		this.y += acumulativoGravedad;
		
		
		if (this.y > posInicialY){
			trace("entrando");
			acumulativoGravedad = 0;
		}

	}
	
	public override function Dead() 
	{if(!explosion.alive){
		explosion.revive();
			}

		explosion.x = this.x;
		explosion.y = this.y;
		
		guiVida.kill();
		
		explosion.animation.play("explosion_01");
		//animation.play("explosion_01");
		FlxG.state.add(explosion);
		
		timeFinExplosion = new FlxTimer();
		timeFinExplosion.start(1.5, OnfinExplosion, 1);
		
		dead_really = true;
		
	
		timeFireRate.cancel();
		timerGravedad.cancel();
		
		this.kill();
	}
	private function OnFire(t:FlxTimer){
		if(render&&this.x+this.width<=Reg.anchoJuego&&this.x>posPlayer.x)
	{
	trace("disparo b");
		var aux:Bullet = new Bullet(this.x, this.y, AssetPaths.bullet_enemy_jms__png, -1, 0,450,damage, 1, 0,null);//ultimoparametro si es null bala mantiene valor proporciones n sigue a nadie
			
		FlxG.state.add(aux);	
		groupBulletEnemy.add(aux);
	
	}	
	}
	private function OnGravedad(t:FlxTimer){
		acumulativoGravedad += gravedad;
	}
	private function OnfinExplosion(t:FlxTimer){
		trace("fin explosion ondulante");
		
		explosion.kill();
	timeFinExplosion.destroy();
		
	}
}