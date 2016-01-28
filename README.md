meta-yocto-demos
================

This layer can be used as helper to build demo-images for various machines 
and/or intermediary staging place for adaptation patches.

The main goal is to mimimize developer changes and enable deterministic builds.


Usage:
======

   # 0st setup your host (install needed packages)
   $ make setup

   # 1st list supported machines
   $ make help

   # 2d build image(s) for supported machine
   $ make ${MACHINE}


