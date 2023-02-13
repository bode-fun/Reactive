#!/usr/bin/env -S just --justfile

#alias t := test

export TOOLCHAINS := "swiftwasm"

triple := "wasm32-unknown-wasi"

build:
    swift build --triple {{triple}}

build-release:
    swift build --triple {{triple}} -c release

bundle:
    carton bundle --product ReactiveWebDemo

dev: 
    carton dev --product ReactiveWebDemo