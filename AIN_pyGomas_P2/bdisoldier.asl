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
  .register_service("general");
  .get_service("general").


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
  .getBaseEnemiga(F, B);
  +base_enemiga(B);
  -patrullando;
  .print("Soy esc1, miro base enemiga", B);
  .get_service("lider");
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
  .getBaseEnemiga(F, B);
  .randomPointAround(B, Point);
  .goto(Point);
  -patrullando;
  .look_at(B);
  +a_base_enemiga.



+enemies_in_fov(ID,Type,Angle,Distance,Health,Position): soy_esc1
  <-

  .shoot(3,Position);
 // .print("DISPAROO!");
  +shooting.

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
  
  ?mi_destino(D);
  .print("Soy escuadron 1 y voy a", D);
  +soy_esc1;
  .send(Ag, tell, med_go(D)).

+escuadron2([Ag | L])
  <-

  ?mi_destino(D);
  .print("Soy escuadron 2 y voy a",D);  
  +soy_esc2;
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

+enemies_in_fov(ID,Type,Angle,Distance,Health,Position)
  <-
  .shoot(3,Position).