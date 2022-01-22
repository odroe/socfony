#!/bin/bash
# Copyright (c) 2021, Odroe Inc. All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

# Chack npm exists, if don't exists, exit
if [ ! -x $(which npm) ]; then
    echo "Error: npm is not installed.";
    exit 1;
fi

root_dir=$(dirname $0)/..;        # root directory of the project
prisma_dir=$root_dir/prisma;      # Prisma schema directory
prisma_install_dir=$root_dir/.socfony_cache/prisma; # Prisma install directory
prisma_bin=$prisma_install_dir/node_modules/.bin/prisma; # Prisma binary

# Check Node.js installed
if [ ! -x $(which node) ]; then
    echo "Error: Node.js is not installed.";
    exit 1;
fi

# Chack $root_dir/.socfony_cache/prisma directory exists, create it if it does not exist.
if [ ! -d $prisma_install_dir ]; then
  mkdir -p $prisma_install_dir
fi

# Check prisma_bin file exists, install it if it does not exist.
if [ ! -f $prisma_bin ]; then
  cd $prisma_install_dir
  echo "Installing Prisma..."
  npm install --save prisma
  cd -
fi
