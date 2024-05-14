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

class BDIDrunkenMonkey(BDIFieldOp):


      
      def add_custom_actions(self, actions):
        super().add_custom_actions(actions)
        
        @actions.add(".asignarCoordenadas", 0)
        def _asignar_coordenadas(agent, term, intention):
            u = lambda x: x^2
            
            Belief.FLAG
            