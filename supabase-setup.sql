-- =====================================================
-- CONFIGURAÇÃO DO BANCO - TREINAMENTO INTERNO
-- Loja Bezerra Autopeças
--
-- Como usar:
-- 1. No painel do Supabase, abra "SQL Editor"
-- 2. Cole este script inteiro e clique em "Run"
-- 3. Rode uma única vez (rodar de novo não duplica nada,
--    mas os comandos "create" vão dar erro se já existirem)
-- =====================================================


-- Tabela que guarda o progresso de cada colaborador em cada
-- aula de cada curso.

create table if not exists progresso (
    id uuid default gen_random_uuid() primary key,
    user_id uuid references auth.users(id) on delete cascade not null,
    curso text not null,
    modulo_index int not null,
    licao_index int not null,
    concluida_em timestamptz default now(),
    unique(user_id, curso, modulo_index, licao_index)
);


-- Ativa segurança por linha: cada colaborador só pode ver
-- e alterar o próprio progresso, nunca o de outra pessoa.

alter table progresso enable row level security;

create policy "Colaborador vê o próprio progresso"
    on progresso for select
    using (auth.uid() = user_id);

create policy "Colaborador insere o próprio progresso"
    on progresso for insert
    with check (auth.uid() = user_id);

create policy "Colaborador atualiza o próprio progresso"
    on progresso for update
    using (auth.uid() = user_id);


-- (Opcional, mas recomendado) Tabela simples com o nome do
-- colaborador, preenchida automaticamente no cadastro.

create table if not exists colaboradores (
    id uuid references auth.users(id) on delete cascade primary key,
    nome text,
    setor text,
    criado_em timestamptz default now()
);

alter table colaboradores enable row level security;

create policy "Colaborador vê o próprio cadastro"
    on colaboradores for select
    using (auth.uid() = id);

create policy "Colaborador cria o próprio cadastro"
    on colaboradores for insert
    with check (auth.uid() = id);

create policy "Colaborador atualiza o próprio cadastro"
    on colaboradores for update
    using (auth.uid() = id);
