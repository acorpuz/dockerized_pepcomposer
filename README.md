# Dockerized pepcomposer

This Dockerized version of pepcomposer is needed due to incompatible versions of libc6 with some components of the pipeline, mainly Trinagle Match.

The base system is debian 8 (Jessie) which is known to work and on which pepcomposer was developed.
