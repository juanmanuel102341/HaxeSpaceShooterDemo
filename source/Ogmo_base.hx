package;

import flash.geom.Point;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
/**
 * ...
 * @author juan manuel sala
 */
class Ogmo_base extends FlxSprite
{
	private var ogmo_Loader:FlxOgmoLoader;
	public var posiciones_A:Array<Point>;
	public var posiciones_B:Array<Point>;
	public var posiciones_C:Array<Point>;
	public var posicionPlayer:Point;
	public var entidades:Entity_base;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
	
	posiciones_A = new Array<Point>();
	posiciones_B = new Array<Point>();
	posiciones_C = new Array<Point>();
	posicionPlayer = new Point();
	ogmo_Loader = new FlxOgmoLoader("assets/data/l_pilot.oel");
	//ogmo_Loader = new FlxOgmoLoader("assets/data/pilot_2.oel");
	ogmo_Loader.loadEntities(entityCreator, "entidades");
	
	entidades= new Entity_base(posiciones_A,posiciones_B,posiciones_C,posicionPlayer);
	DeleteArrays();
	
	}
	
		private function entityCreator(entityName:String, entityData:Xml):Void
	{
		//	Parseo la X y la Y de cada entidad en el nivel de OGMO
		var entityStartX:Float = Std.parseFloat(entityData.get("x"));
		var entityStartY:Float = Std.parseFloat(entityData.get("y"));
		
		//	Me fijo qué tipo de entidad tengo que inicializar...
		switch(entityName)
		{
			//	...y creo la entidad y seteo sus cosillas.
			case "player":
			posicionPlayer = new Point();	
			posicionPlayer.x = entityStartX;
			posicionPlayer.y = entityStartY;
			trace("jugador " + posicionPlayer);
			//trace("x jugador " + entityStartX);
			case "enemy1":
			//	trace("e1");
			var aux:Point=new Point();
			aux.x = entityStartX;
			aux.y = entityStartY;
			posiciones_A.push(aux);
			
			trace("enemigo A" + aux);
			case "enemy2":
			//	trace("e1");
			var aux:Point=new Point();
			aux.x = entityStartX;
			aux.y = entityStartY;
			posiciones_B.push(aux);
			
			trace("enemigo B" + aux);
			
			case "enemy3":
			//	trace("e1");
			var aux:Point=new Point();
			aux.x = entityStartX;
			aux.y = entityStartY;
			posiciones_C.push(aux);
			
			trace("enemigo C" + aux);
			
			
				
		}
	
		
	 }
	 private function DeleteArrays(){
		 //for(i in 0...posiciones_A.length){
			 //
		 //}
		  trace("cantidad antes " + posiciones_A.length);
	 posiciones_A.splice(0, posiciones_A.length);
	 trace("cantidad " + posiciones_A.length);
	 
	 posiciones_B.splice(0, posiciones_B.length);
	posiciones_C.splice(0, posiciones_C.length);
	posiciones_A = null;
	posiciones_B = null;
	posiciones_C = null;
	 
	 
	 }
	
	
	
}