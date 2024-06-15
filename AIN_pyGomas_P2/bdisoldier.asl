//TEAM_AXIS

+flag (F): team(200)
  <-
  // .create_control_points(F,25,3,C);
  // +control_points(C);
  // .length(C,L);
  // +total_control_points(L);
  // +patrolling;
  // +patroll_point(0);
  // .print("Got control points");
  // .wait(500);
  +ammo_points([]);
  .register_service("general");
  .getBaseEnemiga(F,P);
  +base_enemiga(P);
  .get_service("general");
  .wait(500);
  .get_service("lider").


+general(L)
  <-
  .print("Estoy en general", L).

+ir_a(Pos)
  <-
  .print("Soy soldier, Voy a ", Pos);
  +mi_destino(Pos);
  +patrullando;
  .goto(Pos).

+target_reached(T): patrullando & soy_esc1
  <-
  ?flag(F);
  -patrullando;
  .print("Soy esc1, miro base enemiga", B);
  
  .look_at(F).

+lider([Ag | L])
  <-
  ?base_enemiga(P);
  .send(Ag, tell, base_enemiga(P)).

+target_reached(T): patrullando & soy_esc2
  <-
//  ?flag(F);
//  .look_at(F)
  .print("Soy esc2, voy a base enemiga");
  ?flag(F);
  ?base_enemiga(B);
  .randomPointAround(B, Point);
  .goto(Point);
  ?mi_medico(Ag);
  .send(Ag,tell,med_go(Point));
  -+mi_destino(Point);
  .look_at(B);
  +a_base_enemiga.

+ammo(A): A<10 & not needammo
  <-
  .print("NECESITO AMMO");
  +needammo.
+health(H): H<30 & not needhealth
  <-
  .print("NECESITO CURA");
  +needhealth.


+paquete_en(P)
  <-
  -+ammo_point(P).



+packs_in_fov(ID,Type,Angle,Distance,Health,Position): Type == 1002 & needammo
  <-
  .goto(Position);
  -needammo;
  +gettingammopack.
+packs_in_fov(ID,Type,Angle,Distance,Health,Position): Type == 1001 & needcure
  <-
  .goto(Position);
  -needcure;
  +gettingmedipack.

+gettingammopack
  <-
  ?flag(F);
  .getBaseEnemiga(F,B);
  .goto(B).

+needammo
  <-
  .print("Hay ammo en P? quien sabe");
  ?ammo_point(P);
  .goto(P);
  .wait(5000);
  -needammo.

+medpack(P)
  <-
  .print("Hay una cura, me la guardo", P);
  +cura_en(P).

+needhealth
  <-
  ?cura_en(P);
  -needhealth;
  .goto(P);
  .wait(5000).
  

+friends_in_fov(ID,Type,Angle,Distance,Health,Position)
  <-
  +hay_aliados_en_fov.

-friends_in_fov(ID,Type,Angle,Distance,Health,Position)
  <-
  -hay_aliados_en_fov.


+enemies_in_fov(ID,Type,Angle,Distance,Health,Position): soy_esc2 & ammo(A) & A > 0
  <-
  .shoot(3,Position);
  .goto(Position);
 // .print("DISPAROO!");
  +shooting.

  +enemies_in_fov(ID,Type,Angle,Distance,Health,Position): soy_esc1 & ammo(A) & A > 0
  <-
  .shoot(3,Position); // .print("DISPAROO!");
  +shooting.

+target_reached(T): shooting
  <-
  -shooting;
  ?mi_destino(P);
  .goto(P).

+enemies_in_fov(ID,Type,Angle,Distance,Health,Position): flag_taken
  <-
  .getBaseEnemiga(F,B);
  .goto(B);
  .print("SIGUIENDO A LA BANDERA").


//  -+siguiendo(2000).

+escuadron(N): N = 1
  <-
  .wait(1000);
  .get_service("escuadron1").

+escuadron(N): N = 2
  <-
  .wait(1000);
  .get_service("escuadron2").

+escuadron1([Ag | L])
  <-
  +mi_medico(Ag);
  ?mi_destino(D);
  .print("Soy escuadron 1 y voy a", D);
  +soy_esc1;
  .register_service("escuadron1");
  .send(Ag, tell, med_go(D)).

+escuadron2([Ag | L])
  <-
  +mi_medico(Ag);
  ?mi_destino(D);
  .wait(10000);
  .print("Soy escuadron 2 y voy a",D);  
  +soy_esc2;
  .register_service("escuadron2");
  .send(Ag, tell, med_go(D)).


+target_reached: shooting
  <-
  -shooting;
  +volver_patrullar.

+volver_patrullar
  <-
  -volver_patrullar;
  ?mi_destino(Pos);
  .goto(Pos);
  +patrullando.

+go_base_enemiga
  <-
  ?flag(F);
  .print("JEFE MUERTO, HAY QUE IR A BASE ENEMIGA");
  .getBaseEnemiga(F,B);
  .randomPointAround(B,Point);
  -patrullando;
  .goto(Point).


// +target_reached(T): patrolling & team(200)
//   <-
//   ?patroll_point(P);
//   -+patroll_point(P+1);
//   -target_reached(T).

// +patroll_point(P): total_control_points(T) & P<T
//   <-
//   ?control_points(C);
//   .nth(P,C,A);
//   .goto(A).

// +patroll_point(P): total_control_points(T) & P==T
//   <-
//   -patroll_point(P);
//   +patroll_point(0).


//TEAM_ALLIED

+flag (F): team(100)
  <-
    
  .goto(F).

+flag_taken: team(100)
  <-
  .print("In ASL, TEAM_ALLIED flag_taken");
  ?base(B);
  +returning;
  .goto(B);
  -exploring.
  
+heading(H): exploring
  <-
  .wait(2000);
  .turn(0.375).

//+heading(H): returning
//  <-
//  .print("returning").

+target_reached(T): team(100)
  <-
  .print("target_reached");
  +exploring;
  .turn(0.375).

+enemies_in_fov(ID,Type,Angle,Distance,Health,Position): team(100)
  <-
  .shoot(3,Position).