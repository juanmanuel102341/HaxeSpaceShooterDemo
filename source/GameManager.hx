package;

import flash.display.Sprite;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;
import flixel.FlxGame;
import flixel.system.FlxSound;
/** juan manuel sala
 * ...
 * @author ...
 */
class GameManager extends PlayState   
{
	private var fondo:FlxSprite;
	public var heroe:Player;
	private var numEnemy:Int=5;
	public var groupEnemy:FlxTypedGroup<Enemy_base>;
	private var timerGroup:FlxTimer;
	//private var finalGameTimer:FlxTimer;
	public var rateEnemy:Float = 1.5;
	private var ogmo:Ogmo_base;
	private var fondoSprite:FlxSprite;
	private var enemyContainerClass:Enemy_base;
	private var spawnPoint:Float; 
	private var gameOver:Bool = false;
	public var cantidadEnemyMuertos:Int = 0;
	private var screen:Screen;
	private var fg:FlxGame;
	private var claseSonido:Sonido;
	private var damage_sound:FlxSound;
	private var dead_enemy:FlxSound;
	
	
	
	public function new() 
	{
		trace("gma ");
		//mejor tratamiento de quiad trees (overlap) y eliminar listas cuando
		//el jugador gana o pierde
		//agregar pantalla win
		//reseteo juego
		super();
		FlxG.sound.destroy();
		fondo = new FlxSprite();
		fondo.loadGraphic(AssetPaths._fondo2__png);
		
		fondo.velocity.x =-Reg.scrollFondo;
		FlxG.state.add(fondo);
		
		///sonidos
		damage_sound = FlxG.sound.load(AssetPaths.hit__wav);
		dead_enemy = FlxG.sound.load(AssetPaths.explosion__wav);
		FlxG.sound.playMusic(AssetPaths.ambient__wav,0.5,true);
		
		trace("fondo  x "+fondo.x);
		ogmo = new Ogmo_base();
		
		groupEnemy = new FlxTypedGroup<Enemy_base>();
		groupEnemy = ogmo.entidades.ObtainGroupEnemy();
		trace(groupEnemy);
		
		heroe = ogmo.entidades.ObtainPlayer();
		//heroe.x = 50;
		//heroe.y = Reg.altoJuego / 2 - heroe.height / 2;
	
		spawnPoint = Reg.anchoJuego+Math.abs(fondo.x);
	
		FlxG.state.add(groupEnemy);
		FlxG.state.add(heroe);
		
		
	groupEnemy.kill();
		
	}
	
