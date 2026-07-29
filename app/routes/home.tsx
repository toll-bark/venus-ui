import type { Route } from "./+types/home";
import { Landing } from "../landing/landing";

export function meta({}: Route.MetaArgs) {
  return [
    { title: "Landing | Venus" },
    { name: "description", content: "Welcome to Project Venus!" },
  ];
}

export default function Home() {
  return <Landing />;
}
