package;

/**
 * ...
 * @author juan manuel sala
 */

import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.math.FlxMath;
class EntityPerseguir
{
	private var entity:FlxSprite;
	private var entityTarget:FlxPoint;
	private var distancia:Float;
	public function new(_entity:FlxSprite,_entityTarget:FlxPoint) 
	{
		entity = _entity;
		entityTarget = _entityTarget;
		distancia=CalculoDistancia();
	}
		public function CalculoProporcionX():Float{
		
		//parte x 
		var proporcionX:Float;
	
		proporcionX = (entity.x - entityTarget.x)/distancia;
		trace("prop x "+proporcionX);
		
		return proporcionX = Math.abs(proporcionX);
		
	}
	
	public function CalculoProporcionY():Float{
		var proporcionY:Float;
		
		proporcionY = (entity.y - entityTarget.y) / distancia;
		trace("prop y " + proporcionY); 
		return proporcionY = Math.abs(proporcionY);
	}
	
	public function CalculoDireccionX():Int{
	var direccion:Int;
		if(entity.x>entityTarget.x){
		return direccion = -1;
		}else if(entity.x<entityTarget.x){
			return direccion =1;
		}else{
			return direccion = 0;
		}
					
	}
	public function CalculoDireccionY():Int{
	var direccion:Int;
		if(entity.y>entityTarget.y){
		return direccion = -1;
		}else if(entity.y<entityTarget.y){
			return direccion =1;
		}else{
			return direccion = 0;
		}
					
	}
	public function CalculoDistancia():Int{
		
		trace("distancia");
		
		var n:Int=FlxMath.distanceToPoint(entity,entityTarget);
		trace("distancia " + n );
		return n;
	}
	
}