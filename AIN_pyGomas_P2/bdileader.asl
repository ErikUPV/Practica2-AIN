//TEAM_AXIS

+flag (F): team(200)
  <-
  //.goto(F);
  .register_service("general");
  .asignarCoordenadas(F,P);
  +coordenadas_agentes(P);
  .get_service("general");
  // .wait(500);
  // .goto([112,0,136]);
  .nth(4,P,[X, Y, Z]);
  .print("Soy Lider. Me voy a ", [X, Y, Z]);
  .goto([X, Y, Z]);
  .print("VOY AL PUNTO", [X,Y,Z]).
  
  


+general(L)
  <-
  ?coordenadas_agentes(C);
  +enviar_destinos(L, C).


+enviar_destinos([Ag | L1], [C | L2]): .length(L1, Len1) & .length(L2, Len2) & Len1 > 1 & Len2 > 1
  <-
  .send(Ag, tell, ir_a(C));
  -enviar_destinos(_);
  +enviar_destinos(L1, L2).


