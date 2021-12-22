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
    google/protobuf/timestamp.proto
);

# Check if the protoc command is exists,
# if not, run the install_protoc.sh script
if ! command -v protoc >/dev/null 2>&1; then
    # Check $root_dir/.socfony_cache/protoc don't exists, if not, create it
    if [ ! -d "$root_dir/.socfony_cache/protoc" ]; then
        install_script=$root_dir/tools/install_protoc.sh
        if [ ! -x $install_script ]; then
            chmod +x $install_script
        fi
        $install_script || exit 1;
    fi
    # Chack $root_dir/.socfony_cache/protoc/bin in $PATH, if not exists, append it.
    if ! echo $PATH | grep -q "$root_dir/.socfony_cache/protoc/bin"; then
        export PATH=$PATH:$root_dir/.socfony_cache/protoc/bin
    fi
fi

protoc_gen_dart_bin=$(which protoc-gen-dart)
# Check if the protoc-gen-dart command exists, install if it does not exist
if ! command -v protoc-gen-dart >/dev/null 2>&1; then
    protoc_gen_dart_bin=$root_dir/.socfony_cache/protoc-gen-dart

    # Check protoc_gen_dart_bin file exists
    if [ ! -f $protoc_gen_dart_bin ]; then
        echo "protoc-gen-dart command not found, installing..."

        # chache $root_dir/.socfony_cache directory exists, create it if it does not exist.
        if [ ! -d $root_dir/.socfony_cache ]; then
            mkdir $root_dir/.socfony_cache
        else
            rm -rf $root_dir/.socfony_cache/protobuf.dart-master
        fi
        
        # Download protoc-gen-dart
        curl -L https://github.com/google/protobuf.dart/archive/refs/heads/master.zip -o $root_dir/.socfony_cache/protobuf.zip
        unzip $root_dir/.socfony_cache/protobuf.zip -d $root_dir/.socfony_cache
        rm -rf $root_dir/.socfony_cache/protobuf.zip

        # Generate protoc-gen-dart
        cd $root_dir/.socfony_cache/protobuf.dart-master/protoc_plugin
        dart pub get
        dart compile exe -o protoc-gen-dart bin/protoc_plugin.dart
        cd -

        # Copy the generated protoc-gen-dart to $protoc_gen_dart_bin
        cat $root_dir/.socfony_cache/protobuf.dart-master/protoc_plugin/protoc-gen-dart > $protoc_gen_dart_bin
        
        # Check if protoc-gen-dart has execute permission, increase if not
        if [ ! -x $protoc_gen_dart_bin ]; then
            chmod +x $protoc_gen_dart_bin
        fi
        
        # Clean up
        rm -rf $root_dir/.socfony_cache/protobuf.dart-master
    fi
fi

# Clean the output directory
rm -rf $output_dir && mkdir -p $output_dir;

# Define the protoc parameters
protoc_params=(
    --plugin=protoc-gen-dart=$protoc_gen_dart_bin
    -I$protos_dir \
    "${protos_dir}/*.proto" \
    ${imports[*]} \
    --dart_out=grpc:$output_dir \
);

# Run protoc
echo "Generating Dart files..."
protoc ${protoc_params[*]}

# If $root_dir/.socfony_cache/protoc/bin in $PATH, remove it.
if echo $PATH | grep -q "$root_dir/.socfony_cache/protoc/bin"; then
    export PATH=$(echo $PATH | sed -e "s|$root_dir/.socfony_cache/protoc/bin:||g")
fi

# Clean unused files.
find $output_dir/google -name '*.pbenum.dart' -delete;
find $output_dir -name '*.pbjson.dart' -delete;

# Format generated Dart files.
dart format $output_dir;
