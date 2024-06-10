//TEAM_AXIS

+flag (F): team(200)
  <-
  //.goto(F);
  .register_service("general");
  .asignarCoordenadas(F,P);
  +coordenadas_agentes(P);
  // .wait(500);
  // .goto([112,0,136]);
  .nth(9,P,[X, Y, Z]);
  .print("Soy Lider. Me voy a ", [X, Y, Z]);
  .goto([X, Y, Z]);
  .wait(2000);
  .get_service("general");
  .get_medics

+myMedics([M1, M2]): team(200)
  <-
  send(M1, tell, escuadron(1))
  send(M2, tell, escuadron(2))
  
  
+enemies_in_fov(ID,Type,Angle,Distance,Health,Position): not shooting
  <-
  -patrullando;
  .shoot(3,Position);
  .look_at(Position);
  .goto(Position);
  +shooting;
  +siguiendo.

+general(L): team(200)
  <-
  ?coordenadas_agentes(C);
  .wait(500);
  .print("Voy a enviar destinos", L, C);
  .length(L,Pito);
  .print(Pito);
  +enviar_destinos(L, C).


+enviar_destinos([Ag | L1], [C | L2]): .length(L1, Len1) & .length(L2, Len2) & Len1 > 4 & Len2 > 4
  <-
  .print("Envio destino ", Ag, C);
  .send(Ag, tell, ir_a(C));
  .send(Ag, tell, escuadron(1))
  -enviar_destinos(_);
  +enviar_destinos(L1, L2).

+enviar_destinos([Ag | L1], [C | L2]): .length(L1, Len1) & .length(L2, Len2) & Len1 <= 4 & Len2 <= 4
  <-
  .print("Envio destino ", Ag, C);
  .send(Ag, tell, ir_a(C));
  .send(Ag, tell, escuadron(2))
  -enviar_destinos(_);
  +enviar_destinos(L1, L2).





