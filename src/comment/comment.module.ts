// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { Module } from '@nestjs/common';
import { CommentResolver } from './comment.resolver';

@Module({
  providers: [CommentResolver],
})
export class CommentModule {}
