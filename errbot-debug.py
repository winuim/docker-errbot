#!/usr/local/bin/python3

# -*- coding: utf-8 -*-
import ptvsd
import re
import sys

from errbot.cli import main
from time import sleep

ptvsd.enable_attach()
print("waiting...")
ptvsd.wait_for_attach()
sleep(1)

if __name__ == '__main__':
    sys.argv[0] = re.sub(r'(-script\.pyw?|\.exe)?$', '', sys.argv[0])
    sys.exit(main())
