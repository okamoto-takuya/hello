Example hello component
=======================

## Introduction

This component contains minimal example application code
just prints out "Hello, World".

The purpose of this component is;

* Use this component as skelton/template when you need to create new component.

## Documentation

## Requirements

This component has following dependencies.

* [CMake](http://zeromq.org/) (for building project)
* [lcov](http://ltp.sourceforge.net/coverage/lcov.php) (for generating HTML coverage report)

and should be able to build and run in any Linux environment.

## Build and Test

You can build and test this component by following procedure below under your local repository root.

    $ mkdir build
    $ cd build
    $ cmake ..
    $ make                      // Perform production build
    $ make check                // Build test executables and perform tests
    $ make lcov                 // Generate coverage report

## Contribution

## Licensing

Closed-source.

Copyright(c) 2016 Fujitsu Limited All Rights Reserved.
