package;

import flash.geom.Point;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.group.FlxGroup.FlxTypedGroup;
/**
 * ...
 * @author juan manuel sala
 */
class Entity_base extends FlxSprite
	{
	private var posPlayer:Point;
	private var listaPos_A:Array<Point>;
	private var listaPos_B:Array<Point>;
	private var listaPos_C:Array<Point>;
	public var grupoEnemigos:FlxTypedGroup<Enemy_base>;
	
	private var cantidadEnemy:Int;
	public function new(_listaPos_A:Array<Point>,_listaPos_B:Array<Point>,_listaPos_C:Array<Point>,_posPlayer:Point) 
	{
		super();
		listaPos_A = _listaPos_A;
		listaPos_B = _listaPos_B;
		listaPos_C = _listaPos_C;
		posPlayer = _posPlayer;
		cantidadEnemy = listaPos_A.length + listaPos_B.length + listaPos_C.length;
		trace("cantidad enemy " + cantidadEnemy);
		grupoEnemigos = new FlxTypedGroup<Enemy_base>(cantidadEnemy);
		
		Entidad_destructor();
		Entidad_kamikace();
		Entidad_ondulante();
		DeleteArrays();
		 
	}
	private function Entidad_destructor(){
	//	var auxIt: = listaPos_A.iterator;
	for (i in 0...listaPos_A.length){
		
		
	
			var aux_p:Point = listaPos_A[i];
		//*******************mast	
			
			var aux:Destructor = new Destructor(aux_p.x,aux_p.y,Reg.vida_destructor,30, 2, AssetPaths._est_1__png);
			
			grupoEnemigos.add(aux);	
	}		
		
	}
	private function Entidad_kamikace(){
		for (i in 0...listaPos_B.length){
		
		//********************ondulante
	
			var aux_p:Point = listaPos_B[i];
			
			//Enemy_B (_posX:Float, _posY:Float, _vida:Int, _damage:Int, _velocity_enemy:Float, _grafic:FlxGraphicAsset)
			var aux:Kamikace = new Kamikace(aux_p.x,aux_p.y,Reg.vida_kamikace,15,6, AssetPaths._rept_1__png);
			
			grupoEnemigos.add(aux);	
	}		
	}
	private function Entidad_ondulante(){
		for (i in 0...listaPos_C.length){
		
		
	//***************************mastodonte
			var aux_p:Point = listaPos_C[i];
			
			
			var aux:Ondulante = new Ondulante(aux_p.x,aux_p.y,Reg.vida_ondulante, 15, 4, AssetPaths._est_3__png);
			
			grupoEnemigos.add(aux);	
	}	
	}
	public function ObtainGroupEnemy():FlxTypedGroup<Enemy_base>{
		
		return grupoEnemigos;
	}
	public function ObtainPlayer():Player{
		var auxPlayer:Player = new Player();
		return auxPlayer;
		}
		private function DeleteArrays(){
		 //for(i in 0...posiciones_A.length){
			 //
		 //}
		  trace("cantidad antes " + listaPos_A.length);
	 listaPos_A.splice(0, listaPos_A.length);
	 trace("cantidad " + listaPos_A.length);
	 
	 listaPos_B.splice(0, listaPos_B.length);
	listaPos_C.splice(0, listaPos_C.length);
	listaPos_A = null;
	listaPos_B = null;
	listaPos_C = null;
	 
	 
	 }
		
	
}