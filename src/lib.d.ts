// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { AccessToken, User } from '@prisma/client';
import { ExecutionContext } from '@nestjs/common';

declare module 'express' {
  export interface Request {
    accessToken(context: ExecutionContext): Promise<AccessToken | null>;
    user(context: ExecutionContext): Promise<User | null>;
  }
}
