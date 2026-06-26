"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { LayoutDashboard, Salad, Dumbbell, User } from "lucide-react";
import { cn } from "@/lib/utils";

const navItems = [
  { href: "/dashboard", icon: LayoutDashboard, label: "Início" },
  { href: "/nutricao", icon: Salad, label: "Nutrição" },
  { href: "/treino", icon: Dumbbell, label: "Treino" },
  { href: "/perfil", icon: User, label: "Perfil" },
];

export function BottomNav() {
  const pathname = usePathname();

  return (
    <nav className="fixed bottom-0 inset-x-0 z-50 bg-slate-900/95 backdrop-blur border-t border-slate-800"
      style={{ paddingBottom: "env(safe-area-inset-bottom)" }}>
      <div className="flex items-center">
        {navItems.map((item) => {
          const active = pathname.startsWith(item.href);
          return (
            <Link
              key={item.href}
              href={item.href}
              className={cn(
                "flex-1 flex flex-col items-center gap-1 py-3 transition-colors",
                active ? "text-brand-400" : "text-slate-500 hover:text-slate-300"
              )}
            >
              <item.icon className={cn("w-5 h-5", active && "drop-shadow-[0_0_8px_rgba(16,185,129,0.6)]")} />
              <span className="text-xs font-medium">{item.label}</span>
              {active && (
                <span className="absolute bottom-0 w-8 h-0.5 brand-gradient rounded-full" />
              )}
            </Link>
          );
        })}
      </div>
    </nav>
  );
}
