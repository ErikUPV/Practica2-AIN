//TEAM_AXIS

+flag (F): team(200) 
  <-
  ?position(Pos);
  .goto(Pos);
  .register_service("medics");
  +recibidos(0).

+escuadron(N): N = 1
  <-
  .print("Soy escuadron MEDICO 1");
  .register_service("escuadron1").

+escuadron(N): N = 2
  <-
  .print("Soy escuadron MEDICO 2");
  .register_service("escuadron2").

+med_go(Pos): recibidos(N) & N = 0
  <-
  .goto(Pos);
  .wait(4000);
  -+recibidos(0).


+ir_a(Pos)
  <-
  .print("Soy Medic, Voy a ", Pos);
  +mi_destino(Pos);
  +patrullando;
  .goto(Pos).

+target_reached(T): patrullando & team(200) 
  <-
  .print("MEDPACK!");
  .cure.


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
  .cure;
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