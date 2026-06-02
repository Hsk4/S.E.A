import mongoose, { type Document } from "mongoose";

interface IUser extends Document {
  username: string;
  email: string;
  password: string;
  verified: boolean;
}

const userSchema = new mongoose.Schema<IUser>({
  username: {
    type: String,
    required: [true, "Username is required"],
    unique: [true, "Username is must be unique"],
  },
  email: {
    type: String,
    required: [true, "Email is required"],
    unique: [true, "Email is must be unique"],
  },
  password: { type: String, required: [true, "Password is required"] },
  verified: { type: Boolean, default: false },
});

const User = mongoose.model<IUser>("User", userSchema);

export default User;

