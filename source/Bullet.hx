package;
//import flixel.input.mouse.FlxMouseEventManager;
//import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.math.FlxPoint;
/**
 * ...
 * @author ...
 */
class Bullet extends FlxSprite
{private var velocidadBala:Float;
	private var direccionX:Float;
	private var direccionY:Float;
	
	private  var proporcionX:Float;
	private var proporcionY:Float;
	private var distancia:Float;
	private var entitySprite:FlxSprite;
	public var danio:Int;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset,_direccionX:Float,_direccionY:Float,_velocidadBala:Float,_danio:Int,_proporcionX:Float,_proporcionY:Float,_targetPoint:FlxPoint) 
	{
		super(X, Y, SimpleGraphic);
		velocidadBala = _velocidadBala;
		danio = _danio;
		if(_targetPoint==null){
		direccionX = _direccionX;
		direccionY = _direccionY;
		proporcionX = _proporcionX;
		proporcionY = _proporcionY;
		}else{
				var aux:EntityPerseguir = new EntityPerseguir(this,_targetPoint);
				
				proporcionX = aux.CalculoProporcionX();
				proporcionY = aux.CalculoProporcionY();
				direccionX = aux.CalculoDireccionX();
				direccionY = aux.CalculoDireccionY();
			
		}
	MoverBala();
//	FlxMouseEventManager.add(this, onMouseDownBulletB,null, null, null); 
	
	}
		
	
	
		override public function update(elapsed:Float):Void
	
	{	
		
		super.update(elapsed);
			DestruccionBala();
	}

	public function MoverBala(){    
		this.velocity.x= velocidadBala*direccionX*proporcionX;
		this.velocity.y=velocidadBala * proporcionY*direccionY;
		
		 
		
		
	}
	private function DestruccionBala(){
		
		if (this.y<0||this.x+this.width<0){
	//trace("muerte bala");
		this.kill();		
			}
	
		
	}
		
	
}