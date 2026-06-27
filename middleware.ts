import { NextResponse, type NextRequest } from "next/server";

// Força runtime Node.js: suporta todos os módulos Node.js nativos
// (Edge Runtime não suporta node:async_hooks nem node:buffer)
export const runtime = "nodejs";

// Extrai o project ref da URL do Supabase
// Ex: https://zrvqtucsjogafnnwvosi.supabase.co → zrvqtucsjogafnnwvosi
function getProjectRef(): string {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL ?? "";
  return url.replace(/^https?:\/\//, "").split(".")[0] ?? "";
}

export function middleware(request: NextRequest) {
  const { pathname } = request.nextUrl;

  const publicPaths = ["/", "/login", "/cadastro", "/api"];
  const isPublicPath = publicPaths.some((p) => pathname.startsWith(p));

  // O @supabase/ssr salva o token em cookies com este padrão de nome
  const ref = getProjectRef();
  const isAuthenticated =
    request.cookies.has(`sb-${ref}-auth-token`) ||
    request.cookies.has(`sb-${ref}-auth-token.0`);

  if (!isAuthenticated && !isPublicPath) {
    const url = request.nextUrl.clone();
    url.pathname = "/login";
    return NextResponse.redirect(url);
  }

  if (isAuthenticated && (pathname === "/login" || pathname === "/cadastro")) {
    const url = request.nextUrl.clone();
    url.pathname = "/dashboard";
    return NextResponse.redirect(url);
  }

  return NextResponse.next();
}

export const config = {
  matcher: [
    "/((?!_next/static|_next/image|favicon.ico|icons|manifest.json|sw.js|.*\\.(?:svg|png|jpg|jpeg|gif|webp)$).*)",
  ],
};
