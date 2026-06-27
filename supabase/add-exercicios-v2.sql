-- ============================================================
-- EXERCÍCIOS v2 — Ampliação do banco com 41 novos exercícios
-- Cobertura: iniciante / intermediario / avancado em todos os grupos
-- Execute no SQL Editor do Supabase após setup.sql
-- ============================================================

insert into public.exercicios (nome, grupo_muscular, musculo_primario, musculos_secundarios, tipo, equipamento, instrucoes, dicas, dificuldade, video_url) values

-- ==================== PEITO ====================

('Supino Declinado com Barra', 'Peito', 'Peitoral inferior', ARRAY['Tríceps', 'Deltóide anterior'], 'composto', 'Barra + Banco declinado',
'1. Deite no banco declinado e prenda os pés nos apoios\n2. Segure a barra com pegada ligeiramente mais larga que os ombros\n3. Desça a barra controladamente até tocar a parte baixa do peito\n4. Empurre explosivamente de volta',
'Cuidado ao desmontar a barra — prefira ter um parceiro. O declive de 15-30° é suficiente. Não deixe os quadris soltarem do banco.',
'avancado', 'https://www.youtube.com/results?search_query=supino+declinado+barra+como+fazer+correto'),

('Crossover no Cabo', 'Peito', 'Peitoral maior (porção medial)', ARRAY['Deltóide anterior', 'Bíceps'], 'isolamento', 'Polia dupla',
'1. Posicione as polias no alto e segure uma em cada mão\n2. Dê um passo à frente para criar tensão\n3. Com leve flexão nos cotovelos, feche os braços à frente do corpo\n4. Cruze levemente no final para maior contração\n5. Retorne controladamente',
'Varie a altura das polias: alta = inferior, na altura do peito = medial, baixa = superior. Mantenha os cotovelos levemente flexionados e fixos.',
'intermediario', 'https://www.youtube.com/results?search_query=crossover+polia+peito+como+fazer'),

('Dips nas Paralelas — Peitoral', 'Peito', 'Peitoral inferior', ARRAY['Tríceps', 'Deltóide anterior'], 'composto', 'Barras paralelas',
'1. Apoie nas paralelas com os braços estendidos\n2. Incline o tronco levemente para frente (~30°)\n3. Desça até os ombros ficarem abaixo dos cotovelos\n4. Suba de volta sem travar os cotovelos',
'Quanto mais inclinado para frente, mais peitoral. O corpo vertical trabalha mais tríceps. Adicione peso com cinto quando dominar o peso corporal.',
'avancado', 'https://www.youtube.com/results?search_query=dips+paralelas+peito+como+fazer+academia'),

('Supino na Máquina (Chest Press)', 'Peito', 'Peitoral maior', ARRAY['Deltóide anterior', 'Tríceps'], 'composto', 'Máquina chest press',
'1. Ajuste o banco para que as alças fiquem na altura do peito\n2. Sente-se com as costas bem apoiadas\n3. Empurre as alças à frente até quase estender os braços\n4. Retorne controladamente mantendo tensão no peito',
'Ideal para iniciantes: a máquina guia o movimento e reduz risco de lesão. Ajuste o ponto de partida para não forçar o ombro.',
'iniciante', 'https://www.youtube.com/results?search_query=supino+maquina+chest+press+iniciante'),

('Flexão Diamante', 'Peito', 'Peitoral (porção interna)', ARRAY['Tríceps', 'Deltóide anterior'], 'composto', 'Sem equipamento',
'1. Posição de flexão com as mãos juntas formando um diamante\n2. Polegares e indicadores se tocam abaixo do peito\n3. Desça controladamente\n4. Suba focando na contração do peitoral interno e tríceps',
'Reduz a amplitude mas aumenta o trabalho de tríceps e peitoral interno. Se for difícil, faça com joelhos no chão.',
'iniciante', 'https://www.youtube.com/results?search_query=flexao+diamante+como+fazer+correto'),

-- ==================== COSTAS ====================

