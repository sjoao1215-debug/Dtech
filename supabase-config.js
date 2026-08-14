/* =====================================================
   CONFIGURAÇÃO DO SUPABASE
   ====================================================== 

   1. Crie uma conta gratuita em https://supabase.com
   2. Crie um novo projeto
   3. Vá em "Project Settings" > "API"
   4. Copie a "Project URL" e cole em SUPABASE_URL abaixo
   5. Copie a chave "anon public" e cole em SUPABASE_ANON_KEY abaixo
   6. Rode o script SQL do arquivo supabase-setup.sql no
      "SQL Editor" do Supabase (uma única vez)

====================================================== */

const SUPABASE_URL = "https://SEU-PROJETO.supabase.co";
const SUPABASE_ANON_KEY = "SUA-CHAVE-ANON-PUBLIC-AQUI";

const supabaseClient = window.supabase.createClient(
    SUPABASE_URL,
    SUPABASE_ANON_KEY
);
