#!/bin/bash

setenforce 0 || true

(condor_master || true) >/tmp/condor_master.txt 2>&1