('Levantamento Terra Convencional', 'Costas', 'Eretores da coluna', ARRAY['Glúteos', 'Isquiotibiais', 'Quadríceps', 'Trapézio', 'Core'], 'composto', 'Barra',
'1. Pés na largura dos quadris sob a barra\n2. Segure a barra fora das pernas com pegada pronada ou alternada\n3. Trave o core, puxe a barra deslizando pelas pernas\n4. Estenda quadril e joelhos simultaneamente\n5. Retorne controladamente pela mesma trajetória',
'O movimento não começa pelos braços — inicia pelo empurrão do chão com os pés. Mantenha a barra colada ao corpo durante todo o percurso. Coluna neutra é obrigatório.',
'avancado', 'https://www.youtube.com/results?search_query=levantamento+terra+como+fazer+correto+iniciante'),

('Remada na Máquina (Chest Supported)', 'Costas', 'Grande dorsal', ARRAY['Romboides', 'Trapézio médio', 'Bíceps'], 'composto', 'Máquina de remada',
'1. Sente-se na máquina com o peito apoiado no suporte\n2. Segure as alças com pegada neutra ou pronada\n3. Puxe as alças em direção ao abdômen contraindo as escápulas\n4. Estenda os braços controladamente',
'O suporte no peito elimina a compensação do lombar. Perfeito para iniciantes aprenderem a "puxar pelas costas". Foque em retrair as escápulas antes de puxar.',
'iniciante', 'https://www.youtube.com/results?search_query=remada+maquina+costas+como+fazer'),

('Remada Baixa no Cabo (Seated Cable Row)', 'Costas', 'Grande dorsal', ARRAY['Romboides', 'Trapézio', 'Bíceps'], 'composto', 'Polia baixa',
'1. Sente-se na estação de cabo com os pés nos apoios\n2. Segure a alça com pegada neutra\n3. Com leve reclinação do tronco (~10°), puxe a alça até o abdômen\n4. Retorne estendendo os braços completamente',
'Não balance o tronco para pegar força — use só a musculatura das costas. Foque em "juntar as escápulas" antes de puxar com os braços.',
'intermediario', 'https://www.youtube.com/results?search_query=remada+cabo+baixo+seated+row+como+fazer'),

('Pull Over com Halter', 'Costas', 'Grande dorsal', ARRAY['Peitoral', 'Tríceps', 'Serrátil'], 'isolamento', 'Halter + Banco',
'1. Deite transversalmente no banco com apenas as escápulas apoiadas\n2. Segure o halter com ambas as mãos acima do peito\n3. Com braços quase estendidos, desça o halter atrás da cabeça\n4. Retorne pelo mesmo arco sentindo o estiramento no dorsal',
'Excelente para expandir a caixa torácica e trabalhar o dorsal em amplitude. Não desça além do nível do banco para evitar lesão no ombro.',
'intermediario', 'https://www.youtube.com/results?search_query=pullover+halter+costas+como+fazer+correto'),

-- ==================== OMBROS ====================

('Desenvolvimento Militar com Barra', 'Ombros', 'Deltóide', ARRAY['Trapézio', 'Tríceps', 'Core'], 'composto', 'Barra',
'1. Em pé ou sentado, barra na frente na altura do queixo\n2. Pegada ligeiramente mais larga que os ombros\n3. Empurre a barra verticalmente até a extensão total\n4. Desça controladamente até a altura do queixo',
'Versão mais exigente que o desenvolvimento com halteres. Ativa mais o core por ser em pé. Não curve a lombar excessivamente ao empurrar.',
'intermediario', 'https://www.youtube.com/results?search_query=desenvolvimento+militar+barra+ombro+como+fazer'),

('Face Pull no Cabo', 'Ombros', 'Deltóide posterior', ARRAY['Infraespinhoso', 'Romboides', 'Trapézio médio'], 'isolamento', 'Polia alta',
'1. Polia na altura do rosto com corda dupla\n2. Segure uma ponta da corda em cada mão\n3. Puxe a corda em direção ao rosto, abrindo os cotovelos para os lados\n4. Separe as mãos no final para máxima contração',
'Essencial para saúde do manguito rotador. Protege os ombros de lesões causadas pelo excesso de exercícios frontais. Inclua sempre no treino.',
'iniciante', 'https://www.youtube.com/results?search_query=face+pull+cabo+ombro+posterior+como+fazer'),

