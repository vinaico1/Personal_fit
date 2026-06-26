import Link from "next/link";
import { Activity, Salad, Dumbbell, TrendingUp, ChevronRight, CheckCircle2 } from "lucide-react";

const features = [
  {
    icon: Salad,
    title: "Nutrição Personalizada",
    desc: "Plano alimentar calculado com base nos seus dados e objetivo. Você escolhe os alimentos dentro das suas metas.",
  },
  {
    icon: Dumbbell,
    title: "Treino Inteligente",
    desc: "Programa de treino otimizado baseado em evidências científicas, adaptado à sua disponibilidade.",
  },
  {
    icon: TrendingUp,
    title: "Evolução Acompanhada",
    desc: "Registre peso e medidas, visualize seu progresso com gráficos e celebre cada conquista.",
  },
];

const beneficios = [
  "Anamnese completa para personalização total",
  "Cálculo de TMB, GET e macros individualizados",
  "Banco com mais de 60 alimentos cadastrados",
  "Exercícios com instruções detalhadas",
  "Funciona como app (PWA — sem app store)",
  "100% gratuito para começar",
];

export default function LandingPage() {
  return (
    <div className="min-h-screen bg-slate-950 text-slate-100">
      {/* Header */}
      <header className="fixed top-0 inset-x-0 z-50 bg-slate-950/80 backdrop-blur border-b border-slate-800">
        <div className="max-w-5xl mx-auto px-4 h-16 flex items-center justify-between">
          <div className="flex items-center gap-2">
            <div className="w-8 h-8 brand-gradient rounded-lg flex items-center justify-center">
              <Activity className="w-5 h-5 text-white" />
            </div>
            <span className="font-bold text-lg">FitLife</span>
          </div>
          <div className="flex items-center gap-3">
            <Link href="/login" className="text-slate-400 hover:text-white text-sm transition-colors">
              Entrar
            </Link>
            <Link
              href="/cadastro"
              className="brand-gradient text-white text-sm font-medium px-4 py-2 rounded-lg hover:opacity-90 transition-opacity"
            >
              Começar grátis
            </Link>
          </div>
        </div>
      </header>

      {/* Hero */}
      <section className="pt-32 pb-20 px-4 text-center">
        <div className="max-w-3xl mx-auto">
          <div className="inline-flex items-center gap-2 bg-brand-500/10 border border-brand-500/30 rounded-full px-4 py-1.5 text-brand-400 text-sm font-medium mb-6">
            <Activity className="w-4 h-4" />
            Personal + Nutricionista Digital
          </div>
          <h1 className="text-4xl sm:text-6xl font-extrabold mb-6 leading-tight">
            Transforme seu corpo com{" "}
            <span className="brand-text-gradient">ciência e tecnologia</span>
          </h1>
          <p className="text-slate-400 text-lg sm:text-xl mb-10 max-w-2xl mx-auto leading-relaxed">
            Seu plano de treino e nutrição 100% personalizado, baseado nos seus dados, objetivo
            e disponibilidade. Direto no seu celular, como um app.
          </p>
          <div className="flex flex-col sm:flex-row gap-4 justify-center">
            <Link
              href="/cadastro"
              className="brand-gradient text-white font-bold px-8 py-4 rounded-xl text-lg hover:opacity-90 transition-opacity flex items-center justify-center gap-2 shadow-lg shadow-brand-500/25"
            >
              Criar minha conta grátis
              <ChevronRight className="w-5 h-5" />
            </Link>
            <Link
              href="/login"
              className="border border-slate-700 text-slate-300 font-medium px-8 py-4 rounded-xl text-lg hover:border-slate-500 hover:text-white transition-colors flex items-center justify-center gap-2"
            >
              Já tenho conta
            </Link>
          </div>
          <p className="text-slate-600 text-sm mt-6">
            Sem cartão de crédito · Sem app store · Instale direto no celular
          </p>
        </div>
      </section>

      {/* Features */}
      <section className="py-20 px-4 bg-slate-900/50">
        <div className="max-w-5xl mx-auto">
          <h2 className="text-3xl font-bold text-center mb-4">
            Tudo que você precisa para evoluir
          </h2>
          <p className="text-slate-400 text-center mb-12">
            Um ecossistema completo de saúde e fitness no seu bolso
          </p>
          <div className="grid sm:grid-cols-3 gap-6">
            {features.map((f) => (
              <div key={f.title} className="glass-card rounded-2xl p-6">
                <div className="w-12 h-12 brand-gradient rounded-xl flex items-center justify-center mb-4">
                  <f.icon className="w-6 h-6 text-white" />
                </div>
                <h3 className="font-bold text-lg mb-2">{f.title}</h3>
                <p className="text-slate-400 text-sm leading-relaxed">{f.desc}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Benefícios */}
      <section className="py-20 px-4">
        <div className="max-w-3xl mx-auto">
          <h2 className="text-3xl font-bold text-center mb-12">
            Por que escolher o FitLife?
          </h2>
          <div className="grid sm:grid-cols-2 gap-4">
            {beneficios.map((b) => (
              <div key={b} className="flex items-start gap-3">
                <CheckCircle2 className="w-5 h-5 text-brand-400 mt-0.5 shrink-0" />
                <span className="text-slate-300">{b}</span>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* CTA Final */}
      <section className="py-20 px-4">
        <div className="max-w-2xl mx-auto text-center glass-card rounded-3xl p-10">
          <h2 className="text-3xl font-bold mb-4">Pronto para começar?</h2>
          <p className="text-slate-400 mb-8">
            Crie sua conta, preencha a anamnese e receba seu plano personalizado em minutos.
          </p>
          <Link
            href="/cadastro"
            className="brand-gradient text-white font-bold px-8 py-4 rounded-xl text-lg hover:opacity-90 transition-opacity inline-flex items-center gap-2 shadow-lg shadow-brand-500/25"
          >
            Começar agora — é grátis
            <ChevronRight className="w-5 h-5" />
          </Link>
        </div>
      </section>

      {/* Footer */}
      <footer className="border-t border-slate-800 py-8 px-4 text-center text-slate-600 text-sm">
        <p>© 2025 FitLife · Construído com ❤️ para sua saúde</p>
      </footer>
    </div>
  );
}
