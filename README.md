# FitLife — Personal & Nutricionista Digital

SaaS de saude e fitness que entrega um plano de treino e nutricao 100% personalizado direto no celular, funcionando como app nativo via **PWA** (sem App Store).

---

## Visao Geral

O FitLife combina os papeis de personal trainer e nutricionista em uma plataforma web inteligente. O aluno preenche uma anamnese completa e o sistema gera automaticamente:

- **Plano nutricional** com metas de calorias e macronutrientes por refeicao
- **Plano de treino** com split otimizado baseado na disponibilidade semanal
- **Imagens e videos** de demonstracao para cada exercicio
- **Acompanhamento diario** de consumo alimentar e execucao de treinos
- **Evolucao corporal** com historico de peso e medidas

---

## Stack Tecnologico

| Camada | Tecnologia | Plano gratuito |
|--------|-----------|----------------|
| Frontend | Next.js 15 (App Router) + TypeScript | — |
| Estilo | Tailwind CSS dark theme | — |
| Backend / Auth | Supabase (PostgreSQL + RLS) | Sim |
| Deploy | Vercel | Sim |
| PWA | Service Worker nativo | — |
| Imagens | Wger.de API (gratuita, sem chave) | Sim |
| IA (opcional) | Anthropic Claude API | — |

---

## Funcionalidades

### Modulo Nutricao

- Calculo de TMB (equacao de Mifflin-St Jeor) e GET por nivel de atividade
- Meta calorica e de macros (proteina, carboidrato, gordura) individualizada por objetivo
- Plano com 5 refeicoes padrao com distribuicao percentual de macros:
  - Cafe da manha: 25% | Lanche manha: 10% | Almoco: 35% | Lanche tarde: 15% | Jantar: 15%
- Banco de **60+ alimentos** baseado na tabela TACO (alimentos brasileiros)
- Log diario de alimentos com rastreamento de macros em tempo real
- Anel visual de progresso calorico no dashboard

### Modulo Treino

- Split automatico baseado nos dias disponiveis por semana:
  - 1-2 dias → Full Body
  - 3 dias → Push / Pull / Legs
  - 4 dias → Upper / Lower
  - 5 dias → PPL + Upper / Lower
  - 6 dias → Push / Pull / Legs x2
- **75+ exercicios** em 3 niveis de dificuldade:
  - **Iniciante**: exercicios acessiveis, maquinas, peso corporal
  - **Intermediario**: barras, cabos, tecnicas compostas
  - **Avancado**: movimentos complexos, sobrecarga maxima
- Series e repeticoes ajustadas automaticamente pelo objetivo
- Cards expansiveis com:
  - Imagem de demonstracao (buscada automaticamente no Wger.de)
  - Instrucoes passo a passo e dica de execucao
  - Marcador interativo de series concluidas
  - Botao "Ver tutorial em video" (YouTube)
- Log de treino concluido com contador semanal

### Acompanhamento

- Registro de peso e medidas corporais (cintura, quadril, braco, coxa)
- Historico de evolucao de peso
- IMC calculado e classificado

---

## Banco de Exercicios

### Peito
| Exercicio | Nivel | Equipamento |
|-----------|-------|-------------|
| Flexao de Braco | Iniciante | Sem equipamento |
| Flexao Diamante | Iniciante | Sem equipamento |
| Crucifixo com Halteres | Iniciante | Halteres + Banco |
| Supino na Maquina | Iniciante | Maquina chest press |
| Supino Reto com Barra | Intermediario | Barra + Banco |
| Supino Inclinado com Halteres | Intermediario | Halteres + Banco |
| Crossover no Cabo | Intermediario | Polia dupla |
| Supino Declinado com Barra | Avancado | Barra + Banco declinado |
| Dips nas Paralelas — Peitoral | Avancado | Barras paralelas |

### Costas
| Exercicio | Nivel | Equipamento |
|-----------|-------|-------------|
| Puxada Frontal com Barra | Iniciante | Polia alta |
| Remada Unilateral com Halter | Iniciante | Halter + Banco |
| Remada na Maquina | Iniciante | Maquina de remada |
| Remada Curvada com Barra | Intermediario | Barra |
| Remada Baixa no Cabo | Intermediario | Polia baixa |
| Pull Over com Halter | Intermediario | Halter + Banco |
| Barra Fixa | Avancado | Barra fixa |
| Levantamento Terra Convencional | Avancado | Barra |

### Ombros
| Exercicio | Nivel | Equipamento |
|-----------|-------|-------------|
| Desenvolvimento com Halteres | Iniciante | Halteres |
| Elevacao Lateral | Iniciante | Halteres |
| Elevacao Frontal | Iniciante | Halteres ou Barra |
| Face Pull no Cabo | Iniciante | Polia alta |
| Encolhimento de Ombros (Shrug) | Iniciante | Barra ou Halteres |
| Desenvolvimento Militar com Barra | Intermediario | Barra |
| Desenvolvimento Arnold | Intermediario | Halteres |

