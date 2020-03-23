#!/usr/bin/env bash

app=$1

sudo mv $app /opt/$app

sudo chown -R optuser:optuser /opt/$app

