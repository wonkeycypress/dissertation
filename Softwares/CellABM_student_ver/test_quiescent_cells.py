#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Apr 23 17:03:04 2018

@author: Harrison Paul Cooper
"""
from quiescent_cells import qc
import unittest
import random
import math


class TestQuiescentCells(unittest.TestCase):

    def setUp(self):
        self.qc1 = qc(ID=1, stage=1, pos=[0, 0], direc=random.random() * 2 * math.pi,
                      turnover=1, radius=5, area=25 * math.pi)
        self.qc2 = qc(ID=1, stage=240, pos=[0, 0], direc=random.random() * 2 * math.pi,
                      turnover=1, radius=5, area=25 * math.pi)

    def tearDown(self):
        pass

    def test_senescence(self):
        qc1 = qc.senescence(self.qc1)
        print(qc1)
        qc2 = qc.senescence(self.qc2)
        print(qc2)
        self.assertEquals(qc1, None)
        #self.assertEquals(qc1.stage, 2)
        #self.assertEquals(qc2.senescence, True)
        self.assertEquals(qc2.dead, True)

    #def test_proliferating(self):


if __name__ == '__main__':
    unittest.main()