### Biceps
| Exercicio | Nivel | Equipamento |
|-----------|-------|-------------|
| Rosca Direta com Barra | Iniciante | Barra |
| Rosca Martelo | Iniciante | Halteres |
| Rosca Concentrada | Iniciante | Halter |
| Rosca Scott | Intermediario | Banco Scott + Barra W |
| Rosca Inclinada com Halteres | Intermediario | Halteres + Banco |
| Rosca 21 com Barra | Avancado | Barra |

### Triceps
| Exercicio | Nivel | Equipamento |
|-----------|-------|-------------|
| Triceps Pulley | Iniciante | Polia alta |
| Mergulho em Banco | Iniciante | Banco |
| Extensao Unilateral no Cabo | Iniciante | Polia alta |
| Supino Fechado | Intermediario | Barra |
| Triceps Testa (Skull Crusher) | Intermediario | Barra W + Banco |
| Dips nas Paralelas — Triceps | Avancado | Barras paralelas |

### Pernas
| Exercicio | Nivel | Equipamento |
|-----------|-------|-------------|
| Leg Press 45° | Iniciante | Leg Press |
| Extensora (Leg Extension) | Iniciante | Maquina |
| Flexora (Leg Curl) | Iniciante | Maquina |
| Panturrilha em Pe | Iniciante | Maquina ou degrau |
| Afundo com Halteres | Iniciante | Halteres |
| Agachamento Goblet | Iniciante | Kettlebell ou Halter |
| Agachamento Sumo com Halter | Iniciante | Halter |
| Step-Up com Halteres | Iniciante | Halteres + Banco |
| Cadeira Adutora | Iniciante | Maquina adutora |
| Cadeira Abdutora | Iniciante | Maquina abdutora |
| Agachamento com Barra | Intermediario | Barra + Rack |
| Stiff (Romanian Deadlift) | Intermediario | Barra ou Halteres |
| Hack Squat na Maquina | Intermediario | Maquina Hack Squat |
| Agachamento com Salto | Intermediario | Sem equipamento |
| Agachamento Bulgaro | Avancado | Halteres + Banco |

### Gluteos
| Exercicio | Nivel | Equipamento |
|-----------|-------|-------------|
| Elevacao Pelvica (Glute Bridge) | Iniciante | Peso corporal ou anilha |
| Kickback no Cabo | Iniciante | Polia baixa |
| Abducao de Quadril na Maquina | Iniciante | Maquina de abducao |
| Afundo Reverso com Halteres | Iniciante | Halteres |
| Hip Thrust com Barra | Intermediario | Barra + Banco |

### Core / Abdomen
| Exercicio | Nivel | Equipamento |
|-----------|-------|-------------|
| Prancha Isometrica | Iniciante | Sem equipamento |
| Crunch Abdominal | Iniciante | Sem equipamento |
| Abdominal Bicicleta | Iniciante | Sem equipamento |
| Prancha Lateral | Iniciante | Sem equipamento |
| Dead Bug | Iniciante | Sem equipamento |
| Elevacao de Pernas Deitado | Iniciante | Sem equipamento |
| Abdominal na Maquina | Iniciante | Maquina abdominal |
| Russian Twist com Disco | Intermediario | Disco ou halter |
| Roda Abdominal | Avancado | Roda abdominal |
| Elevacao de Pernas na Barra | Avancado | Barra fixa |

### Cardio
| Exercicio | Nivel | Equipamento |
|-----------|-------|-------------|
| Corrida (esteira ou rua) | Iniciante | Esteira ou livre |
| Pular Corda | Iniciante | Corda |
| Polichinelo (Jumping Jack) | Iniciante | Sem equipamento |
| Mountain Climber | Iniciante | Sem equipamento |
| Bike Ergometrica | Iniciante | Bicicleta ergometrica |
| Eliptico | Iniciante | Eliptico |
| Burpee | Intermediario | Sem equipamento |
| HIIT (Intervalado de Alta Intensidade) | Avancado | Sem equipamento |
| Box Jump | Avancado | Caixa pliometrica |

---

## Estrutura de Pastas

