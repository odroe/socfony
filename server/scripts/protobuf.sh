#!/bin/bash

BIN_DIR=$(dirname $0);
PROTO_PATH=$BIN_DIR/../../protos/socfony.proto;
OUTPUT_DIR=$BIN_DIR/..src/protobuf;
TS_PLUGIN_BIN=$BIN_DIR/../node_modules/.bin/protoc-gen-ts;

rm -rf $OUTPUT_DIR;
mkdir -p $OUTPUT_DIR;

protoc \
  --plugin=protoc-gen-ts=${TS_PLUGIN_BIN} \
  --js_out=import_style=commonjs,binary:${OUTPUT_DIR} \
  --ts_out=mode=grpc-js:${OUTPUT_DIR} \
  -I$(dirname $PROTO_PATH) \
    $PROTO_PATH \
;

dart format ${OUTPUT_DIR};
