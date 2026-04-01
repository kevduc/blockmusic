#!/bin/sh
set -e
# Compile Swift source into a universal binary (arm64 + x86_64)
mkdir -p build
swiftc blockmusic.swift -target arm64-apple-macosx10.13 -o build/blockmusic-arm64
swiftc blockmusic.swift -target x86_64-apple-macosx10.13 -o build/blockmusic-x86_64
lipo -create build/blockmusic-arm64 build/blockmusic-x86_64 -output build/blockmusic
rm build/blockmusic-arm64 build/blockmusic-x86_64
