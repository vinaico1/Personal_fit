import { NextRequest, NextResponse } from "next/server";
import { createClient } from "@/lib/supabase/server";

export async function GET(request: NextRequest) {
  const { searchParams } = new URL(request.url);
  const q = searchParams.get("q")?.trim() ?? "";

  const supabase = await createClient();

  let query = supabase.from("alimentos").select("*");

  if (q.length > 1) {
    query = query.ilike("nome", `%${q}%`);
  }

  const { data, error } = await query.order("nome").limit(30);

  if (error) {
    return NextResponse.json({ error: error.message }, { status: 500 });
  }

  return NextResponse.json(data);
}
