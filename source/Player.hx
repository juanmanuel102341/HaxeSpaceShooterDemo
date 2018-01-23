package;
import flash.media.Sound;
import flash.utils.Timer;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.ui.FlxBar;
import flixel.system.FlxSound;
/**
 * ...
 * @author ...
 */
class Player extends FlxSprite
{
	public var groupBullet:FlxTypedGroup<Bullet>;
	
	private var bulletVelocity:Float = 600;
	private var timerBullet:FlxTimer;
	private var fireRate:Float = 0.2;
	private var activateFire:Bool ;
	private var numBullet:Int = 15;
	public var vida:Int;
	public var healthBar:FlxBar;
	private var soundShoot:FlxSound;
	private var deadSound:FlxSound;
	
	
	public function new(?X:Float=0, ?Y:Float=0,?SimpleGraphic:FlxGraphicAsset) 
	{
		
		super(x, y,SimpleGraphic);
		soundShoot = FlxG.sound.load(AssetPaths.shoot__wav);
		
		deadSound = FlxG.sound.load(AssetPaths.dead_h__wav);
		loadGraphic(AssetPaths._h__png);
		PosInicial();	
		vida = Reg.vidaHeroe;
		groupBullet = new FlxTypedGroup<Bullet>(numBullet);
		var ancho:Int =Math.round( this.width);
		healthBar = new FlxBar(0, 0, FlxBarFillDirection.LEFT_TO_RIGHT,ancho , 2, this, "vida", 0, vida, false);
		healthBar.x = this.x;
		healthBar.y = this.y;
		CreateGroupBullet();
		groupBullet.kill();
		activateFire = true;
		timerBullet = new FlxTimer();
	
		
		FlxG.state.add(healthBar);	
		
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	
		Movimiento();
	
		healthBar.x = this.x;
		healthBar.y = this.y;
	
	//	trace("barra energia " + healthBar.getPosition());
	}
	public function PosInicial(){
		this.setPosition(50, Reg.altoJuego/2 - this.height);
	}
	
	
	private function Movimiento(){
		
		TeclasPush();
		
		TeclasUp();
	
	
			
	}
	private function TeclasPush(){
		if (FlxG.keys.pressed.LEFT){
			
			//trace("izquierda");
		
			velocity.x =- Reg.velocity;
					
		}else if(FlxG.keys.pressed.RIGHT){
			//trace("derecha");
		velocity.x = Reg.velocity;
			
		}
	
	if(FlxG.keys.pressed.UP){
			
	velocity.y =-Reg.velocity;
		
	}else if(FlxG.keys.pressed.DOWN){
	
		velocity.y = Reg.velocity;
		
	}
		
	if(FlxG.keys.justPressed.SPACE&&activateFire){
		//trace("disparo");
		
		soundShoot.play();
		activateFire = false;
		
		//FlxG.state.add(auxDisparo);	
		var aux:Bullet = groupBullet.recycle();
		aux.x = this.x + this.width ;
		aux.y = this.y+this.height/2;
		groupBullet.add(aux);
		timerBullet.start(fireRate, OnFireActivate, 1);
	   FlxG.state.add(aux);
		
	}
	
	}
	private function TeclasUp(){
	if (FlxG.keys.justReleased.LEFT||FlxG.keys.justReleased.RIGHT||this.x<0&&!FlxG.keys.pressed.RIGHT||this.x+this.width>Reg.anchoJuego&&!FlxG.keys.pressed.LEFT){
	velocity.x = 0;
		}
	if (FlxG.keys.justReleased.UP || FlxG.keys.justReleased.DOWN||this.y-healthBar.height-5<0&&!FlxG.keys.pressed.DOWN||this.y+this.height>Reg.altoJuego&&!FlxG.keys.pressed.UP){
			
		velocity.y = 0;
	
		
	}
	}
	private function OnFireActivate(t:FlxTimer){
		
		activateFire = true;
	}
	private function CreateGroupBullet(){
		for(i in 0...numBullet){
			var auxDisparo:Bullet = new Bullet(this.x + this.width, this.y+this.height/2, AssetPaths.bullet_1__png, 1, 0, bulletVelocity,Reg.danioBalasHeroe,1,0,null);
			groupBullet.add(auxDisparo);
			
		}
		
	}
	
	public function Dead(){
		
		//timerBullet.cancel();
		//timerBullet.destroy();
		//groupBullet.destroy();
		deadSound.play();
		velocity.x = 0;//para q n se mueva si juega d nuevo 
		velocity.y = 0;//idem
		healthBar.kill();
		this.kill();
		
	}
	
	
	
	
}