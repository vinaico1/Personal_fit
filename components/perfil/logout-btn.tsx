"use client";

import { useRouter } from "next/navigation";
import { createClient } from "@/lib/supabase/client";
import { LogOut } from "lucide-react";

export function LogoutBtn() {
  const router = useRouter();

  async function handleLogout() {
    const supabase = createClient();
    await supabase.auth.signOut();
    router.push("/");
    router.refresh();
  }

  return (
    <button
      onClick={handleLogout}
      className="w-full flex items-center justify-center gap-2 border border-red-900/50 text-red-400 font-medium py-3 rounded-xl hover:bg-red-900/20 transition-colors"
    >
      <LogOut className="w-4 h-4" />
      Sair da conta
    </button>
  );
}