('Encolhimento de Ombros (Shrug)', 'Ombros', 'Trapézio superior', ARRAY['Levantador da escápula'], 'isolamento', 'Barra ou Halteres',
'1. Em pé, segure a barra ou halteres com braços estendidos\n2. Encolha os ombros em direção às orelhas\n3. Pause no topo por 1-2 segundos\n4. Desça controladamente',
'Não gire os ombros — movimento é puramente vertical. Contrair no topo maximiza o trabalho do trapézio. Use cargas elevadas progressivamente.',
'iniciante', 'https://www.youtube.com/results?search_query=encolhimento+ombro+shrug+trapezio+como+fazer'),

-- ==================== BÍCEPS ====================

('Rosca Scott (Preacher Curl)', 'Bíceps', 'Bíceps braquial (porção longa)', ARRAY['Braquial'], 'isolamento', 'Banco Scott + Barra W',
'1. Apoie os tríceps no banco inclinado do Scott\n2. Segure a barra W com pegada supinada\n3. Flexione os cotovelos trazendo a barra em direção ao rosto\n4. Desça lentamente até a quase extensão completa',
'O banco isola completamente o bíceps eliminando trapaças. Não estenda completamente para não machucar o cotovelo. Excelente para volume e definição.',
'intermediario', 'https://www.youtube.com/results?search_query=rosca+scott+preacher+curl+como+fazer'),

('Rosca Inclinada com Halteres', 'Bíceps', 'Bíceps braquial (porção longa)', ARRAY['Braquial', 'Braquiorradial'], 'isolamento', 'Halteres + Banco inclinado',
'1. Deite no banco inclinado a 45-60° com halteres pendurados\n2. Sem mover os ombros, flexione os cotovelos\n3. Gire o pulso para supinar no topo\n4. Desça lentamente sentindo o estiramento',
'A inclinação alonga a cabeça longa do bíceps, gerando maior estiramento e ativação. Um dos melhores para aumentar o pico do bíceps.',
'intermediario', 'https://www.youtube.com/results?search_query=rosca+inclinada+halteres+biceps+como+fazer'),

('Rosca 21 com Barra', 'Bíceps', 'Bíceps braquial', ARRAY['Braquial', 'Braquiorradial'], 'isolamento', 'Barra',
'1. Faça 7 repetições da metade inferior do movimento (de baixo até 90°)\n2. Sem descanso, faça 7 repetições da metade superior (de 90° até o topo)\n3. Sem descanso, faça 7 repetições completas\n4. Total: 21 repetições',
'Técnica de pré-exaustão que trabalha todas as fases do movimento. Use carga menor que o normal. Excelente finalizador do treino de bíceps.',
'avancado', 'https://www.youtube.com/results?search_query=rosca+21+barra+biceps+como+fazer+tecnica'),

-- ==================== TRÍCEPS ====================

('Tríceps Testa com Barra (Skull Crusher)', 'Tríceps', 'Tríceps braquial', ARRAY['Anconeu'], 'isolamento', 'Barra W + Banco',
'1. Deite no banco segurando a barra W acima do rosto\n2. Cotovelos fixos apontados para o teto\n3. Abaixe a barra em direção à testa flexionando apenas os cotovelos\n4. Estenda de volta controladamente',
'Mantenha os cotovelos fixos e apontados para frente durante todo o movimento. Use a barra W para reduzir pressão nos pulsos. Nome assustador, exercício excelente.',
'intermediario', 'https://www.youtube.com/results?search_query=triceps+testa+skull+crusher+barra+como+fazer'),

('Extensão Unilateral de Tríceps no Cabo', 'Tríceps', 'Tríceps braquial', ARRAY['Anconeu'], 'isolamento', 'Polia alta',
'1. Fique de lado à polia com um cabo na mão\n2. Cotovelo fixo ao lado da cabeça apontado para cima\n3. Estenda o braço completamente\n4. Retorne controladamente',
'Trabalha cada tríceps individualmente, corrigindo desbalanceamentos. O cotovelo deve permanecer fixo e apontado para o teto.',
'iniciante', 'https://www.youtube.com/results?search_query=triceps+extensao+unilateral+cabo+como+fazer'),

('Dips nas Paralelas — Tríceps', 'Tríceps', 'Tríceps braquial', ARRAY['Peitoral', 'Deltóide anterior'], 'composto', 'Barras paralelas',
'1. Apoie nas paralelas com o tronco ereto (não inclinado)\n2. Braços estendidos como ponto de partida\n3. Desça flexionando os cotovelos mantendo o tronco vertical\n4. Suba de volta até a extensão total',
'Tronco ereto = mais tríceps. Adicione peso com cinto quando conseguir 15+ repetições com peso corporal. Dos melhores para massa nos tríceps.',
'avancado', 'https://www.youtube.com/results?search_query=dips+paralelas+triceps+como+fazer+correto'),

