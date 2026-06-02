import mongoose, { type Document } from "mongoose";

interface IOtp extends Document {
  email: string;
  user: mongoose.Types.ObjectId;
  otpHash: string;
}

const otpSchema = new mongoose.Schema<IOtp>(
  {
    email: { type: String, required: [true, "Email is required"] },
    user: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: [true, "User ID is required"],
    },
    otpHash: { type: String, required: [true, "OTP is required"] },
  },
  { timestamps: true },
);

otpSchema.index({ createdAt: 1 }, { expireAfterSeconds: 300 });

const otpModel = mongoose.model<IOtp>("otps", otpSchema);

export default otpModel;

