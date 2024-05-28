//TEAM_AXIS

+flag (F): team(200)
  <-
  .register_service("axis");
  .wait(1000);
  .get_service("axis");
  .asignarCoordenadas(P);
  .nth(5,P,PL);
  .goto(PL);
  .print("Soy Lider. Me voy a ", PL).


+target_reached(T): patrolling & team(200)
  <-
  ?patroll_point(P);
  -+patroll_point(P+1);
  -target_reached(T).

+patroll_point(P): total_control_points(T) & P<T
  <-
  ?control_points(C);
  .nth(P,C,A);
  .goto(A).

+patroll_point(P): total_control_points(T) & P==T
  <-
  -patroll_point(P);
  +patroll_point(0).