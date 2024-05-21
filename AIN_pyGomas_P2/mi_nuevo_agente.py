import json
import random
from loguru import logger
from spade.behaviour import OneShotBehaviour
from spade.template import Template
from spade.message import Message
from pygomas.agents.bditroop import BDITroop
from pygomas.agents.bdifieldop import BDIFieldOp
from agentspeak import Actions
from agentspeak import grounded
from agentspeak.stdlib import actions as asp_action
from pygomas.ontology import Belief
import numpy as np
import math

from pygomas.agents.agent import LONG_RECEIVE_WAIT

class BDIDrunkenMonkey(BDIFieldOp):

      def distancia(x1,x2):
          return math.sqrt((x1[0]-x2[0])^2 + (x1[1]-x2[1])^2)
      
      def add_custom_actions(self, actions):
        super().add_custom_actions(actions)
        
        @actions.add(".asignarCoordenadas", 0)
        def _asignar_coordenadas(agent, term, intention):
            # Calculamods posición de la BANDERA
            flag_pos = self.bdi.get_belief(Belief.FLAG)
            # Esquinas cuadrado imaginario
            tamaño_cuadrado = 20
            esquinas = [(flag_pos-tamaño_cuadrado,flag_pos+tamaño_cuadrado),  # Esquina Izquiera Superior
                        (flag_pos+tamaño_cuadrado,flag_pos+tamaño_cuadrado),  # Esquina Derecha Superior
                        (flag_pos+tamaño_cuadrado,flag_pos-tamaño_cuadrado),  # Esquina Derecha Inferior
                        (flag_pos-tamaño_cuadrado,flag_pos-tamaño_cuadrado)]  # Esquina Izquierda Inferior
            
            baseEnemiga = (map.allied_base.get_ini_x(),map.allied_base.get_ini_z())
            distancias = []
            for e in esquinas:
                distancias.append(distancia(e,baseEnemiga))
            
            esquina_lejana = esquinas[distancias.index(min(distancias))]
                
            posiciones = [(),
                          (),
                          esquina_lejana,   # Agente Esquina
                          (),
                          ()]
            