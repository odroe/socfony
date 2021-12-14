#!/bin/bash
# Copyright (c) 2021, Odroe Inc. All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

root_dir=$(dirname $0)/..;        # root directory of the project
protos_dir=$root_dir/protos;      # directory containing the protos
output_dir=$root_dir/lib/protos;  # directory to output the generated files

# Define proto imports
imports=(
    google/protobuf/empty.proto
    google/protobuf/wrappers.proto
);

# Clean the output directory
rm -rf $output_dir && mkdir -p $output_dir;

# Install Dart protobuf compiler plugin.
dart pub global activate protoc_plugin;

# Define the protoc parameters
protoc_params=(
    -I$protos_dir \
    "${protos_dir}/*.proto" \
    ${imports[*]} \
    --dart_out=grpc:$output_dir \
);

# Run protoc
protoc ${protoc_params[*]};

# Uninstall Dart protobuf compiler plugin.
dart pub global deactivate protoc_plugin;

# Clean unused files.
find $output_dir -name '*.pbenum.dart' -delete;
find $output_dir -name '*.pbjson.dart' -delete;

# Format generated Dart files.
dart format $output_dir;
