#!/bin/bash
BIN_DIR=$(dirname $0);

cd ${BIN_DIR}/..;

npm run build;
cat ../protos/socfony.proto > dist/socfony.proto;

cd -;
