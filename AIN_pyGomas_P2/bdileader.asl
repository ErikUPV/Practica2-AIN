//TEAM_AXIS

+flag (F): team(200)
  <-
  //.goto(F);
  .register_service("general");
  .register_service("medics");
  .register_service("lider");
  .asignarCoordenadas(F,P);
  +coordenadas_agentes(P);
  // .wait(500);
  // .goto([112,0,136]);
  .nth(8,P,[X, Y, Z]);
  .print("Soy Lider. Me voy a ", [X, Y, Z]);
  .goto([X, Y, Z]);
  .wait(2000);
  +inicio;
  .get_service("general");
  .get_medics.

+myMedics([M1, M2]): team(200)
  <-
  .send(M1, tell, escuadron(1));
  .send(M2, tell, escuadron(2)).
  
  
+enemies_in_fov(ID,Type,Angle,Distance,Health,Position): not shooting
  <-
  -patrullando;
  .shoot(3,Position);
  .look_at(Position);
  .goto(Position);
  +shooting;
  +siguiendo.

+general(L): inicio
  <-
  ?coordenadas_agentes(C);
  .wait(500);
  .print("Voy a enviar destinos", L, C);
  +enviar_destinos(L, C).


+enviar_destinos([Ag | L1], [C | L2]): .length(L1, Len1) & .length(L2, Len2) & Len1 >= 4
  <-
  .print("Envio destino PROTEGER", Ag, C);
  .send(Ag, tell, ir_a(C));
  .send(Ag, tell, escuadron(1));
  -enviar_destinos(_);
  +enviar_destinos(L1, L2).

+enviar_destinos([Ag | L1], [C | L2]): .length(L1, Len1) & .length(L2, Len2) & Len1 >= 0
  <-
  .print("Envio destino PATRULLAR", Ag, C);
  .send(Ag, tell, ir_a(C));
  .send(Ag, tell, escuadron(2));
  -enviar_destinos(_);
  +enviar_destinos(L1, L2).

+base_enemiga(P)
  <-
  +base_en(P).

+target_reached(T)
  <-
  ?base_en(P);
  .look_at(P);
  ?flag(F);
  .reload;
  +paquete_echado;
  .look_at(F).

+paquete_echado
  <-
  .wait(5000);
  .reload;
  .print("Paquete de municion!");
  .get_service("general");
  -+paquete_echado.

+general(L)
  <-
  +enviar_info_paquetes(L).

+enviar_info_paquetes([Ag | L]): .length(L, Len) & Len > 0
  <-
  ?position(P);
  .send(Ag, tell, paquete_en(P));
  -enviar_info_paquetes(_);
  +enviar_info_paquetes(L).

  
+enemies_in_fov(ID,Type,Angle,Distance,Health,Position)
  <-
  .shoot(3,Position);
  +shooting.