```
app/
├── (auth)/            # Login e cadastro — sem navbar
│   ├── login/
│   └── cadastro/
├── (onboarding)/      # Anamnese — layout proprio, sem BottomNav
│   └── anamnese/
├── (app)/             # Area protegida com bottom navigation
│   ├── dashboard/     # Resumo do dia: calorias, macros, treino
│   ├── nutricao/      # Plano alimentar, anel calorico, refeicoes
│   │   └── refeicao/[id]/   # Detalhe + adicionar alimentos
│   ├── treino/        # Plano de treino, cards com imagens e videos
│   └── perfil/        # Dados pessoais, metas, medidas corporais
└── api/
    ├── alimentos/buscar/
    ├── nutricao/gerar-plano/
    ├── treino/gerar-plano/
    └── exercicio/imagem/    # Proxy Wger.de + cache no banco

components/
├── layout/
│   └── bottom-nav.tsx        # Navegacao inferior (4 itens)
├── nutricao/
│   └── adicionar-alimento-form.tsx
├── treino/
│   ├── exercicio-card.tsx    # Card expansivel com imagem + video
│   ├── exercicio-imagem.tsx  # Lazy-load via Wger.de + fallback visual
│   └── marcar-treino-btn.tsx
└── perfil/
    ├── logout-btn.tsx
    └── adicionar-medida-form.tsx

lib/
├── supabase/
│   ├── client.ts     # createBrowserClient (use client)
│   └── server.ts     # createServerClient (SSR)
├── calculations.ts   # TMB, GET, macros, splits de treino, series
└── utils.ts          # cn, formatters, calcularIdade, calcularIMC

types/
└── index.ts          # Todos os tipos TypeScript do projeto

supabase/
├── schema.sql                    # Tabelas, RLS policies, triggers
├── seed.sql                      # 60+ alimentos e 34 exercicios base
├── setup.sql                     # schema + seed combinados (use este)
├── criar-admin.sql               # Cria usuario admin
├── update-exercicios-videos.sql  # Links YouTube para exercicios base
└── add-exercicios-v2.sql         # +41 exercicios por nivel de dificuldade

public/
├── manifest.json     # PWA manifest
├── sw.js             # Service Worker (cache-first)
└── icons/            # Icones do PWA (72 a 512px)
```

---

## Configuracao e Setup

### 1. Pre-requisitos

