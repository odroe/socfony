import type Client = require('cos-nodejs-sdk-v5');

export interface CreateStorageUrlOptions {
  expiresIn?: number;
  query?: Record<string, any>;
  headers?: Record<string, any>;
  method?: Client.Method;
}