-- ==================== PERNAS ====================

('Afundo com Halteres (Lunge)', 'Pernas', 'Quadríceps', ARRAY['Glúteos', 'Isquiotibiais', 'Adutores'], 'composto', 'Halteres',
'1. Em pé com halteres nas mãos\n2. Dê um passo largo à frente\n3. Desça até o joelho de trás quase tocar o chão\n4. Joelho da frente alinhado com o pé\n5. Empurre de volta e alterne as pernas',
'Mantenha o tronco ereto durante todo o movimento. O joelho da frente não deve ultrapassar os dedos do pé. Excelente para força e equilíbrio unilateral.',
'iniciante', 'https://www.youtube.com/results?search_query=afundo+lunge+halteres+como+fazer+correto'),

('Agachamento Goblet com Kettlebell', 'Pernas', 'Quadríceps', ARRAY['Glúteos', 'Core', 'Adutores'], 'composto', 'Kettlebell ou Halter',
'1. Segure o kettlebell ou halter com ambas as mãos na frente do peito\n2. Pés um pouco mais abertos que os ombros, pontas levemente abertas\n3. Desça profundamente mantendo o tronco ereto\n4. Os cotovelos tocam as coxas no fundo\n5. Suba empurrando o chão',
'Ótimo para aprender o padrão do agachamento. O peso à frente contrabalanceia e permite descer mais fundo. Ideal para iniciantes e aquecimento.',
'iniciante', 'https://www.youtube.com/results?search_query=agachamento+goblet+kettlebell+como+fazer'),

('Agachamento Sumô com Halter', 'Pernas', 'Adutores', ARRAY['Glúteos', 'Quadríceps'], 'composto', 'Halter',
'1. Pés bem abertos (mais que os ombros) com pontas para fora ~45°\n2. Segure o halter com ambas as mãos entre as pernas\n3. Desça mantendo a coluna ereta e joelhos acompanhando os pés\n4. Empurre de volta pelo calcanhar',
'A posição sumô enfatiza adutores e glúteos. Ótimo complemento ao agachamento convencional. Permita que os joelhos abram bastante para seguir os pés.',
'iniciante', 'https://www.youtube.com/results?search_query=agachamento+sumo+halter+como+fazer+correto'),

('Step-Up com Halteres', 'Pernas', 'Quadríceps', ARRAY['Glúteos', 'Isquiotibiais'], 'composto', 'Halteres + Banco ou Step',
'1. Em pé na frente do banco com halteres nas mãos\n2. Suba com um pé no banco pressionando o calcanhar\n3. Suba o outro pé para ficar em cima do banco\n4. Desça um pé de cada vez controladamente\n5. Alterne a perna que inicia',
'Altura ideal do banco: joelho em ~90° ao subir. Empurre pelo calcanhar para ativar mais glúteo. Excelente para equilíbrio e força unilateral.',
'iniciante', 'https://www.youtube.com/results?search_query=step+up+banco+halteres+como+fazer'),

('Hack Squat na Máquina', 'Pernas', 'Quadríceps', ARRAY['Glúteos', 'Isquiotibiais'], 'composto', 'Máquina Hack Squat',
'1. Posicione-se na máquina com os ombros sob os apoios\n2. Pés na plataforma na largura dos ombros\n3. Solte as travas e desça até 90° nos joelhos\n4. Empurre de volta sem travar os joelhos',
'A posição inclinada permite profundidade maior que o agachamento livre. Posição dos pés mais alta = mais glúteo; mais baixa = mais quadríceps.',
'intermediario', 'https://www.youtube.com/results?search_query=hack+squat+maquina+como+fazer+correto'),

('Cadeira Adutora', 'Pernas', 'Adutores', ARRAY['Grácil', 'Pectíneo'], 'isolamento', 'Máquina adutora',
'1. Sente-se na máquina com as pernas abertas contra as almofadas\n2. Feche as pernas resistindo à abertura\n3. Pause no ponto de maior contração\n4. Retorne lentamente à posição aberta',
'Isolamento para a face interna da coxa. Combine com cadeira abdutora para equilíbrio. Bom para definição da coxa interna.',
'iniciante', 'https://www.youtube.com/results?search_query=cadeira+adutora+como+fazer+maquina'),

