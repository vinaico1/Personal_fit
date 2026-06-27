"use client";

import { useState } from "react";
import Link from "next/link";
import { useRouter } from "next/navigation";
import { createClient } from "@/lib/supabase/client";
import { toast } from "sonner";
import { Eye, EyeOff, Loader2 } from "lucide-react";

export default function CadastroPage() {
  const router = useRouter();
  const [nome, setNome] = useState("");
  const [email, setEmail] = useState("");
  const [senha, setSenha] = useState("");
  const [mostrarSenha, setMostrarSenha] = useState(false);
  const [loading, setLoading] = useState(false);

  async function handleCadastro(e: React.FormEvent) {
    e.preventDefault();
    const supabase = createClient();

    if (senha.length < 6) {
      toast.error("A senha deve ter pelo menos 6 caracteres.");
      return;
    }

    setLoading(true);

    const { error } = await supabase.auth.signUp({
      email,
      password: senha,
      options: { data: { nome } },
    });

    if (error) {
      const msg =
        error.message === "User already registered"
          ? "Este email já está cadastrado. Tente fazer login."
          : error.message === "Email rate limit exceeded"
          ? "Muitas tentativas. Aguarde alguns minutos e tente novamente."
          : `Erro ao criar conta: ${error.message}`;
      toast.error(msg);
      setLoading(false);
      return;
    }

    toast.success("Conta criada! Redirecionando para a anamnese...");
    router.push("/anamnese");
    router.refresh();
  }

  return (
    <div className="w-full max-w-md animate-fade-in-up">
      <div className="text-center mb-8">
        <h1 className="text-3xl font-bold mb-2">Criar conta</h1>
        <p className="text-slate-400">Comece sua jornada fitness hoje</p>
      </div>

      <form onSubmit={handleCadastro} className="glass-card rounded-2xl p-6 space-y-4">
        <div>
          <label className="block text-sm font-medium text-slate-300 mb-1.5">Nome completo</label>
          <input
            type="text"
            value={nome}
            onChange={(e) => setNome(e.target.value)}
            placeholder="Seu nome"
            required
            className="w-full bg-slate-800 border border-slate-700 rounded-xl px-4 py-3 text-slate-100 placeholder-slate-500 focus:outline-none focus:border-brand-500 transition-colors"
          />
        </div>

        <div>
          <label className="block text-sm font-medium text-slate-300 mb-1.5">Email</label>
          <input
            type="email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            placeholder="seu@email.com"
            required
            className="w-full bg-slate-800 border border-slate-700 rounded-xl px-4 py-3 text-slate-100 placeholder-slate-500 focus:outline-none focus:border-brand-500 transition-colors"
          />
        </div>

        <div>
          <label className="block text-sm font-medium text-slate-300 mb-1.5">
            Senha <span className="text-slate-500">(mín. 6 caracteres)</span>
          </label>
          <div className="relative">
            <input
              type={mostrarSenha ? "text" : "password"}
              value={senha}
              onChange={(e) => setSenha(e.target.value)}
              placeholder="••••••••"
              required
              minLength={6}
              className="w-full bg-slate-800 border border-slate-700 rounded-xl px-4 py-3 pr-12 text-slate-100 placeholder-slate-500 focus:outline-none focus:border-brand-500 transition-colors"
            />
            <button
              type="button"
              onClick={() => setMostrarSenha(!mostrarSenha)}
              className="absolute right-3 top-3.5 text-slate-500 hover:text-slate-300"
            >
              {mostrarSenha ? <EyeOff className="w-5 h-5" /> : <Eye className="w-5 h-5" />}
            </button>
          </div>
        </div>

        <button
          type="submit"
          disabled={loading}
          className="w-full brand-gradient text-white font-bold py-3.5 rounded-xl hover:opacity-90 transition-opacity disabled:opacity-50 flex items-center justify-center gap-2 shadow-lg shadow-brand-500/20"
        >
          {loading ? <Loader2 className="w-5 h-5 animate-spin" /> : "Criar conta grátis"}
        </button>

        <p className="text-center text-xs text-slate-500">
          Ao criar uma conta você concorda com os nossos termos de uso.
        </p>
      </form>

      <p className="text-center text-slate-400 mt-6">
        Já tem conta?{" "}
        <Link href="/login" className="text-brand-400 font-medium hover:text-brand-300">
          Entrar
        </Link>
      </p>
    </div>
  );
}
