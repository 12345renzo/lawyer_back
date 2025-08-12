// src/env.d.ts
declare namespace NodeJS {
  interface ProcessEnv {
    DB_HOST: string;
    DB_PORT: string;
    DB_USER: string;
    DB_PASSWORD: string;
    DB_NAME: string;
    PORT?: string;
    NODE_ENV: 'development' | 'production' | 'test';
  }
}