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

    return int(math.sqrt((x1[0]-x2[0])**2 + (x1[1]-x2[1])**2))


class BDIMejor(BDITroop):

      
      def add_custom_actions(self, actions):
        super().add_custom_actions(actions)
        
        @actions.add_function(".getBaseEnemiga",(tuple))
        def _getBaseEnemiga(x):
            
            a = x
            baseEnemiga = [self.map.allied_base.get_init_x(),self.map.allied_base.get_init_z()]
            return (baseEnemiga[0], 0, baseEnemiga[1])
        
        @actions.add_function(".randomPointAround",(tuple))
        def _randomPointAround(point):
            x, y, z = point[0], point[1], point[2]
            x_res = random.randrange(x - 5, x + 5)
            z_res = random.randrange(z - 5, z + 5)
            
            parte1 = True
            while not self.map.can_walk(x_res, z_res):
                    if parte1:
                        x_res += 1
                        parte1 = False
                    else:
                        z_res += 1
                        parte1 = True
                        
            return (x_res, 0, z_res)
           
            