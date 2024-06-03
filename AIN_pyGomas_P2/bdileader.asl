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
  .get_service("general").

  
  


+general(L): team(200)
  <-
  ?coordenadas_agentes(C);
  .wait(500);
  .print("Voy a enviar destinos", L, C);
  +enviar_destinos(L, C).


+enviar_destinos([Ag | L1], [C | L2]): .length(L1, Len1) & .length(L2, Len2) & Len1 > 0 & Len2 > 0
  <-
  .print("Envio destino ", Ag, C);
  .send(Ag, tell, ir_a(C));
  -enviar_destinos(_);
  +enviar_destinos(L1, L2).





