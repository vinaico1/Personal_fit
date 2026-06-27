-- ============================================================
-- Adicionar links de vídeo tutorial (YouTube) aos exercícios
-- Execute no SQL Editor do Supabase após o setup.sql
-- ============================================================

update public.exercicios set video_url = 'https://www.youtube.com/watch?v=SCVCLChPQFY' where nome = 'Supino Reto com Barra';
update public.exercicios set video_url = 'https://www.youtube.com/watch?v=DbFgADa2PL8' where nome = 'Supino Inclinado com Halteres';
update public.exercicios set video_url = 'https://www.youtube.com/watch?v=IODxDxX7oi4' where nome = 'Flexão de Braço';
update public.exercicios set video_url = 'https://www.youtube.com/watch?v=eozdVDA78K0' where nome = 'Crucifixo com Halteres';
update public.exercicios set video_url = 'https://www.youtube.com/watch?v=EUIri47Epcg' where nome = 'Puxada Frontal com Barra';
update public.exercicios set video_url = 'https://www.youtube.com/watch?v=9efgcAjQe7E' where nome = 'Remada Curvada com Barra';
update public.exercicios set video_url = 'https://www.youtube.com/watch?v=eGo4IYlbE5g' where nome = 'Barra Fixa';
update public.exercicios set video_url = 'https://www.youtube.com/watch?v=roCP6wCXPqo' where nome = 'Remada Unilateral com Halter';
update public.exercicios set video_url = 'https://www.youtube.com/watch?v=qEwKCR5JCog' where nome = 'Desenvolvimento com Halteres';
update public.exercicios set video_url = 'https://www.youtube.com/watch?v=3VcKaXpzqRo' where nome = 'Elevação Lateral';
update public.exercicios set video_url = 'https://www.youtube.com/watch?v=gzB9HkjBg5E' where nome = 'Elevação Frontal';
update public.exercicios set video_url = 'https://www.youtube.com/watch?v=6Z15_WdXmVw' where nome = 'Desenvolvimento Arnold';
update public.exercicios set video_url = 'https://www.youtube.com/watch?v=kwG2ipFRgfo' where nome = 'Rosca Direta com Barra';
update public.exercicios set video_url = 'https://www.youtube.com/watch?v=zC3nLlEvin4' where nome = 'Rosca Martelo';
update public.exercicios set video_url = 'https://www.youtube.com/watch?v=Jvj2wV0vOYU' where nome = 'Rosca Concentrada';
update public.exercicios set video_url = 'https://www.youtube.com/watch?v=2-LAMcpzODU' where nome = 'Tríceps Pulley';
update public.exercicios set video_url = 'https://www.youtube.com/watch?v=nEF0bv2FW94' where nome = 'Supino Fechado';
update public.exercicios set video_url = 'https://www.youtube.com/watch?v=6kALZikXxLc' where nome = 'Mergulho em Banco (Tricep Dip)';
update public.exercicios set video_url = 'https://www.youtube.com/watch?v=U3HlEF_E9fo' where nome = 'Agachamento com Barra';
update public.exercicios set video_url = 'https://www.youtube.com/watch?v=IZxyjW7MPJQ' where nome = 'Leg Press 45°';
update public.exercicios set video_url = 'https://www.youtube.com/watch?v=7j-2todZCMM' where nome = 'Stiff (Romanian Deadlift)';
update public.exercicios set video_url = 'https://www.youtube.com/watch?v=YyvSfVjQeL0' where nome = 'Extensora (Leg Extension)';
update public.exercicios set video_url = 'https://www.youtube.com/watch?v=1Tq3QdYUuHs' where nome = 'Flexora (Leg Curl)';
update public.exercicios set video_url = 'https://www.youtube.com/watch?v=2C-uNgKwPLE' where nome = 'Agachamento Búlgaro';
update public.exercicios set video_url = 'https://www.youtube.com/watch?v=-M4-G8p1fCI' where nome = 'Panturrilha em Pé';
update public.exercicios set video_url = 'https://www.youtube.com/watch?v=xDmFkJxPzeM' where nome = 'Hip Thrust com Barra';
update public.exercicios set video_url = 'https://www.youtube.com/watch?v=OUgsJ8-Vi0E' where nome = 'Elevação Pélvica (Glute Bridge)';
update public.exercicios set video_url = 'https://www.youtube.com/watch?v=pSHjTRCQxIw' where nome = 'Prancha Isométrica';
update public.exercicios set video_url = 'https://www.youtube.com/watch?v=Xyd_fa5zoEU' where nome = 'Crunch Abdominal';
update public.exercicios set video_url = 'https://www.youtube.com/watch?v=9FGilxCbdz8' where nome = 'Abdominal Bicicleta';
update public.exercicios set video_url = 'https://www.youtube.com/watch?v=SPQFxMJL5aE' where nome = 'Corrida (esteira ou rua)';
update public.exercicios set video_url = 'https://www.youtube.com/watch?v=ml6cT4AZdqI' where nome = 'HIIT (Intervalado de Alta Intensidade)';
update public.exercicios set video_url = 'https://www.youtube.com/watch?v=u3zgHI8QnqE' where nome = 'Pular Corda';
update public.exercicios set video_url = 'https://www.youtube.com/watch?v=iSSAk4XCsRA' where nome = 'Polichinelo (Jumping Jack)';

-- Confirmar atualizações
select nome, video_url is not null as tem_video from public.exercicios order by nome;
