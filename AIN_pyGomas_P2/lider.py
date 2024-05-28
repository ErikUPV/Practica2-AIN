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


def distancia(x1,x2):
    return math.sqrt((x1[0]-x2[0])^2 + (x1[1]-x2[1])^2)

class BDILider(BDIFieldOp):

      
      def add_custom_actions(self, actions):
        super().add_custom_actions(actions)
        
        @actions.add_function(".asignarCoordenadas", 0)
        def _asignarCoordenadas():
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
            
            start_point = esquinas[distancias.index(max(distancias))]
            contigua_siguiente = esquinas[(distancias.index(max(distancias))+1)%len(esquinas)]
            contigua_anterior = esquinas[(distancias.index(max(distancias))-1)%len(esquinas)]
                
            posiciones = [contigua_anterior,
                          ((contigua_anterior[0]+start_point[0])/2, (contigua_anterior[1]+start_point[1])/2),
                          contigua_siguiente,   
                          ((contigua_siguiente[0]+start_point[0])/2, (contigua_siguiente[1]+start_point[1])/2),
                          start_point]          # Agente Esquina
            
            return tuple(posiciones[0], posiciones[1], posiciones[2], posiciones[3], posiciones[4])
              