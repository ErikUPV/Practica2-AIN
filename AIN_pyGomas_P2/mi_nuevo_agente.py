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

from pygomas.agents.agent import LONG_RECEIVE_WAIT

def crear_puntos_alrededor(pos):
    res = (0 for i in range(6))
    
    for i in range(6):
        
        

class BDIDrunkenMonkey(BDIFieldOp):


      
      def add_custom_actions(self, actions):
        super().add_custom_actions(actions)
        
        @actions.addFunction(".asignarCoordenadas", 0)
        def _asignar_coordenadas(agent, term, intention):
            u = lambda x: x^2
            
            flag_pos = self.bdi.get_belief(Belief.FLAG)
            crear_puntos_alrededor(flag_pos)
        self.bdi_actions.add_function()
            