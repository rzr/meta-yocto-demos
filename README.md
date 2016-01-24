meta-yocto-demos
================

This layer can be used as helper to build demo-images for various machines 
and/or intermediary staging place for adaptation patches.

The main goal is to mimimize developer changes and enable deterministic builds.


Usage:
======

   # 0st setup your host (install needed packages)
   make rule/setup/all

   # 1st setup your machine if supported (patches welcome)
   make rule/setup-machine/${MACHINE}

   # 2d build image
   make rule/image

   # 3rd (optionnaly) build other images
   make rule/image

