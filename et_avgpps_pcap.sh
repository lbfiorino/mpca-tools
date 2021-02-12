#!/bin/bash
capinfos -x $1 | grep 'Average packet rate' | awk '{print $4}' | tr -d ',.'
