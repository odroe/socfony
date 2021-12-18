#!/bin/bash
# Copyright (c) 2021, Odroe Inc. All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

install_prisma_script=$(dirname $0)/install_prisma.sh

# Chack install_prisma.sh executable, install it if it does not exist.
if [ ! -x $install_prisma_script ]; then
    chmod +x $install_prisma_script
fi

# Run install prisma command
$install_prisma_script || exit 1;

root_dir=$(dirname $0)/..;        # root directory of the project
prisma_dir=$root_dir/prisma;      # Prisma schema directory
prisma_file=$prisma_dir/schema.prisma; # Prisma schema file
prisma_install_dir=$root_dir/.socfony_cache/prisma; # Prisma install directory
prisma_bin=$prisma_install_dir/node_modules/.bin/prisma; # Prisma binary
config_yaml_file=$root_dir/.socfony.yml; # Socfony configuration file

# Check config_yaml_file exists
if [ ! -f $config_yaml_file ]; then
    echo "Error: $config_yaml_file does not exist.";
    exit 1;
fi

# Get database URL from the configuration file
if [ -f $config_yaml_file ]; then
    # Create environment variable for database URL
    export DATABASE_URL=$(cat $config_yaml_file | grep "database" | awk '{print $2}')
fi

# run prisma push command
$prisma_bin db push --schema $prisma_file

# Remore DATABASE_URL environment variable
unset DATABASE_URL
