#!/bin/bash
# Copyright (c) 2021, Odroe Inc. All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

install_prisma_script=$(dirname $0)/install_prisma.sh

# Chack install_prisma.sh executable, install it if it does not exist.
if [ ! -x $install_prisma_script ]; then
    chmod +x $install_prisma_script
fi

# Run install prisma command, if it fails, exit
$install_prisma_script || exit 1;

prisma_bin=$(dirname $0)/../.socfony_cache/prisma/node_modules/.bin/prisma
prisma_schema_path=$(dirname $0)/../prisma/schema.prisma

# Run prisma format command
$prisma_bin format --schema $prisma_schema_path
