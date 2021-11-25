#!/bin/bash

BIN_DIR=$(dirname $0);
PROTO_PATH=$BIN_DIR/../protos/socfony.proto;
OUTPUT_DIR=$BIN_DIR/lib/src/protobuf;

rm -rf $OUTPUT_DIR;
mkdir -p $OUTPUT_DIR;

dart pub global activate protoc_plugin;

protoc \
  --dart_out=grpc:${OUTPUT_DIR} \
  -I$(dirname $PROTO_PATH) \
    $PROTO_PATH \
    google/protobuf/empty.proto \
    google/protobuf/wrappers.proto \
    google/protobuf/timestamp.proto \
;

dart pub global deactivate protoc_plugin;

find ${OUTPUT_DIR} -type f -name "*.pbjson.dart" | xargs rm;
find ${OUTPUT_DIR}/google -type f -name "*.pbenum.dart" | xargs rm;

dart format ${OUTPUT_DIR};