('Cadeira Abdutora', 'Pernas', 'Glúteo médio', ARRAY['Tensor da fáscia lata', 'Glúteo mínimo'], 'isolamento', 'Máquina abdutora',
'1. Sente-se na máquina com as pernas unidas por dentro das almofadas\n2. Abra as pernas vencendo a resistência da máquina\n3. Pause na abertura máxima\n4. Feche lentamente',
'Trabalha o glúteo médio e estabilizadores do quadril. Essencial para quem tem joelhos que dobram para dentro no agachamento (valgo). Combine com adutora.',
'iniciante', 'https://www.youtube.com/results?search_query=cadeira+abdutora+maquina+como+fazer+correto'),

('Agachamento com Salto (Squat Jump)', 'Pernas', 'Quadríceps', ARRAY['Glúteos', 'Isquiotibiais', 'Gastrocnêmio'], 'funcional', 'Sem equipamento',
'1. Pés na largura dos ombros\n2. Agache até as coxas ficarem paralelas\n3. Salte explosivamente o mais alto possível\n4. Caia suavemente na ponta dos pés absorvendo o impacto\n5. Imediatamente realize o próximo agachamento',
'Poderoso exercício pliométrico. Desenvolve potência explosiva. A aterrissagem suave com joelhos semiflexionados é fundamental para proteger as articulações.',
'intermediario', 'https://www.youtube.com/results?search_query=agachamento+com+salto+squat+jump+como+fazer'),

-- ==================== GLÚTEOS ====================

('Kickback no Cabo', 'Glúteos', 'Glúteo máximo', ARRAY['Isquiotibiais'], 'isolamento', 'Polia baixa',
'1. Prenda o tornozelo ao cabo da polia baixa\n2. Apoie nas barras da estação de frente para a polia\n3. Estenda a perna para trás e para cima contraindo o glúteo\n4. Pause no topo e retorne controladamente',
'Não balance o corpo — o movimento deve vir somente do quadril. Mantenha o core ativado. Contraia o glúteo com força no ponto mais alto.',
'iniciante', 'https://www.youtube.com/results?search_query=kickback+cabo+gluteo+como+fazer+correto'),

('Abdução de Quadril na Máquina', 'Glúteos', 'Glúteo médio', ARRAY['Glúteo mínimo', 'Tensor da fáscia lata'], 'isolamento', 'Máquina de abdução',
'1. Sente-se ereto na máquina com as pernas unidas pelos apoios externos\n2. Empurre os apoios para fora abrindo as pernas\n3. Pause na abertura máxima\n4. Retorne lentamente',
'Excelente para o glúteo médio que fica na lateral do quadril. Muito usado para dar forma e volume lateral ao glúteo. Sente ereto — não incline o tronco.',
'iniciante', 'https://www.youtube.com/results?search_query=abducao+quadril+maquina+gluteo+medio+como+fazer'),

('Afundo Reverso com Halteres', 'Glúteos', 'Glúteo máximo', ARRAY['Quadríceps', 'Isquiotibiais'], 'composto', 'Halteres',
'1. Em pé com halteres nas mãos\n2. Dê um passo grande para trás (ao contrário do afundo convencional)\n3. Desça até o joelho de trás quase tocar o chão\n4. Empurre com o pé da frente para retornar\n5. Alterne as pernas',
'Mais fácil para equilíbrio que o afundo convencional. Coloca maior ênfase no glúteo da perna da frente. Ideal para quem tem dificuldade com o avanço.',
'iniciante', 'https://www.youtube.com/results?search_query=afundo+reverso+halteres+gluteo+como+fazer'),

-- ==================== CORE ====================

('Prancha Lateral', 'Core', 'Oblíquos', ARRAY['Glúteo médio', 'Transverso abdominal', 'Quadrado lombar'], 'funcional', 'Sem equipamento',
'1. Deite de lado com o antebraço no chão perpendicular ao corpo\n2. Eleve os quadris formando uma linha reta da cabeça aos pés\n3. Mantenha a posição respirando normalmente\n4. Troque de lado',
'Comece com 20-30 segundos por lado e progrida. Se for difícil, apoie o joelho inferior no chão. Excelente para estabilidade lateral da coluna.',
'iniciante', 'https://www.youtube.com/results?search_query=prancha+lateral+como+fazer+correto+obliquos'),

