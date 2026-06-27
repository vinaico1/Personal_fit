import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { BottomNav } from "@/components/layout/bottom-nav";
import { SideNav } from "@/components/layout/side-nav";

export default async function AppLayout({ children }: { children: React.ReactNode }) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();

  if (!user) redirect("/login");

  return (
    <div className="min-h-screen bg-slate-950">
      <SideNav />
      <main className="safe-area-pb md:pb-8 md:pl-20">{children}</main>
      <div className="md:hidden">
        <BottomNav />
      </div>
    </div>
  );
}