- Node.js 18+
- Conta gratuita no [Supabase](https://supabase.com)
- Conta gratuita no [Vercel](https://vercel.com)

### 2. Variaveis de ambiente

Copie o arquivo de exemplo e preencha com suas chaves:

```bash
cp .env.local.example .env.local
```

```env
NEXT_PUBLIC_SUPABASE_URL=https://xxxxxxxxxxxx.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=sua-anon-key
ANTHROPIC_API_KEY=sk-ant-xxxxxxxxxxxx   # opcional
```

As chaves do Supabase estao em: **Dashboard → Settings → API**

### 3. Banco de dados

No **SQL Editor** do Supabase, execute os arquivos nesta ordem:

```
1. supabase/setup.sql                    → cria tabelas + insere alimentos e exercicios base
2. supabase/criar-admin.sql              → cria usuario admin
3. supabase/update-exercicios-videos.sql → adiciona links YouTube nos exercicios base
4. supabase/add-exercicios-v2.sql        → +41 exercicios por nivel de dificuldade
```

> O `setup.sql` ja combina schema + seed. Basta roda-lo uma vez.

### 4. Rodar localmente

```bash
# Instalar dependencias
npm install

# Iniciar servidor de desenvolvimento
npm run dev

# ou no Windows:
run.bat
```

Acesse: http://localhost:3000

---

## Deploy na Vercel

```bash
# Instalar CLI da Vercel
npm i -g vercel

# Deploy
vercel
```

Ou conecte o repositorio diretamente no painel da Vercel e adicione as variaveis de ambiente nas configuracoes do projeto.

---

## Banco de Dados

### Principais Tabelas

| Tabela | Descricao |
|--------|-----------|
| `profiles` | Dados do usuario (estende auth.users via trigger) |
| `anamneses` | Avaliacao fisica com TMB/GET/macros calculados |
| `planos_nutricionais` | Plano alimentar com metas de macros |
| `refeicoes` | 5 refeicoes do plano com metas por horario |
| `alimentos` | Banco de alimentos — leitura publica (tabela TACO) |
| `refeicao_alimentos` | Composicao de cada refeicao |
| `logs_alimentacao` | Log diario de alimentos consumidos |
| `exercicios` | Banco de exercicios — leitura publica |
| `planos_treino` | Plano de treino gerado automaticamente |
| `dias_treino` | Dias da semana com grupos musculares |
| `dia_exercicios` | Exercicios de cada dia com series/reps/descanso |
| `logs_treino` | Registro de treinos concluidos |
| `medidas_corporais` | Historico de peso e medidas |

Todas as tabelas tem **Row Level Security (RLS)** ativo — cada usuario acessa apenas seus proprios dados.

### Trigger automatico

```sql
-- Cria perfil automaticamente ao cadastrar novo usuario
handle_new_user() → INSERT INTO profiles
```

---

## Sistema de Imagens dos Exercicios

As imagens sao carregadas em cascata:

```
1. gif_url salvo no banco (mais rapido)
   ↓ se nao tiver
2. Wger.de API (gratuita, sem chave)
   buscado pelo nome em ingles via mapeamento PT→EN
   resultado salvo no banco para cache permanente
   ↓ se nao encontrar
3. Fallback visual
   icone colorido por grupo muscular
   (Peito=vermelho, Costas=azul, Pernas=verde, etc.)
```

A rota `/api/exercicio/imagem` gerencia todo esse fluxo.

---

## Calculos Nutricionais

### Equacao de Mifflin-St Jeor (TMB)

```
Homens: TMB = (10 × peso) + (6.25 × altura) − (5 × idade) + 5
Mulheres: TMB = (10 × peso) + (6.25 × altura) − (5 × idade) − 161
```

### Fator de atividade (GET = TMB × fator)

| Nivel | Fator |
|-------|-------|
| Sedentario | 1.2 |
| Levemente ativo | 1.375 |
| Moderadamente ativo | 1.55 |
| Muito ativo | 1.725 |
| Extremamente ativo | 1.9 |

### Ajuste por objetivo

| Objetivo | Ajuste calorico |
|----------|----------------|
| Perder gordura | GET − 20% |
| Ganhar peso | GET + 10% |
| Manter peso | GET |

### Distribuicao de macros

| Objetivo | Proteina | Carboidrato | Gordura |
|----------|----------|-------------|---------|
| Perder gordura | 2.2g/kg | 35% das kcal | 25% das kcal |
| Ganhar peso | 2.0g/kg | 50% das kcal | 25% das kcal |
| Manter peso | 1.8g/kg | 45% das kcal | 25% das kcal |

---

## Fluxo do Usuario

```
Cadastro
    ↓
Anamnese (6 passos)
    ├─ Dados pessoais (nome, nascimento, sexo)
    ├─ Medidas (altura, peso → calcula IMC)
    ├─ Objetivo (perder gordura / ganhar massa / manter)
    ├─ Nivel de atividade (5 opcoes)
    ├─ Disponibilidade (1-6 dias/semana → sugere split)
    └─ Confirmacao (mostra TMB, GET, macros, split)
         ↓
    Sistema gera automaticamente:
    ├─ Plano nutricional com 5 refeicoes
    └─ Plano de treino com exercicios por dia
         ↓
Dashboard → Nutricao / Treino / Perfil
```

---

## PWA — Instalacao no Celular

O FitLife funciona como app nativo via PWA:

**Android (Chrome):** menu → Adicionar a tela inicial

**iOS (Safari):** botao compartilhar → Adicionar a Tela de Inicio

Para gerar os icones PWA, use o arquivo `public/icons/icon.svg` nos tamanhos:

`72 · 96 · 128 · 144 · 192 · 384 · 512` px

Gerador gratuito: [realfavicongenerator.net](https://realfavicongenerator.net)

---

## Usuarios e Acesso

### Admin padrao

| Campo | Valor |
|-------|-------|
| Email | vcsconsult1204@gmail.com |
| Senha | XXXXXXXXX |
| Perfil | Admin (is_admin = true) |

Criado via `supabase/criar-admin.sql`.

---

## Scripts

| Comando | Descricao |
|---------|-----------|
| `npm run dev` | Servidor de desenvolvimento (localhost:3000) |
| `npm run build` | Build de producao |
| `npm run start` | Inicia build de producao |
| `run.bat` | Windows: instala deps se necessario + sobe dev server |
| `setup-banco.bat` | Executa SQL via psql (requer PostgreSQL local) |

---

## Variaveis de Ambiente

| Variavel | Obrigatoria | Descricao |
|----------|-------------|-----------|
| `NEXT_PUBLIC_SUPABASE_URL` | Sim | URL do projeto Supabase |
| `NEXT_PUBLIC_SUPABASE_ANON_KEY` | Sim | Chave anonima publica do Supabase |
| `ANTHROPIC_API_KEY` | Nao | Chave da API Claude (funcionalidades de IA) |

---

## Dependencias Principais

```json
{
  "next": "15.x",
  "react": "19.x",
  "@supabase/supabase-js": "auth + banco de dados",
  "@supabase/ssr": "SSR com cookies",
  "tailwindcss": "estilizacao",
  "lucide-react": "icones",
  "sonner": "notificacoes toast",
  "react-hook-form": "formularios",
  "zod": "validacao de schemas",
  "recharts": "graficos de evolucao",
  "framer-motion": "animacoes",
  "@anthropic-ai/sdk": "integracao Claude AI"
}
```
