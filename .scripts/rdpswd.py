#!/usr/bin/env python
import os
import random
import string

length = 16
fileds = string.ascii_letters + string.digits + '_+-&=!@#$%^*()'
random.seed(os.urandom(64))
print(''.join(random.choice(fileds) for _ in range(length)))