('Dead Bug', 'Core', 'Transverso abdominal', ARRAY['Reto abdominal', 'Oblíquos', 'Flexores do quadril'], 'funcional', 'Sem equipamento',
'1. Deitado de costas com braços estendidos ao teto e joelhos a 90° no ar\n2. Expire e pressione a lombar no chão\n3. Estenda o braço direito atrás da cabeça e a perna esquerda à frente simultaneamente\n4. Retorne ao centro e repita no lado oposto',
'Excelente para ativação do core profundo sem pressionar a coluna. Foque em manter a lombar colada ao chão durante todo o movimento — isso é o mais importante.',
'iniciante', 'https://www.youtube.com/results?search_query=dead+bug+core+lombar+como+fazer+correto'),

('Elevação de Pernas Deitado', 'Core', 'Reto abdominal inferior', ARRAY['Flexores do quadril', 'Transverso abdominal'], 'isolamento', 'Sem equipamento',
'1. Deitado de costas com mãos embaixo do glúteo para apoio lombar\n2. Pernas estendidas e levemente elevadas do chão\n3. Suba as pernas juntas até 90°\n4. Desça controladamente sem tocar o chão',
'Contraia o abdômen antes de mover as pernas. Se sentir dor na lombar, flexione levemente os joelhos. Para progredir, adicione caneleiras.',
'iniciante', 'https://www.youtube.com/results?search_query=elevacao+de+pernas+deitado+abdomen+como+fazer'),

('Russian Twist com Disco', 'Core', 'Oblíquos', ARRAY['Reto abdominal', 'Flexores do quadril'], 'isolamento', 'Disco ou halter',
'1. Sente-se com joelhos flexionados e tronco inclinado ~45°\n2. Segure o disco ou halter com ambas as mãos à frente\n3. Gire o tronco de um lado para o outro tocando o peso no chão\n4. Mantenha o abdômen contraído durante o movimento',
'Para dificultar, eleve os pés do chão. Para facilitar, apoie os pés. A rotação deve vir do tronco, não dos braços. Use peso progressivo.',
'intermediario', 'https://www.youtube.com/results?search_query=russian+twist+disco+obliquos+como+fazer'),

('Roda Abdominal (Ab Wheel Rollout)', 'Core', 'Reto abdominal', ARRAY['Transverso abdominal', 'Latíssimo do dorso', 'Ombros'], 'funcional', 'Roda abdominal',
'1. Ajoelhe-se com a roda à frente\n2. Segure a roda com ambas as mãos\n3. Role para frente mantendo o core rígido\n4. Chegue o mais longe possível sem arquear a lombar\n5. Contraia o core para retornar',
'Um dos exercícios mais difíceis para o abdômen. Comece com amplitude pequena e aumente gradualmente. Nunca solte o core — lombar arqueada causa lesão.',
'avancado', 'https://www.youtube.com/results?search_query=roda+abdominal+ab+wheel+como+fazer+correto'),

('Abdominal na Máquina (Crunch Machine)', 'Core', 'Reto abdominal', ARRAY['Oblíquos'], 'isolamento', 'Máquina abdominal',
'1. Ajuste o peso e sente-se na máquina\n2. Segure as alças com as mãos\n3. Contraia o abdômen trazendo os ombros em direção ao quadril\n4. Pause na contração máxima e retorne lentamente',
'A máquina permite carga progressiva para o abdômen. Ideal para finalizadores do treino. Mantenha a contração por 1-2 segundos no ponto mais baixo.',
'iniciante', 'https://www.youtube.com/results?search_query=abdominal+maquina+crunch+machine+como+fazer'),

('Elevação de Pernas na Barra Fixa', 'Core', 'Reto abdominal inferior', ARRAY['Flexores do quadril', 'Oblíquos', 'Grande dorsal'], 'composto', 'Barra fixa',
'1. Pendure-se na barra fixa com pegada pronada\n2. Com o core ativado, eleve as pernas até ficarem paralelas ao chão (ou mais acima)\n3. Pause brevemente no topo\n4. Desça lentamente sem balançar',
'Exercício avançado que combina força de agarre, core e dorsais. Progrida de joelhos dobrados para pernas retas. Um dos melhores para o abdômen inferior.',
'avancado', 'https://www.youtube.com/results?search_query=elevacao+pernas+barra+fixa+abdominal+como+fazer'),

