"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { LayoutDashboard, Salad, Dumbbell, User } from "lucide-react";
import { cn } from "@/lib/utils";

const navItems = [
  { href: "/dashboard", icon: LayoutDashboard, label: "Início" },
  { href: "/nutricao", icon: Salad,            label: "Nutrição" },
  { href: "/treino",   icon: Dumbbell,         label: "Treino" },
  { href: "/perfil",   icon: User,             label: "Perfil" },
];

export function SideNav() {
  const pathname = usePathname();

  return (
    <nav className="fixed left-0 top-0 h-full w-20 hidden md:flex flex-col items-center py-6 gap-1 bg-slate-900/95 backdrop-blur border-r border-slate-800 z-50">
      {/* Logo */}
      <div className="mb-8 w-10 h-10 brand-gradient rounded-xl flex items-center justify-center shrink-0">
        <Dumbbell className="w-5 h-5 text-white" />
      </div>

      {navItems.map((item) => {
        const active = pathname.startsWith(item.href);
        return (
          <Link
            key={item.href}
            href={item.href}
            className={cn(
              "relative flex flex-col items-center gap-1.5 w-14 py-3 rounded-xl transition-all",
              active
                ? "bg-brand-500/15 text-brand-400"
                : "text-slate-500 hover:text-slate-300 hover:bg-slate-800/60"
            )}
          >
            {active && (
              <span className="absolute -left-3 top-1/2 -translate-y-1/2 h-8 w-1 brand-gradient rounded-r-full" />
            )}
            <item.icon
              className={cn("w-5 h-5 transition-all", active && "drop-shadow-[0_0_8px_rgba(16,185,129,0.6)]")}
            />
            <span className="text-[10px] font-medium leading-tight text-center">{item.label}</span>
          </Link>
        );
      })}
    </nav>
  );
}
