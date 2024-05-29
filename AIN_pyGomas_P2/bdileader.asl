//TEAM_AXIS

+flag (F): team(200)
  <-
  .wait(1000);
  .get_service("axis");
  .asignarCoordenadas(F,P);
  +coordenadas_agentes(P);
  .nth(4,P,PL);
  .print("Soy Lider. Me voy a ", PL);
  ?destination(A);
  .print("Mi destino es", A);
  .goto(A).
  


+axis(L)
  <-
  ?coordenadas_agentes(C);
  +enviar_destinos(L, C).

+enviar_destinos([Ag | L1], [C | L2]): .length(L1, Len1) & .length(L2, Len2) & Len1 > 0 & Len2 > 0
  <-
  .send(Ag, tell, position(C));
  -enviar_destinos(_);
  +enviar_destinos(L1, L2).