-- ==================== CARDIO ====================

('Mountain Climber', 'Cardio', 'Core', ARRAY['Quadríceps', 'Deltóides', 'Glúteos'], 'funcional', 'Sem equipamento',
'1. Posição de prancha elevada com braços estendidos\n2. Traga o joelho direito em direção ao peito rapidamente\n3. Retorne e traga o joelho esquerdo\n4. Alterne em ritmo rápido como se escalasse uma montanha',
'Mantenha os quadris baixos — não deixe subir. Quanto mais rápido, maior o componente cardiovascular. Mantenha o core ativado durante todo o tempo.',
'iniciante', 'https://www.youtube.com/results?search_query=mountain+climber+como+fazer+correto+cardio'),

('Burpee', 'Cardio', 'Sistema cardiovascular', ARRAY['Peitoral', 'Quadríceps', 'Core', 'Deltóides'], 'funcional', 'Sem equipamento',
'1. Em pé, agache e coloque as mãos no chão\n2. Salte os pés para trás entrando em posição de prancha\n3. Faça uma flexão (opcional para iniciantes)\n4. Salte os pés de volta ao agachamento\n5. Salte explosivamente para cima com os braços acima da cabeça',
'O exercício completo do fitness. Adapte removendo a flexão se necessário. Para aumentar a intensidade, adicione salto mais alto no topo.',
'intermediario', 'https://www.youtube.com/results?search_query=burpee+como+fazer+correto+completo'),

('Bike Ergométrica', 'Cardio', 'Sistema cardiovascular', ARRAY['Quadríceps', 'Isquiotibiais', 'Gastrocnêmio'], 'cardio', 'Bicicleta ergométrica',
'1. Ajuste o banco para que o joelho fique levemente flexionado na pedalada mais baixa\n2. Segure o guidão confortavelmente\n3. Comece em resistência baixa e aqueça por 5 minutos\n4. Mantenha cadência de 60-80 RPM\n5. Varie a resistência para criar intervalos',
'Exercício de baixo impacto — excelente para joelhos. Aumentar a resistência simula subidas. Bom para recuperação ativa após treinos de perna pesados.',
'iniciante', 'https://www.youtube.com/results?search_query=bike+ergometrica+como+usar+correto+cardio'),

('Box Jump', 'Cardio', 'Quadríceps', ARRAY['Glúteos', 'Gastrocnêmio', 'Core'], 'funcional', 'Caixa pliométrica',
'1. Posicione-se a cerca de 30 cm da caixa\n2. Agache levemente com os braços para trás\n3. Salte explosivamente para cima da caixa usando os braços como impulso\n4. Pouse com ambos os pés na caixa em posição de agachamento\n5. Desça com controle — não salte de costas',
'Comece com caixas baixas (30-40 cm) e aumente gradualmente. A aterrissagem deve ser suave e silenciosa. Nunca salte de costas da caixa — desça pisando.',
'avancado', 'https://www.youtube.com/results?search_query=box+jump+pliometrico+como+fazer+correto'),

('Elíptico', 'Cardio', 'Sistema cardiovascular', ARRAY['Quadríceps', 'Glúteos', 'Costas', 'Ombros'], 'cardio', 'Elíptico',
'1. Suba no elíptico e posicione os pés nas plataformas\n2. Segure as alças móveis\n3. Inicie o movimento alternando pernas e braços em sincronia\n4. Mantenha postura ereta e core ativado\n5. Ajuste a resistência e inclinação conforme seu condicionamento',
'Cardio de baixíssimo impacto — não machuca joelhos nem quadril. Use as alças para ativar o tronco superior. Inclinação maior = mais glúteo e isquiotibial.',
'iniciante', 'https://www.youtube.com/results?search_query=eliptico+como+usar+correto+beneficios+cardio');

-- ============================================================
-- Verificar inserção por dificuldade
-- ============================================================
select
  dificuldade,
  count(*) as total,
  array_agg(nome order by grupo_muscular, nome) as exercicios
from public.exercicios
group by dificuldade
order by
  case dificuldade
    when 'iniciante'     then 1
    when 'intermediario' then 2
    when 'avancado'      then 3
  end;
