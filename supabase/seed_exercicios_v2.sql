-- ============================================================
-- Exercícios expandidos — 120+ exercícios com GIF URLs
-- Execute no Supabase SQL Editor
-- ============================================================

-- Garante constraint única no nome
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conrelid = 'public.exercicios'::regclass
    AND conname = 'exercicios_nome_key'
  ) THEN
    ALTER TABLE public.exercicios ADD CONSTRAINT exercicios_nome_key UNIQUE (nome);
  END IF;
END $$;

INSERT INTO public.exercicios
  (nome, grupo_muscular, musculo_primario, musculos_secundarios, tipo, equipamento, instrucoes, dicas, dificuldade, gif_url)
VALUES

-- ============================================================
-- PEITO
-- ============================================================
('Supino Reto com Barra','Peito','Peitoral maior',ARRAY['Deltóide anterior','Tríceps'],'composto','Barra + Banco',
'1. Deite no banco com os pés no chão\n2. Segure a barra na largura dos ombros\n3. Desça até tocar o peito\n4. Empurre de volta',
'Mantenha as escápulas retraídas. Não solte os cotovelos excessivamente.','intermediario',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Barbell-Bench-Press.gif'),

('Supino Inclinado com Barra','Peito','Peitoral maior (porção superior)',ARRAY['Deltóide anterior','Tríceps'],'composto','Barra + Banco inclinado',
'1. Incline o banco em 30-45°\n2. Segure a barra na largura dos ombros\n3. Desça até o peito\n4. Empurre de volta',
'Ângulo de 30° foca mais no peitoral superior. Evite arqueamento excessivo.','intermediario',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Incline-Barbell-Bench-Press.gif'),

('Supino com Halteres','Peito','Peitoral maior',ARRAY['Deltóide anterior','Tríceps'],'composto','Halteres + Banco',
'1. Deite com halteres na altura do peito\n2. Empurre até extensão total\n3. Retorne controladamente',
'Halteres permitem maior amplitude. Mantenha os cotovelos levemente abaixo do ombro.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Dumbbell-Press-1.gif'),

('Supino Inclinado com Halteres','Peito','Peitoral maior (porção superior)',ARRAY['Deltóide anterior','Tríceps'],'composto','Halteres + Banco inclinado',
'1. Incline o banco em 30-45°\n2. Segure os halteres na altura do peito\n3. Empurre até a extensão total\n4. Retorne controladamente',
'Ângulo menor que 45° foca mais no peitoral superior.','intermediario',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Incline-Dumbbell-Press.gif'),

('Supino Declinado com Halteres','Peito','Peitoral maior (porção inferior)',ARRAY['Tríceps'],'composto','Halteres + Banco declinado',
'1. Deite no banco declinado\n2. Segure os halteres na altura do peito\n3. Empurre até extensão\n4. Retorne com controle',
'Trabalha principalmente o peitoral inferior. Use cinto de segurança no banco.','intermediario',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Decline-Dumbbell-Press.gif'),

('Crucifixo com Halteres','Peito','Peitoral maior',ARRAY['Deltóide anterior'],'isolamento','Halteres + Banco',
'1. Deite no banco segurando os halteres\n2. Abra os braços em arco com leve flexão nos cotovelos\n3. Sinta o alongamento\n4. Feche em arco',
'Não abra demais para evitar lesão. Leve flexão fixa no cotovelo durante o movimento.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Dumbbell-Fly.gif'),

('Crucifixo Inclinado com Halteres','Peito','Peitoral maior (porção superior)',ARRAY['Deltóide anterior'],'isolamento','Halteres + Banco inclinado',
'1. Incline o banco em 30°\n2. Abra os braços em arco\n3. Sinta o alongamento no peitoral superior\n4. Feche em arco',
'Ótimo para definição do peitoral superior. Controle total na descida.','intermediario',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Incline-dumbbell-Fly.gif'),

('Pec Deck / Voador','Peito','Peitoral maior',ARRAY['Deltóide anterior'],'isolamento','Máquina peck deck',
'1. Sente-se na máquina com cotovelos nos apoios\n2. Feche os braços à frente contraindo o peitoral\n3. Retorne controladamente',
'Excelente isolamento do peitoral. Não use carga excessiva.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Pec-Deck-Fly.gif'),

('Crossover no Cabo','Peito','Peitoral maior',ARRAY['Deltóide anterior'],'isolamento','Cabo cruzado',
'1. Posicione-se no centro do cabo cruzado\n2. Puxe os cabos em arco até a frente\n3. Contraia o peitoral\n4. Retorne com controle',
'Excelente para o "finishing" do peito. Varie a altura para focar em diferentes porções.','intermediario',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Cable-Crossover.gif'),

('Crossover Baixo no Cabo','Peito','Peitoral maior (porção superior)',ARRAY['Deltóide anterior'],'isolamento','Cabo baixo',
'1. Posicione as polias na posição baixa\n2. Puxe os cabos para cima em arco\n3. Contraia o peitoral superior',
'Foca no peitoral superior. Combine com exercícios de cabo alto para cobertura completa.','intermediario',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Low-Cable-Crossover.gif'),

('Pullover com Halter','Peito','Peitoral maior',ARRAY['Grande dorsal','Serrátil'],'isolamento','Halter + Banco',
'1. Deite com os ombros no banco\n2. Segure o halter sobre o peito com as duas mãos\n3. Abaixe o halter atrás da cabeça\n4. Retorne à posição inicial',
'Mantém o quadril baixo. Expande a caixa torácica. Ótimo para iniciantes.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Dumbbell-Pullover.gif'),

('Flexão de Braço','Peito','Peitoral maior',ARRAY['Tríceps','Deltóide anterior','Core'],'composto','Sem equipamento',
'1. Posição de prancha com mãos na largura dos ombros\n2. Desça o corpo até o peito quase tocar o chão\n3. Empurre de volta\n4. Mantenha o corpo reto',
'Evite que o quadril suba ou desça. Variações: pés elevados (superior), mãos abertas (externo).','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Push-Up.gif'),

('Supino no Smith','Peito','Peitoral maior',ARRAY['Deltóide anterior','Tríceps'],'composto','Smith machine',
'1. Deite no banco sob a barra do Smith\n2. Desça a barra até o peito\n3. Empurre até extensão',
'Boa opção para treinar sem parceiro. Trajetória fixa pode ser vantagem ou limitação.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/06/Smith-Machine-Bench-Press.gif'),

('Supino Inclinado na Máquina','Peito','Peitoral maior (porção superior)',ARRAY['Deltóide anterior','Tríceps'],'composto','Máquina de supino inclinado',
'1. Ajuste o assento\n2. Agarre as alças na altura do peito\n3. Empurre até extensão\n4. Retorne com controle',
'Máquina oferece mais segurança e isolamento. Ótima opção para finalização.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/06/Lever-Incline-Chest-Press.gif'),

('Mergulho no Peito (Chest Dip)','Peito','Peitoral maior (porção inferior)',ARRAY['Tríceps','Deltóide anterior'],'composto','Paralelas',
'1. Apoie-se nas paralelas\n2. Incline o tronco levemente para frente\n3. Desça até os ombros ficarem abaixo dos cotovelos\n4. Empurre de volta',
'Inclinação do tronco para frente direciona o esforço para o peito.','intermediario',
'https://fitnessprogramer.com/wp-content/uploads/2021/06/Chest-Dips.gif'),

-- ============================================================
-- COSTAS
-- ============================================================
('Barra Fixa','Costas','Grande dorsal',ARRAY['Bíceps','Infraespinhoso','Core'],'composto','Barra fixa',
'1. Pegada pronada na largura dos ombros\n2. Parta de braços estendidos\n3. Puxe até o queixo ultrapassar a barra\n4. Desça com controle',
'Cruze os pés e mantenha o core ativado.','avancado',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Pull-up.gif'),

('Puxada Frontal com Barra','Costas','Grande dorsal',ARRAY['Bíceps','Romboides','Infraespinhoso'],'composto','Polia alta',
'1. Sente-se com as coxas sob os apoios\n2. Puxe a barra até o queixo\n3. Retorne controladamente',
'Incline levemente o tronco. Concentre em puxar pelos cotovelos.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Lat-Pulldown.gif'),

('Puxada Inversa','Costas','Grande dorsal',ARRAY['Bíceps','Romboides'],'composto','Polia alta',
'1. Pegada supinada na barra da polia alta\n2. Puxe até o queixo\n3. Retorne controladamente',
'A pegada supinada ativa mais o bíceps e facilita a rotação da escápula.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/04/Reverse-Lat-Pulldown.gif'),

('Chin-up (Barra Fixa Supinada)','Costas','Grande dorsal',ARRAY['Bíceps','Romboides'],'composto','Barra fixa',
'1. Pegada supinada na barra\n2. Parta de braços estendidos\n3. Puxe até o queixo ultrapassar a barra\n4. Desça com controle',
'Mais fácil que a barra pronada — ativa mais o bíceps. Ótimo para iniciantes.','intermediario',
'https://fitnessprogramer.com/wp-content/uploads/2021/04/Reverse-grip-Pull-up.gif'),

('Remada Curvada com Barra','Costas','Grande dorsal',ARRAY['Trapézio','Romboides','Bíceps'],'composto','Barra',
'1. Curvatura de 45° no quadril\n2. Puxe a barra em direção ao umbigo\n3. Contraia as escápulas no topo\n4. Retorne',
'Mantenha a coluna neutra. Não balance o tronco.','intermediario',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Barbell-Bent-Over-Row.gif'),

('Remada com Barra Pegada Invertida','Costas','Grande dorsal',ARRAY['Bíceps','Romboides'],'composto','Barra',
'1. Segure a barra com pegada supinada\n2. Curvatura de 45° no quadril\n3. Puxe em direção ao abdômen\n4. Contraia escápulas',
'Pegada invertida ativa mais o bíceps e pode ser mais confortável para os pulsos.','intermediario',
'https://fitnessprogramer.com/wp-content/uploads/2021/04/Reverse-Grip-Barbell-Row.gif'),

('Remada Unilateral com Halter','Costas','Grande dorsal',ARRAY['Romboides','Bíceps','Trapézio médio'],'composto','Halter + Banco',
'1. Apoie joelho e mão no banco\n2. Segure o halter com braço estendido\n3. Puxe até o quadril\n4. Retorne',
'Mantenha o cotovelo próximo ao corpo. Gire levemente o tronco para maximizar amplitude.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Dumbbell-Row.gif'),

('Remada Sentada no Cabo','Costas','Grande dorsal',ARRAY['Romboides','Bíceps','Trapézio médio'],'composto','Cabo baixo',
'1. Sente-se na máquina com os pés nos apoios\n2. Puxe o cabo em direção ao abdômen\n3. Contraia as escápulas\n4. Retorne com controle',
'Evite arredondar as costas. Mantenha o tronco ereto durante o movimento.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Seated-Cable-Row.gif'),

('Remada T-Bar','Costas','Grande dorsal',ARRAY['Romboides','Trapézio','Bíceps'],'composto','T-Bar / Barra ancorada',
'1. Posicione-se sobre a barra ancorada\n2. Curvatura de 45°\n3. Puxe a barra até o peito\n4. Retorne controladamente',
'Excelente para espessura das costas. Mantenha a coluna neutra.','intermediario',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Lever-T-bar-Row.gif'),

('Levantamento Terra','Costas','Grande dorsal',ARRAY['Glúteos','Isquiotibiais','Quadríceps','Core','Trapézio'],'composto','Barra',
'1. Pés na largura do quadril, barra sobre o médio-pé\n2. Curvatura com quadril para trás\n3. Levante mantendo a barra rente ao corpo\n4. Estenda quadril e joelhos simultâneo',
'Rei dos exercícios compostos. Coluna neutra sempre. Nunca arredonde a lombar.','avancado',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Barbell-Deadlift.gif'),

('Levantamento Terra Sumô','Costas','Grande dorsal',ARRAY['Glúteos','Adutores','Quadríceps'],'composto','Barra',
'1. Pés mais afastados que a largura dos ombros, pontas para fora\n2. Agarre a barra por dentro dos joelhos\n3. Levante estendendo quadril e joelhos',
'Maior ativação dos adutores e glúteos que o convencional. Boa opção para quem tem quadril largo.','avancado',
'https://fitnessprogramer.com/wp-content/uploads/2021/04/Barbell-Sumo-Deadlift.gif'),

('Pullover com Barra','Costas','Grande dorsal',ARRAY['Peitoral maior','Serrátil','Tríceps'],'isolamento','Barra + Banco',
'1. Deite com ombros no banco\n2. Segure a barra com pegada fechada\n3. Abaixe atrás da cabeça\n4. Retorne à posição inicial',
'Movimento multiarticular que expande a caixa torácica e ativa costas e peito.','intermediario',
'https://fitnessprogramer.com/wp-content/uploads/2021/04/Barbell-Bent-Arm-Pullover.gif'),

('Remada Sentada na Máquina','Costas','Grande dorsal',ARRAY['Romboides','Bíceps'],'composto','Máquina de remada',
'1. Ajuste o assento\n2. Agarre as alças\n3. Puxe em direção ao abdômen\n4. Retorne com controle',
'Boa opção para iniciantes. Trajetória guiada facilita a execução correta.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Seated-Row-Machine.gif'),

('Remada Alta no Cabo Unilateral','Costas','Grande dorsal',ARRAY['Romboides','Bíceps'],'composto','Polia alta',
'1. Agarre a polia alta com uma mão\n2. Puxe até o peito\n3. Contraia a escápula\n4. Retorne com controle',
'Permite maior amplitude unilateral. Ótimo para corrigir assimetrias.','intermediario',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/One-arm-Cable-Row.gif'),

('Puxada Braço Estendido no Cabo','Costas','Grande dorsal',ARRAY['Serrátil'],'isolamento','Polia alta',
'1. Em pé, segure a barra alta com braços estendidos\n2. Puxe para baixo até as coxas mantendo braços retos\n3. Retorne com controle',
'Excelente para isolamento do latíssimo sem envolvimento de bíceps.','intermediario',
'https://fitnessprogramer.com/wp-content/uploads/2021/05/Cable-Straight-Arm-Pulldown.gif'),

-- ============================================================
-- OMBROS
-- ============================================================
('Desenvolvimento com Halteres','Ombros','Deltóide medial',ARRAY['Deltóide anterior','Trapézio','Tríceps'],'composto','Halteres',
'1. Sente-se com halteres na altura dos ombros\n2. Empurre para cima até quase estender os braços\n3. Retorne controladamente',
'Leve flexão no topo protege os ombros.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Dumbbell-Shoulder-Press.gif'),

('Desenvolvimento com Barra Sentado','Ombros','Deltóide medial',ARRAY['Deltóide anterior','Trapézio','Tríceps'],'composto','Barra + Banco',
'1. Sente-se com a barra na altura dos ombros\n2. Empurre até extensão\n3. Retorne controladamente',
'Permite maior carga que os halteres. Mantenha o core ativado.','intermediario',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Barbell-Shoulder-Press.gif'),

('Desenvolvimento Militar com Barra','Ombros','Deltóide medial',ARRAY['Deltóide anterior','Trapézio','Tríceps','Core'],'composto','Barra',
'1. Em pé, barra na altura dos ombros\n2. Empurre até extensão total acima da cabeça\n3. Retorne controladamente',
'Exercício funcional que ativa o core. Não arqueie a lombar.','avancado',
'https://fitnessprogramer.com/wp-content/uploads/2021/07/Barbell-Standing-Military-Press.gif'),

('Desenvolvimento Arnold','Ombros','Deltóide',ARRAY['Tríceps','Trapézio'],'composto','Halteres',
'1. Inicie com halteres à frente, palmas viradas para você\n2. Ao empurrar, gire os pulsos para fora\n3. Complete com palmas para frente no topo\n4. Reverta na descida',
'Criado por Arnold Schwarzenegger. Trabalha todas as porções do deltóide.','intermediario',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Arnold-Press.gif'),

('Elevação Lateral','Ombros','Deltóide medial',ARRAY['Trapézio superior'],'isolamento','Halteres',
'1. Em pé, segure halteres ao lado do corpo\n2. Eleve os braços lateralmente até a altura dos ombros\n3. Pause\n4. Desça controladamente',
'Imagine que está despejando água de uma jarra. Use cargas leves.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Dumbbell-Lateral-Raise.gif'),

('Elevação Lateral Sentado','Ombros','Deltóide medial',ARRAY['Trapézio superior'],'isolamento','Halteres',
'1. Sente-se em um banco\n2. Eleve os halteres lateralmente\n3. Contraia no topo\n4. Desça com controle',
'Sentado elimina o balanço do corpo, aumentando o isolamento.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/04/Seated-Dumbbell-Lateral-Raise.gif'),

('Elevação Lateral no Cabo','Ombros','Deltóide medial',ARRAY['Trapézio superior'],'isolamento','Cabo lateral',
'1. Posicione-se ao lado do cabo\n2. Eleve o cabo lateralmente\n3. Contraia no topo\n4. Desça com controle',
'O cabo mantém tensão constante no músculo durante todo o movimento.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Cable-Lateral-Raise.gif'),

('Elevação Frontal','Ombros','Deltóide anterior',ARRAY['Peitoral superior'],'isolamento','Halteres ou Barra',
'1. Em pé, segure os halteres à frente\n2. Eleve um braço até a altura dos ombros\n3. Pause\n4. Desça e alterne',
'Mantenha leve flexão no cotovelo. Alternando é mais eficiente.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Dumbbell-Front-Raise.gif'),

('Elevação Frontal no Cabo','Ombros','Deltóide anterior',ARRAY['Peitoral superior'],'isolamento','Cabo baixo',
'1. De costas para o cabo baixo\n2. Eleve o cabo à frente até a altura dos ombros\n3. Retorne com controle',
'Tensão constante do cabo beneficia a contração do deltóide anterior.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Cable-Front-Raise.gif'),

('Voador Invertido Sentado','Ombros','Deltóide posterior',ARRAY['Romboides','Trapézio'],'isolamento','Halteres',
'1. Sente-se inclinado para frente\n2. Eleve os halteres para os lados em arco\n3. Contraia no topo\n4. Desça com controle',
'Excelente para deltóide posterior — frequentemente negligenciado. Use cargas leves.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Seated-Rear-Lateral-Dumbbell-Raise.gif'),

-- ============================================================
-- BÍCEPS
-- ============================================================
('Rosca Direta com Barra','Bíceps','Bíceps braquial',ARRAY['Braquial','Braquiorradial'],'isolamento','Barra',
'1. Em pé, pegada supinada\n2. Flexione os cotovelos trazendo a barra até os ombros\n3. Contraia no topo\n4. Desça controladamente',
'Cotovelos fixos ao lado do corpo. Não use impulso.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Barbell-Curl.gif'),

('Rosca com Halter','Bíceps','Bíceps braquial',ARRAY['Braquial','Braquiorradial'],'isolamento','Halteres',
'1. Em pé, halteres ao lado do corpo\n2. Curl alternado ou simultâneo\n3. Contraia no topo\n4. Desça controladamente',
'Halteres permitem supinação do pulso no topo — máxima contração do bíceps.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Dumbbell-Curl.gif'),

('Rosca Martelo','Bíceps','Braquial',ARRAY['Bíceps','Braquiorradial'],'isolamento','Halteres',
'1. Em pé, pegada neutra\n2. Flexione um braço de cada vez\n3. Mantenha o pulso neutro\n4. Alterne os braços',
'A pegada neutra enfatiza o braquial, dando pico ao bíceps.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Hammer-Curl.gif'),

('Rosca Martelo Sentado','Bíceps','Braquial',ARRAY['Bíceps','Braquiorradial'],'isolamento','Halteres',
'1. Sente-se em um banco\n2. Rosca martelo alternada\n3. Mantenha o cotovelo fixo\n4. Contraia no topo',
'Sentado elimina o balanço do corpo.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/04/Seated-Hammer-Curl.gif'),

('Rosca Concentrada','Bíceps','Bíceps braquial',ARRAY['Braquial'],'isolamento','Halter',
'1. Sente-se com o cotovelo apoiado na coxa interna\n2. Curl concentrando no bíceps\n3. Contraia fortemente no topo\n4. Desça lentamente',
'Excelente para isolamento e pico de contração.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Concentration-Curl.gif'),

('Rosca Scott com Barra EZ','Bíceps','Bíceps braquial',ARRAY['Braquial'],'isolamento','Barra EZ + Scott',
'1. Apoie os braços no banco scott\n2. Segure a barra EZ com pegada supinada\n3. Curle até os ombros\n4. Desça com controle total',
'O banco scott elimina o balanço do corpo. A barra EZ reduz pressão nos pulsos.','intermediario',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Z-Bar-Preacher-Curl.gif'),

('Rosca Scott com Halter','Bíceps','Bíceps braquial',ARRAY['Braquial'],'isolamento','Halter + Scott',
'1. Apoie o braço no banco scott\n2. Curle o halter\n3. Contraia no topo\n4. Desça com controle total',
'Permite trabalho unilateral. Ótimo para corrigir assimetrias.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Dumbbell-Preacher-Curl.gif'),

('Rosca Inclinada com Halter','Bíceps','Bíceps braquial',ARRAY['Braquial'],'isolamento','Halteres + Banco inclinado',
'1. Recline no banco a 45°\n2. Braços caem naturalmente para trás\n3. Curl acentuando o alongamento\n4. Contraia no topo',
'O alongamento extra aumenta a amplitude e o estímulo no bíceps.','intermediario',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Seated-Incline-Dumbbell-Curl.gif'),

('Rosca Unilateral no Cabo','Bíceps','Bíceps braquial',ARRAY['Braquial'],'isolamento','Cabo baixo',
'1. Agarre o cabo com uma mão\n2. Curl mantendo o cotovelo fixo\n3. Contraia no topo\n4. Retorne com controle',
'O cabo mantém tensão constante — excelente para isolamento.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/One-Arm-Cable-Curl.gif'),

('Rosca Zottman','Bíceps','Bíceps braquial',ARRAY['Braquiorradial','Braquial'],'isolamento','Halteres',
'1. Curl supinado na subida\n2. Rotacione para pronado no topo\n3. Desça pronado\n4. Rotacione para supinado embaixo',
'Trabalha bíceps na subida e braquiorradial na descida em um único movimento.','intermediario',
'https://fitnessprogramer.com/wp-content/uploads/2021/04/zottman-curl.gif'),

('Rosca Inversa com Halter','Bíceps','Braquiorradial',ARRAY['Bíceps','Antebraço'],'isolamento','Halteres',
'1. Pegada pronada nos halteres\n2. Curl mantendo o pulso neutro\n3. Contraia no topo\n4. Desça controladamente',
'Foca no braquiorradial e antebraços. Complementa bem as roscas convencionais.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/04/dumbbell-reverse-curl.gif'),

-- ============================================================
-- TRÍCEPS
-- ============================================================
('Tríceps Pulley','Tríceps','Tríceps braquial',ARRAY['Anconeu'],'isolamento','Polia alta',
'1. Em pé, segure a corda ou barra da polia alta\n2. Cotovelos fixos ao lado do corpo\n3. Estenda os braços completamente\n4. Retorne controladamente',
'No final da extensão com corda, abra-a para maximizar contração.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Pushdown.gif'),

('Tríceps Pulley Unilateral','Tríceps','Tríceps braquial',ARRAY['Anconeu'],'isolamento','Polia alta',
'1. Agarre o cabo com uma mão\n2. Cotovelo fixo ao lado do corpo\n3. Estenda completamente\n4. Retorne com controle',
'Trabalho unilateral permite maior foco e amplitude.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2022/11/One-arm-triceps-pushdown.gif'),

('Tríceps Corda Acima da Cabeça','Tríceps','Tríceps braquial (cabeça longa)',ARRAY['Anconeu'],'isolamento','Cabo com corda',
'1. De costas para a polia alta, segure a corda atrás da cabeça\n2. Estenda os braços acima da cabeça\n3. Retorne com controle',
'Máxima ativação da cabeça longa do tríceps — a maior porção do músculo.','intermediario',
'https://fitnessprogramer.com/wp-content/uploads/2021/04/Cable-Rope-Overhead-Triceps-Extension.gif'),

('Tríceps Testa com Barra (Skull Crusher)','Tríceps','Tríceps braquial',ARRAY['Anconeu'],'isolamento','Barra + Banco',
'1. Deite no banco com a barra acima do peito\n2. Flexione os cotovelos abaixando a barra até a testa\n3. Estenda de volta',
'Cotovelos fixos — apenas os antebraços se movem. Controle total na descida.','intermediario',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Barbell-Triceps-Extension.gif'),

('Tríceps Testa com Halter (Skull Crusher)','Tríceps','Tríceps braquial',ARRAY['Anconeu'],'isolamento','Halteres + Banco',
'1. Deite com halteres acima do peito\n2. Flexione os cotovelos abaixando até a testa\n3. Estenda de volta',
'Os halteres permitem rotação natural dos pulsos — mais confortável.','intermediario',
'https://fitnessprogramer.com/wp-content/uploads/2021/06/Dumbbell-Skull-Crusher.gif'),

('Tríceps Francês com Halter','Tríceps','Tríceps braquial (cabeça longa)',ARRAY['Anconeu'],'isolamento','Halter',
'1. Sente-se segurando um halter acima da cabeça com as duas mãos\n2. Flexione os cotovelos abaixando atrás da cabeça\n3. Estenda de volta',
'Máxima amplitude para a cabeça longa. Mantenha os cotovelos apontando para cima.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/06/Seated-Dumbbell-Triceps-Extension.gif'),

('Tríceps Coice com Halter','Tríceps','Tríceps braquial',ARRAY['Anconeu'],'isolamento','Halter',
'1. Apoie-se em um banco\n2. Cotovelo paralelo ao tronco\n3. Estenda o braço para trás\n4. Retorne com controle',
'Ótimo isolamento do tríceps. Mantenha o cotovelo estático.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Dumbbell-Kickback.gif'),

('Supino Fechado','Tríceps','Tríceps braquial',ARRAY['Peitoral','Deltóide anterior'],'composto','Barra',
'1. Deite no banco com pegada estreita\n2. Desça a barra controladamente até o peito\n3. Empurre focando nos tríceps',
'Pegada um pouco mais estreita que os ombros. Muito estreita causa dor no pulso.','intermediario',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Close-Grip-Bench-Press.gif'),

('Mergulho em Banco (Tricep Dip)','Tríceps','Tríceps braquial',ARRAY['Peitoral inferior','Deltóide anterior'],'composto','Banco',
'1. Apoie as mãos no banco atrás de você\n2. Pés no chão ou em outro banco\n3. Desça flexionando os cotovelos\n4. Empurre de volta',
'Para focar no tríceps, mantenha o corpo próximo ao banco.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Bench-Dips.gif'),

('Tríceps nas Paralelas','Tríceps','Tríceps braquial',ARRAY['Deltóide anterior','Peitoral'],'composto','Paralelas',
'1. Apoie-se nas paralelas com tronco reto\n2. Desça flexionando os cotovelos até 90°\n3. Empurre de volta',
'Tronco reto foca no tríceps. Inclinado foca no peito.','intermediario',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Triceps-Dips.gif'),

-- ============================================================
-- PERNAS
-- ============================================================
('Agachamento com Barra','Pernas','Quadríceps',ARRAY['Glúteos','Isquiotibiais','Lombar','Core'],'composto','Barra + Rack',
'1. Barra apoiada nos trapézios, pés na largura dos ombros\n2. Desça como se fosse sentar\n3. Joelhos acompanham os pés\n4. Suba mantendo coluna neutra',
'Rei dos exercícios. Desça até as coxas ficarem paralelas. Respire fundo antes de descer.','intermediario',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/BARBELL-SQUAT.gif'),

('Agachamento no Smith','Pernas','Quadríceps',ARRAY['Glúteos','Isquiotibiais'],'composto','Smith machine',
'1. Posicione os pés ligeiramente à frente\n2. Desça até as coxas ficarem paralelas\n3. Empurre de volta',
'A trajetória guiada permite variar a posição dos pés. Boa opção para iniciantes.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2024/10/smith-machine-squat.gif'),

('Agachamento com Halteres','Pernas','Quadríceps',ARRAY['Glúteos','Isquiotibiais'],'composto','Halteres',
'1. Halteres ao lado do corpo\n2. Pés na largura dos ombros\n3. Desça até coxas paralelas\n4. Empurre pelos calcanhares',
'Bom para iniciantes aprenderem o padrão de movimento. Sem necessidade de rack.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2023/09/Dumbbell-Squat.gif'),

('Agachamento Goblet com Halter','Pernas','Quadríceps',ARRAY['Glúteos','Core'],'composto','Halter',
'1. Segure o halter verticalmente na frente do peito\n2. Pés na largura dos ombros\n3. Desça profundo\n4. Empurre pelos calcanhares',
'Excelente para aprender o agachamento. Peso na frente facilita postura ereta.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2023/01/Dumbbell-Goblet-Squat.gif'),

('Agachamento Sumô com Barra','Pernas','Adutores',ARRAY['Glúteos','Quadríceps'],'composto','Barra',
'1. Pés mais afastados, pontas viradas para fora\n2. Desça mantendo o tronco ereto\n3. Empurre pelos calcanhares',
'Foca nos adutores e glúteos. Ótimo para pessoas com quadril largo.','intermediario',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Barbell-sumo-squat.gif'),

('Agachamento Hack na Máquina','Pernas','Quadríceps',ARRAY['Glúteos','Isquiotibiais'],'composto','Hack squat machine',
'1. Posicione os ombros nos apoios\n2. Pés na plataforma na largura dos ombros\n3. Desça até 90°\n4. Empurre de volta',
'Posição dos pés mais à frente = mais glúteos. Ótimo volume de quadríceps.','intermediario',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Sled-Hack-Squat.gif'),

('Leg Press 45°','Pernas','Quadríceps',ARRAY['Glúteos','Isquiotibiais','Adutores'],'composto','Leg Press',
'1. Pés na plataforma na largura dos ombros\n2. Solte os travas\n3. Desça até 90° nos joelhos\n4. Empurre sem travar os joelhos',
'Pés mais altos = mais glúteo. Mais baixos = mais quadríceps. Não trave os joelhos.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2015/11/Leg-Press.gif'),

('Extensora (Leg Extension)','Pernas','Quadríceps',ARRAY['Vasto lateral','Vasto medial'],'isolamento','Máquina',
'1. Sente-se com o encosto nas coxas\n2. Estenda as pernas completamente\n3. Contraia no topo\n4. Desça controladamente',
'Exercício de isolamento para quadríceps. Ótimo finalizador.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/LEG-EXTENSION.gif'),

('Flexora (Leg Curl)','Pernas','Isquiotibiais',ARRAY['Gastrocnêmio'],'isolamento','Máquina',
'1. Deite com calcanhares sob o rolo\n2. Flexione os joelhos\n3. Contraia no topo\n4. Desça lentamente',
'Flexão máxima = maior contração. Versão sentada aumenta amplitude.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Leg-Curl.gif'),

('Flexora Sentado (Seated Leg Curl)','Pernas','Isquiotibiais',ARRAY['Gastrocnêmio'],'isolamento','Máquina sentado',
'1. Sente-se com as coxas apoiadas\n2. Flexione os joelhos trazendo os calcanhares\n3. Contraia no topo\n4. Retorne com controle',
'A posição sentada aumenta o pré-estiramento dos isquiotibiais.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/08/Seated-Leg-Curl.gif'),

('Stiff (Romanian Deadlift)','Pernas','Isquiotibiais',ARRAY['Glúteos','Lombar'],'composto','Barra ou Halteres',
'1. Em pé, segure a barra na frente\n2. Empurre o quadril para trás descendo a barra\n3. Sinta o alongamento nos isquiotibiais\n4. Retorne contraindo o glúteo',
'Não é levantamento terra. Joelhos levemente flexionados, barra próxima ao corpo.','intermediario',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Barbell-Romanian-Deadlift.gif'),

('Avanço com Halteres','Pernas','Quadríceps',ARRAY['Glúteos','Isquiotibiais'],'composto','Halteres',
'1. Em pé com halteres ao lado\n2. Dê um passo à frente\n3. Desça até o joelho traseiro quase tocar o chão\n4. Empurre de volta',
'Mantenha o tronco ereto. Joelho da frente não ultrapasse os dedos dos pés.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Dumbbell-Lunge.gif'),

('Avanço Caminhando com Halteres','Pernas','Quadríceps',ARRAY['Glúteos','Isquiotibiais','Core'],'composto','Halteres',
'1. Halteres ao lado do corpo\n2. Dê um passo à frente e desça\n3. Traga o pé traseiro para frente\n4. Continue alternando',
'Excelente para condicionamento e força funcional.','intermediario',
'https://fitnessprogramer.com/wp-content/uploads/2023/09/dumbbell-lunges.gif'),

('Agachamento Búlgaro','Pernas','Quadríceps',ARRAY['Glúteos','Isquiotibiais','Adutores'],'composto','Halteres + Banco',
'1. Pé de trás apoiado no banco\n2. Pé da frente afastado o suficiente\n3. Desça até a coxa da frente ficar paralela\n4. Empurre com o calcanhar',
'Excelente para glúteos e força unilateral. Corrige assimetrias.','avancado',
'https://fitnessprogramer.com/wp-content/uploads/2021/05/Barbell-Bulgarian-Split-Squat.gif'),

('Good Morning com Barra','Pernas','Isquiotibiais',ARRAY['Glúteos','Lombar'],'composto','Barra',
'1. Barra apoiada nos trapézios\n2. Joelhos levemente flexionados\n3. Incline o tronco para frente empurrando o quadril\n4. Retorne',
'Fortalece a cadeia posterior. Comece com cargas leves para aprender o padrão.','intermediario',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Barbell-Good-Morning.gif'),

-- ============================================================
-- GLÚTEOS
-- ============================================================
('Hip Thrust com Barra','Glúteos','Glúteo máximo',ARRAY['Isquiotibiais','Core'],'composto','Barra + Banco',
'1. Costas apoiadas no banco, barra sobre o quadril\n2. Pés no chão na largura dos ombros\n3. Empurre o quadril para cima contraindo o glúteo\n4. Mantenha o core ativado',
'Melhor exercício para glúteo. Use acolchoamento na barra.','intermediario',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Barbell-Hip-Thrust.gif'),

('Elevação Pélvica (Glute Bridge)','Glúteos','Glúteo máximo',ARRAY['Isquiotibiais','Core'],'composto','Peso corporal ou anilha',
'1. Deitado no chão, joelhos flexionados\n2. Empurre o quadril para cima\n3. Contraia o glúteo no topo\n4. Desça controladamente',
'Versão mais acessível do Hip Thrust. Pode adicionar peso no quadril.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Glute-Bridge-.gif'),

('Hip Thrust Unilateral com Halter','Glúteos','Glúteo máximo',ARRAY['Isquiotibiais'],'composto','Halter + Banco',
'1. Costas no banco, halter no quadril\n2. Um pé no chão, outro elevado\n3. Empurre o quadril unilateralmente\n4. Contraia o glúteo',
'Excelente para corrigir assimetrias nos glúteos.','intermediario',
'https://fitnessprogramer.com/wp-content/uploads/2025/03/Single-Leg-Dumbbell-Hip-Thrust.gif'),

('Avanço Cruzado (Curtsy Lunge)','Glúteos','Glúteo médio',ARRAY['Glúteo máximo','Adutores','Quadríceps'],'composto','Peso corporal ou halteres',
'1. Em pé, leve o pé para trás e para o lado cruzando\n2. Desça flexionando os joelhos\n3. Retorne à posição inicial\n4. Alterne as pernas',
'Excelente para glúteo médio — frequentemente esquecido nos treinos.','intermediario',
'https://fitnessprogramer.com/wp-content/uploads/2023/09/curtsy-lunge.gif'),

-- ============================================================
-- PANTURRILHA
-- ============================================================
('Panturrilha em Pé','Pernas','Gastrocnêmio',ARRAY['Sóleo'],'isolamento','Máquina ou degrau',
'1. Em pé com a ponta dos pés no degrau\n2. Suba na ponta dos pés\n3. Contraia no topo\n4. Desça abaixo da linha do degrau',
'Amplitude completa é fundamental. Progride cargas.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/06/Standing-Calf-Raise.gif'),

('Panturrilha em Pé com Halter','Panturrilha','Gastrocnêmio',ARRAY['Sóleo'],'isolamento','Halter + degrau',
'1. Em pé em um degrau segurando um halter\n2. Suba na ponta dos pés\n3. Contraia no topo\n4. Desça abaixo da linha',
'Halter adiciona carga extra. Pode fazer unilateral para maior isolamento.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Dumbbell-Calf-Raise.gif'),

('Panturrilha Sentado na Máquina','Panturrilha','Sóleo',ARRAY['Gastrocnêmio'],'isolamento','Máquina de panturrilha sentado',
'1. Sente-se com os joelhos sob os apoios\n2. Suba na ponta dos pés\n3. Contraia no topo\n4. Desça abaixo da linha',
'A posição sentada muda o foco para o sóleo (músculo profundo da panturrilha).','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/06/Lever-Seated-Calf-Raise.gif'),

('Panturrilha no Leg Press','Panturrilha','Gastrocnêmio',ARRAY['Sóleo'],'isolamento','Leg Press',
'1. No leg press, posicione apenas a ponta dos pés\n2. Empurre a plataforma com a ponta dos pés\n3. Contraia no topo\n4. Retorne',
'Permite cargas muito elevadas. Não trave os joelhos.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/05/Leg-Press-Calf-Raise.gif'),

('Panturrilha Unilateral','Panturrilha','Gastrocnêmio',ARRAY['Sóleo'],'isolamento','Peso corporal ou halter',
'1. Em pé em um degrau em um único pé\n2. Suba na ponta do pé\n3. Contraia no topo\n4. Desça abaixo da linha',
'Excelente isolamento unilateral. Corrige assimetrias.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/06/Single-Leg-Calf-Raises.gif'),

-- ============================================================
-- TRAPÉZIO
-- ============================================================
('Encolhimento de Ombros com Barra','Trapézio','Trapézio superior',ARRAY['Levantador da escápula'],'isolamento','Barra',
'1. Em pé segurando a barra\n2. Eleve os ombros em direção às orelhas\n3. Pause no topo\n4. Desça controladamente',
'Não role os ombros — apenas eleve. Controle total na descida.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Barbell-Shrug.gif'),

('Encolhimento de Ombros com Halteres','Trapézio','Trapézio superior',ARRAY['Levantador da escápula'],'isolamento','Halteres',
'1. Em pé com halteres ao lado do corpo\n2. Eleve os ombros em direção às orelhas\n3. Pause\n4. Desça com controle',
'Halteres permitem maior amplitude lateral.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/04/Dumbbell-Shrug.gif'),

('Encolhimento no Smith','Trapézio','Trapézio superior',ARRAY['Levantador da escápula'],'isolamento','Smith machine',
'1. Posicione-se sob a barra do Smith\n2. Eleve os ombros\n3. Pause\n4. Desça com controle',
'Trajetória guiada facilita o movimento. Boa opção para cargas elevadas.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/10/smith-machine-shrug.gif'),

('Face Pull','Trapézio','Trapézio médio',ARRAY['Deltóide posterior','Romboides','Infraespinhoso'],'isolamento','Cabo + corda',
'1. Posicione o cabo na altura dos olhos\n2. Puxe a corda em direção ao rosto\n3. Cotovelos para fora\n4. Retorne com controle',
'Essencial para saúde dos ombros. Contrabalança exercícios de empurrar.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Face-Pull.gif'),

('Voador Posterior na Máquina','Trapézio','Deltóide posterior',ARRAY['Romboides','Infraespinhoso'],'isolamento','Máquina peck deck',
'1. Sente-se de frente para a máquina\n2. Puxe os braços para trás em arco\n3. Contraia os romboides\n4. Retorne',
'Excelente para deltóide posterior e romboides.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Rear-Delt-Machine-Flys.gif'),

('Voador Invertido Inclinado','Trapézio','Deltóide posterior',ARRAY['Romboides','Trapézio médio'],'isolamento','Halteres + Banco inclinado',
'1. Apoie o peito no banco inclinado\n2. Eleve os halteres para os lados em arco\n3. Contraia os romboides\n4. Desça',
'Posição inclinada elimina o balanço do corpo.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Dumbbell-Reverse-Fly.gif'),

('Remada Alta com Barra EZ','Trapézio','Trapézio superior',ARRAY['Deltóide medial','Bíceps'],'composto','Barra EZ',
'1. Em pé, segure a barra EZ com pegada estreita\n2. Puxe em direção ao queixo\n3. Cotovelos acima das mãos\n4. Retorne',
'A barra EZ reduz pressão nos pulsos. Não suba acima do queixo.','intermediario',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Barbell-Upright-Row.gif'),

-- ============================================================
-- CORE / ABDÔMEN
-- ============================================================
('Prancha Isométrica','Core','Reto abdominal',ARRAY['Transverso abdominal','Oblíquos','Lombar'],'funcional','Sem equipamento',
'1. Posição de flexão com antebraços no chão\n2. Corpo em linha reta\n3. Core fortemente contraído\n4. Respire normalmente',
'Não levante ou afunde o quadril. Comece com 30s e progrida.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/plank.gif'),

('Crunch Abdominal','Core','Reto abdominal',ARRAY['Oblíquos'],'isolamento','Sem equipamento',
'1. Deitado com joelhos flexionados\n2. Mãos atrás da cabeça sem puxar\n3. Contraia o abdômen elevando os ombros\n4. Pause e desça',
'Movimento pequeno e controlado. Foco na contração, não em subir alto.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2015/11/Crunch.gif'),

('Abdominal Bicicleta','Core','Oblíquos',ARRAY['Reto abdominal','Flexores do quadril'],'funcional','Sem equipamento',
'1. Deitado, mãos atrás da cabeça\n2. Leve joelho esquerdo ao cotovelo direito\n3. Alterne para o lado oposto\n4. Mantenha as costas baixas',
'Movimento lento e controlado é mais eficaz. Um dos melhores para oblíquos.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Bicycle-Crunch.gif'),

('Abdominal Reverso','Core','Reto abdominal (porção inferior)',ARRAY['Flexores do quadril','Oblíquos'],'isolamento','Sem equipamento',
'1. Deitado, mãos ao lado do corpo\n2. Levante os quadris em direção ao teto\n3. Contraia o abdômen inferior\n4. Desça com controle',
'Foca na porção inferior do abdômen. Não use impulso.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Reverse-Crunch-1.gif'),

('Elevação de Pernas','Core','Reto abdominal (porção inferior)',ARRAY['Flexores do quadril'],'isolamento','Sem equipamento ou barra',
'1. Deitado ou pendurado na barra\n2. Levante as pernas até 90°\n3. Contraia o abdômen no topo\n4. Desça controladamente',
'Versão deitada é mais fácil. Pendurado é avançado e usa o core completamente.','intermediario',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Lying-Leg-Raise.gif'),

('Escalada (Mountain Climber)','Core','Reto abdominal',ARRAY['Oblíquos','Deltóide','Core'],'funcional','Sem equipamento',
'1. Posição de flexão\n2. Traga um joelho em direção ao peito\n3. Alterne rapidamente\n4. Mantenha o core ativado',
'Exercício funcional que eleva a frequência cardíaca. Ótimo para queima de gordura.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Mountain-climber.gif'),

('Abdominal no Cabo Ajoelhado','Core','Reto abdominal',ARRAY['Oblíquos'],'isolamento','Cabo alto + corda',
'1. Ajoelhe-se segurando a corda do cabo alto\n2. Contraia o abdômen puxando os cotovelos em direção aos joelhos\n3. Retorne com controle',
'Permite progressão de carga. Excelente para hipertrofia do abdômen.','intermediario',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Kneeling-Cable-Crunch.gif'),

('Elevação de Pernas na Cadeira Romana','Core','Reto abdominal (porção inferior)',ARRAY['Flexores do quadril'],'isolamento','Cadeira romana',
'1. Apoie os antebraços na cadeira romana\n2. Levante as pernas até 90°\n3. Contraia o abdômen\n4. Desça com controle',
'Ótimo para abdômen inferior. Versão difícil: extensão total.','intermediario',
'https://fitnessprogramer.com/wp-content/uploads/2021/05/Captains-Chair-Leg-Raise.gif'),

('Toque no Calcanhar','Core','Oblíquos',ARRAY['Reto abdominal'],'isolamento','Sem equipamento',
'1. Deitado, joelhos flexionados\n2. Lateralize tocando o calcanhar direito com a mão direita\n3. Alterne para o esquerdo',
'Simples e eficaz para os oblíquos. Ideal para iniciantes.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/02/Heel-Touch.gif'),

('Flexão Lateral com Halter','Core','Oblíquos',ARRAY['Quadrado lombar'],'isolamento','Halter',
'1. Em pé com halter em uma mão\n2. Incline lateralmente\n3. Retorne à posição ereta\n4. Complete as repetições e troque o lado',
'Trabalha os oblíquos. Use cargas moderadas.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/05/Dumbbell-Side-Bend.gif'),

-- ============================================================
-- CARDIO
-- ============================================================
('Corrida (esteira ou rua)','Cardio','Sistema cardiovascular',ARRAY['Quadríceps','Isquiotibiais','Gastrocnêmio'],'cardio','Esteira ou livre',
'1. Aquecimento de 5 min\n2. Cadência de 170-180 passos/min\n3. Postura ereta\n4. Respire ritmicamente',
'FC alvo: 60-75% da FC máxima para queima de gordura. FC máx = 220 - idade.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/07/Run.gif'),

('HIIT (Intervalado de Alta Intensidade)','Cardio','Sistema cardiovascular',ARRAY['Membros inferiores','Core'],'cardio','Sem equipamento',
'1. Aquecimento 5 min\n2. Esforço máximo 20-30 segundos\n3. Recuperação 10-40 segundos\n4. Repita 8-12 vezes',
'Muito eficiente para queima de gordura. Não mais que 3x por semana.','avancado',
NULL),

('Pular Corda','Cardio','Sistema cardiovascular',ARRAY['Gastrocnêmio','Ombros','Core'],'cardio','Corda',
'1. Segure a corda nas laterais\n2. Pule sobre as pontas dos pés\n3. Saltos baixos e rítmicos\n4. Core ativado',
'Excelente condicionamento e coordenação. Queima ~10 cal/min.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2023/10/Skip-Jump-Rope.gif'),

('Polichinelo (Jumping Jack)','Cardio','Sistema cardiovascular',ARRAY['Deltóides','Glúteos','Adutores'],'cardio','Sem equipamento',
'1. Em pé, braços ao lado\n2. Pule abrindo pernas e elevando braços\n3. Retorne à posição inicial\n4. Ritmo constante',
'Excelente aquecimento. Eleva a frequência cardíaca rapidamente.','iniciante',
'https://fitnessprogramer.com/wp-content/uploads/2021/05/Jumping-jack.gif')

ON CONFLICT (nome) DO UPDATE SET gif_url = EXCLUDED.gif_url;

-- Verificar resultado
SELECT grupo_muscular, COUNT(*) AS total,
  SUM(CASE WHEN gif_url IS NOT NULL THEN 1 ELSE 0 END) AS com_gif
FROM public.exercicios
GROUP BY grupo_muscular
ORDER BY grupo_muscular;
