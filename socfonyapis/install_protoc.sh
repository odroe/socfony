#!/bin/bash
# Copyright (c) 2021, Odroe Inc. All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

# Version
version=21.2

# Define the platform
platform=$(uname -s)

# Define the architecture
arch=$(uname -m)

# Define download url template
url_template="https://github.com/protocolbuffers/protobuf/releases/download/v{version}/protoc-{version}-{os}.zip"

# system is macOS
if [ "$platform" = "Darwin" ]; then
  os="osx-x86_64"
  # If macOS is ARM, use the ARM version
  if [ "$arch" = "arm64" ]; then
    os="osx-aarch_64"
  fi
# system is Linux
elif [ "$platform" = "Linux" ]; then
  # system is aarch64
  if [ "$arch" = "aarch64" ]; then
    os="linux-aarch_64"
  # system is ppc64le
  elif [ "$arch" = "ppc64le" ]; then
    os="linux-ppcle_64"
  # system is s390x
  elif [ "$arch" = "s390x" ]; then
    os="linux-s390_64"
  # system is x86_64
  elif [ "$arch" = "x86_64" ]; then
    os="linux-x86_64"
  # system is x86_32
  elif [ "$arch" = "x86_32" ]; then
    os="linux-x86_32"
  fi
# system is Windows
elif [ "$platform" = "Windows" ]; then
  # system is x86_64
  if [ "$arch" = "x86_64" ]; then
    os="win64"
  # system is x86_32
  elif [ "$arch" = "x86_32" ]; then
    os="win32"
  fi
fi

# Check if the os is not empty
if [ -z "$os" ]; then
  echo "Unsupported platform: $platform-$arch"
  exit 1
fi

# Define the download url
url=$(echo $url_template | sed "s/{version}/$version/g" | sed "s/{os}/$os/g")

# Define the output directory
output_dir=$(dirname $0)/.socfony_cache/protoc

# Check if the output directory exists
if [ ! -d $output_dir ]; then
  mkdir -p $output_dir
else
  rm -rf $output_dir/*
fi

# Define the output file
output_file="protoc"

# Check if the output file exists
if [ -f $output_dir/$output_file ]; then
  rm $output_dir/$output_file
fi

# Download the protoc
curl -L $url -o $output_dir/$output_file

# Unzip the protoc
unzip $output_dir/$output_file -d $output_dir

# Remove the zip file
rm $output_dir/$output_file

# Change the permission
chmod +x $output_dir/bin/$output_file

# Check if the output file exists
if [ -f $output_dir/bin/$output_file ]; then
  echo "Protoc is installed in $output_dir/bin/$output_file"
else
  echo "Failed to install protoc"
  exit 1
fi
