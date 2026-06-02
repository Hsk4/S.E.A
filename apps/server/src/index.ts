import express, { type Application } from "express";
import cors from "cors";
import morgan from "morgan";
import cookieParser from "cookie-parser";
import authRouter from "./routes/auth.routes.js";
import connectDB from "./config/db.js";
import config from "./config/env.js";

const app: Application = express();

app.use(cors());
app.use(express.json());
app.use(morgan("dev"));
app.use(cookieParser());

app.use("/api/v1/auth", authRouter);

export default app;

async function start(): Promise<void> {
  await connectDB();
  app.listen(config.port, () => {
    console.log(`Server running on port ${config.port}`);
  });
}

void start();

