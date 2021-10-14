#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "${BASH_SOURCE}")
ROOT_DIR=${SCRIPT_DIR}/..
OUTPUT_DIR=${ROOT_DIR}/lib/src/generated
PROTOS_DIR=${ROOT_DIR}/protos

protobuf=google/protobuf/timestamp.proto


mkdir -p ${OUTPUT_DIR}

protoc \
  --dart_out=grpc:${OUTPUT_DIR} \
  -I${PROTOS_DIR} \
    ${PROTOS_DIR}/*.proto \
    ${protobuf}

find ${OUTPUT_DIR} -type f -name "*.pbjson.dart" | xargs rm
find ${OUTPUT_DIR} -type f -name "*.pbenum.dart" | xargs rm

dart format ${OUTPUT_DIR}
