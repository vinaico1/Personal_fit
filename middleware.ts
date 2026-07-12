import { createServerClient } from "@supabase/ssr";
import { NextResponse, type NextRequest } from "next/server";

export async function middleware(request: NextRequest) {
  let supabaseResponse = NextResponse.next({ request });

  const supabase = createServerClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
    {
      cookies: {
        getAll() {
          return request.cookies.getAll();
        },
        setAll(cookiesToSet) {
          cookiesToSet.forEach(({ name, value }) =>
            request.cookies.set(name, value)
          );
          supabaseResponse = NextResponse.next({ request });
          cookiesToSet.forEach(({ name, value, options }) =>
            supabaseResponse.cookies.set(name, value, options)
          );
        },
      },
    }
  );

  // Renova a sessão — OBRIGATÓRIO para SSR funcionar corretamente
  const { data: { user } } = await supabase.auth.getUser();

  const { pathname } = request.nextUrl;

  const rotasProtegidas = ["/dashboard", "/treino", "/nutricao", "/perfil", "/anamnese"];
  const rotasAuth = ["/login", "/cadastro"];

  const estaEmRotaProtegida = rotasProtegidas.some(r => pathname.startsWith(r));
  const estaEmRotaAuth = rotasAuth.some(r => pathname.startsWith(r));

  // Sem sessão tentando acessar área protegida → login
  if (!user && estaEmRotaProtegida) {
    const url = request.nextUrl.clone();
    url.pathname = "/login";
    return NextResponse.redirect(url);
  }

  // Com sessão tentando acessar login/cadastro → dashboard
  if (user && estaEmRotaAuth) {
    const url = request.nextUrl.clone();
    url.pathname = "/dashboard";
    return NextResponse.redirect(url);
  }

  return supabaseResponse;
}

export const config = {
  matcher: [
    "/((?!_next/static|_next/image|favicon.ico|manifest.json|icons|sw.js|.*\\.png$|.*\\.gif$|.*\\.jpg$|.*\\.svg$).*)",
  ],
};
