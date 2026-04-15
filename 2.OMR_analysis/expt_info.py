#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
#  pyscript.py
#  
#  Copyright 2019 Kumaresh <kumaresh_krishnan@g.harvard.edu>
#  
#  version 1.0

import numpy as np
from hdf5storage import savemat, loadmat
import os, sys

def main():
    
    days = ['2026_04_15']
    fish = [12]
    trials = 30

    control = [8,9,10,11]
    sleep_1 = [0,1,2,3]  # 1h light pulse, 2500lux, 12AM-1AM
    sleep_2 = [4,5,6,7] #continuous light




    np.save('expt_info.npy', {'days':days, 'fish':fish, 'trials':trials, 'control':control, 'sleep_1':sleep_1,
                              'sleep_2':sleep_2,})
    
    return 0
    
def createIDMap():
    
    id_map = {}
    
    # Left, right, control
    #id_map['0'] = np.array([-1,50])
    #id_map['1'] = np.array([-1,100])
    #id_map['2'] = np.array([1,50])
    #id_map['3'] = np.array([1,100])
    #id_map['4'] = np.array([0,0])

    #salt: left, right, control
    id_map['0'] = np.array([0, 0])
    id_map['1'] = np.array([-1, 25])
    id_map['2'] = np.array([-1, 50])
    id_map['3'] = np.array([-1, 100])
    id_map['4'] = np.array([0, 0])
    id_map['5'] = np.array([1, 25])
    id_map['6'] = np.array([1, 50])
    id_map['7'] = np.array([1, 100])
    
    # Save ID map
    savemat('ID_map.mat', id_map, format='7.3', oned_as='column', store_python_metadata=True)
    
    return 0


if __name__ == '__main__':

    main()
    createIDMap()
    
    sys.exit()