	override public function update(elapsed:Float):Void
	{
		
			super.update(elapsed);
	if(gameOver==false){	
	spawnPoint = Reg.anchoJuego+Math.abs(fondo.x);
	
	groupEnemy.forEachAlive(OnMove, false);
	
	groupEnemy.forEachDead(OnSpawn, false);	

	FlxG.overlap(heroe.groupBullet, groupEnemy, OnContact_enemy);
	FlxG.overlap(groupEnemy, heroe, OnContactHeroeEnemy);
	
	for (i in 0...groupEnemy.length){
		/// ffijarse de si se puede tratar mejor sin depende de lenght
		var aux:Enemy_base = groupEnemy.members[i];
	
		FlxG.overlap(aux.groupBulletEnemy, heroe,onContactBulletEnemyHeroe);
		//FlxG.overlap(aux, heroe, OnContactHeroeEnemy);
		
	}

	//trace("scroll x " + spawnPoint);
	
		if(heroe.vida<=0){
	//****************perdiste*********************	
			dead_enemy.play();
		
			heroe.Dead();
			trace("perdiste");
			groupEnemy.forEachAlive(OnReseteoEnemy, false);
			fondo.kill();
			heroe.Dead();
			gameOver = true;	
			screen = new Screen(0, 0);
			screen.ScreenLoose();
		}else if (cantidadEnemyMuertos >= groupEnemy.length) {
			
				trace("ganaste");		
				groupEnemy.forEachDead(OnDeadEnemyBullet, false);
				fondo.kill();
				heroe.Dead();
				gameOver = true;
				screen = new Screen(0, 0);
				screen.ScreenWin(); 
				
				}
			
	}else if (screen.eleccion_01){
			if (screen.Eleccion()){
				//**************replay*****************
				
				trace("jugando de nuevo desde maain");
				screen.Dead();
				fondo.revive();
				fondo.x = 0;
				fondo.y = 0;
				
				heroe.revive();
				heroe.PosInicial();//reseteo posicion
				heroe.vida = Reg.vidaHeroe;
				heroe.healthBar.revive();
				heroe.healthBar.x = heroe.x;
				heroe.healthBar.y = heroe.y;
				
				//groupEnemy.revive();
				groupEnemy.forEachDead(OnRespawn, false);
				gameOver = false;//q empiece el juego
				screen.eleccion_01 = false;
				cantidadEnemyMuertos = 0;
		
			}else{
				//***********quit***************
			
				trace("quit desde main");
				screen.Dead();
				fondo.destroy();
				heroe.destroy();
			
				Sys.exit(1);
		
				
			}
			
		}
	}
	private function OnMove(obj:Enemy_base){
	obj.ObtainPlayerPosition(heroe.getPosition());
	obj.Move();
	trace("cantidad enemigos " + groupEnemy.length);
	trace("enemigos muertos " + cantidadEnemyMuertos);
	if (obj.Limit()){
		trace("limite muerte");
	cantidadEnemyMuertos++;	
		
	}
	
	}

	private function OnSpawn(obj:Enemy_base){
		//trace("auxPosFondo " + auxPosFondo);	
	//trace("obj x" + obj.x);
	//trace("auxpos " +Reg.anchoJuego );
		if (obj.x <= spawnPoint&&!obj.dead_really){
			//aparecen donde estan en teoria
			trace("enemy " + obj.x);	
			trace("spawnPoint " + spawnPoint);
			//trace("enemigo accion ");
			obj.revive();
			obj.render = true;
			FlxG.state.add(obj);
		}	
		
	}
	///******************************contactos********************************************* 
		private function OnContact_enemy(obj_bala:Bullet,obj_enemigo:Enemy_base){
		obj_bala.kill();
		obj_enemigo.vida -= obj_bala.danio;
		if (obj_enemigo.vida <= 0){
		 	dead_enemy.play();
			cantidadEnemyMuertos++;
			obj_enemigo.Dead();
		}else{
			
			damage_sound.play();
		}
	}
	private function onContactBulletEnemyHeroe(obj_bullet:Bullet,objHeroe:Player){
		trace("contactoooo a jugador");
		trace("danio " + obj_bullet.danio);
		trace("vida player " + objHeroe.vida);
		damage_sound.play();
		obj_bullet.kill();
		objHeroe.vida -= obj_bullet.danio;
	}

	private function OnContactHeroeEnemy(obj_enemy:Enemy_base,obj_p:Player){
		trace("contacto materia");
			dead_enemy.play();
			cantidadEnemyMuertos++;
			obj_p.vida -=obj_enemy.damage;
			obj_enemy.Dead();
		}
	private function OnReseteoEnemy(obj:Enemy_base){
		if (obj.groupBulletEnemy.countLiving()>0){
			obj.groupBulletEnemy.kill();
		}
		obj.Dead();
	}
	private function OnRespawn(obj:Enemy_base){
		obj.ResSpawn();//respawniamos a la pos inicial
		obj.Inicio();
		obj.Eventos();
	}
	private function OnDeadEnemyBullet(obj:Enemy_base){
		
		if(obj.groupBulletEnemy.countLiving()>0){
			trace("muerte balas");
			obj.groupBulletEnemy.kill();
		//obj.groupBulletEnemy.destroy();
		}
	}

	
}