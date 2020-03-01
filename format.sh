#!/bin/bash

swiftformat \
  --swiftversion 5 \
  --stripunusedargs closure-only \
  --disable strongOutlets,trailingCommas,blankLinesAtStartOfScope \
  firebase-auth/AppDelegate.swift
#  --lint \
#  --trimwhitespace always \
