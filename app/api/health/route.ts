import { NextResponse } from "next/server";

export async function GET() {
  return NextResponse.json({
    supabase_url: process.env.NEXT_PUBLIC_SUPABASE_URL ? "✅ definida" : "❌ ausente",
    supabase_key: process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY ? "✅ definida" : "❌ ausente",
    anthropic_key: process.env.ANTHROPIC_API_KEY ? "✅ definida" : "❌ ausente",
    node_env: process.env.NODE_ENV,
  });
}
