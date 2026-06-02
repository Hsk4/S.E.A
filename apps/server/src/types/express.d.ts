import type { Query, ParamsDictionary } from "express-serve-static-core";

declare module "express-serve-static-core" {
  interface Request<
    P = ParamsDictionary,
    ResBody = any,
    ReqBody = any,
    ReqQuery = Query,
    LocalsObj extends Record<string, any> = Record<string, any>,
  > {
    cookies: {
      refreshtoken?: string;
      [key: string]: string | undefined;
    };
  }
}

