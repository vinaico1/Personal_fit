import { NextRequest, NextResponse } from "next/server";
import { createClient } from "@/lib/supabase/server";

const MODELOS_VALIDOS = ["fullbody", "ppl", "abc"] as const;
type Modelo = typeof MODELOS_VALIDOS[number];

export async function POST(request: NextRequest) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();

  if (!user) {
    return NextResponse.json({ error: "Não autenticado" }, { status: 401 });
  }

  const body = await request.json();
  const modelo = body.modelo as string;

  if (!MODELOS_VALIDOS.includes(modelo as Modelo)) {
    return NextResponse.json({ error: "Modelo inválido" }, { status: 400 });
  }

  const { data, error } = await supabase
    .rpc("criar_plano_modelo", { p_user_id: user.id, p_modelo: modelo });

  if (error) {
    return NextResponse.json({ error: error.message }, { status: 500 });
  }

  return NextResponse.json({ plano_id: data });
}
