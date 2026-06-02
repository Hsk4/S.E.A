import { type NextFunction, type Request, type Response } from "express";
import jwt, { type JwtPayload } from "jsonwebtoken";
import config from "../config/env.js";

export interface AuthenticatedRequest extends Request {
  userId?: string;
}

export function verifyToken(
  req: AuthenticatedRequest,
  res: Response,
  next: NextFunction,
): void {
  const token = req.headers.authorization?.split(" ")[1];

  if (!token) {
    res.status(401).json({
      message: "No token provided, access denied",
      success: false,
    });
    return;
  }

  try {
    const decoded = jwt.verify(token, config.Jwt) as JwtPayload & { id: string };
    req.userId = decoded.id;
    next();
  } catch {
    res.status(401).json({
      message: "Invalid or expired token",
      success: false,
    });
  }
}

