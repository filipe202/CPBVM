#!/usr/bin/env bash
# Gera os artboards .dc.html dos mockups do CPBVM (partes partilhadas: emblema, nav, rodapé)
set -euo pipefail
cd "$(dirname "$0")"

# ---------- emblema completo (com texto circular) ----------
emblem() { # $1 = tamanho px, $2 = sufixo de id
cat <<EOF
<svg viewBox="0 0 200 200" width="$1" height="$1" role="img" aria-label="Emblema do Clube de Patinagem BVM Montijo" style="display:block">
  <defs>
    <linearGradient id="au$2" x1="0" y1="0" x2="1" y2="1">
      <stop offset="0" stop-color="#FFE9A8"/><stop offset=".48" stop-color="#E8B93C"/><stop offset="1" stop-color="#A8761F"/>
    </linearGradient>
    <path id="tp$2" d="M100,100 m-74,0 a74,74 0 1,1 148,0" fill="none"/>
    <path id="bp$2" d="M100,100 m-62,0 a62,62 0 1,0 124,0" fill="none"/>
  </defs>
  <circle cx="100" cy="100" r="99" fill="#08060a"/>
  <circle cx="100" cy="100" r="95" fill="none" stroke="#0E6B37" stroke-width="5"/>
  <circle cx="100" cy="100" r="89" fill="none" stroke="#D4102A" stroke-width="5"/>
  <circle cx="100" cy="100" r="84.5" fill="none" stroke="url(#au$2)" stroke-width="1"/>
  <circle cx="100" cy="100" r="63" fill="none" stroke="url(#au$2)" stroke-width="1" opacity=".55"/>
  <text fill="url(#au$2)" font-family="Archivo, Helvetica, Arial, sans-serif" font-size="13" font-weight="700" letter-spacing="2.6">
    <textPath href="#tp$2" startOffset="50%" text-anchor="middle">CLUBE PATINAGEM BVM</textPath>
  </text>
  <text fill="url(#au$2)" font-family="Archivo, Helvetica, Arial, sans-serif" font-size="11" font-weight="600" letter-spacing="4.5">
    <textPath href="#bp$2" startOffset="50%" text-anchor="middle">MONTIJO</textPath>
  </text>
  <g transform="translate(100,102) scale(.60) translate(-100,-102)">
    <g stroke="url(#au$2)" stroke-width="8" stroke-linecap="round" fill="none">
      <path d="M96,108 Q 74,103 54,78"/>
      <path d="M96,108 L 93,148"/>
      <path d="M96,108 L 118,90"/>
      <path d="M118,90 Q 135,87 152,74"/>
      <path d="M118,90 Q 100,77 80,60"/>
      <path d="M83,154 H105"/>
    </g>
    <circle cx="128" cy="80" r="10" fill="url(#au$2)"/>
    <circle cx="87" cy="161" r="5" fill="url(#au$2)"/>
    <circle cx="101" cy="161" r="5" fill="url(#au$2)"/>
  </g>
</svg>
EOF
}

# ---------- cabeçalho do ficheiro ----------
head_html() {
cat <<'EOF'
<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <script src="./support.js"></script>
</head>
<body>
<x-dc>
<helmet>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Archivo:wght@400;500;600;700&family=Instrument+Serif:ital@0;1&display=swap">
  <style>
    body{ margin:0; background:#0A0709; color:#F6F1EC;
      font-family:Archivo,'Helvetica Neue',Helvetica,Arial,sans-serif; font-size:17px; line-height:1.7;
      -webkit-font-smoothing:antialiased; }
    a{ color:#E8B93C; text-decoration:none; } a:hover{ color:#FFE9A8; }
    h1,h2,h3{ margin:0; font-family:'Instrument Serif',Georgia,'Times New Roman',serif; font-weight:400; letter-spacing:-.015em; }
    p{ margin:0; }
    .ey{ font-family:Archivo,Helvetica,Arial,sans-serif; font-size:11px; font-weight:600; letter-spacing:.3em;
      text-transform:uppercase; color:#E8B93C; }
    .mut{ color:#A79DA4; }
    .dim{ color:#6E6670; }
    .it{ font-style:italic; color:#E8B93C; }
    .chip{ display:inline-block; padding:5px 12px; border:1px solid rgba(232,185,60,.28); border-radius:999px;
      font-size:11px; font-weight:600; letter-spacing:.14em; text-transform:uppercase; color:#E8B93C; }
    .chip.r{ border-color:rgba(212,16,42,.45); color:#FF7A88; }
    .chip.g{ border-color:rgba(14,107,55,.55); color:#63C48E; }
    .btn{ display:inline-block; padding:16px 30px; border-radius:999px; font-size:14px; font-weight:600;
      letter-spacing:.06em; background:linear-gradient(120deg,#FFE9A8,#E8B93C 55%,#C08C24); color:#1B1206; }
    .btn.gh{ background:none; border:1px solid rgba(246,241,236,.22); color:#F6F1EC; }
    .hair{ height:1px; background:linear-gradient(90deg,transparent,rgba(232,185,60,.35),transparent); border:0; }
    .ph{ background:linear-gradient(168deg,#FF3A4E 0%,#A5122A 28%,#320C14 64%,#0B0709 100%); position:relative; overflow:hidden; }
    .ph:after{ content:''; position:absolute; left:-10%; right:-10%; top:58%; height:2px;
      background:linear-gradient(90deg,transparent,#E8B93C,transparent); transform:rotate(-7deg); opacity:.85; }
    .phl{ position:absolute; left:16px; bottom:14px; font-size:11px; letter-spacing:.16em; text-transform:uppercase;
      color:rgba(255,255,255,.72); }
    .card{ background:linear-gradient(180deg,#150F13,#0E0A0D); border:1px solid rgba(246,241,236,.08); }
  </style>
</helmet>
<div style="background:#0A0709; background-image:radial-gradient(60% 40% at 82% 0%, rgba(212,16,42,.22), transparent 62%), radial-gradient(40% 30% at 8% 12%, rgba(232,185,60,.07), transparent 66%);">
EOF
}

# ---------- navegação ----------
nav_html() { # $1 = chave ativa
  local active="$1"
  printf '%s' '<div style="display:flex; align-items:center; justify-content:space-between; gap:32px; padding:26px 96px; border-bottom:1px solid rgba(246,241,236,.07);">
  <div style="display:flex; align-items:center; gap:14px;">'
  emblem 46 "n"
  printf '%s' '    <div style="display:flex; flex-direction:column; line-height:1.15;">
      <span style="font-family:Instrument Serif,Georgia,serif; font-size:19px; letter-spacing:.01em;">Clube de Patinagem BVM</span>
      <span class="ey" style="font-size:9.5px; letter-spacing:.34em;">Montijo</span>
    </div>
  </div>
  <div style="display:flex; align-items:center; gap:30px;">'
  local pairs=("inicio:Início" "sobre:Sobre" "equipa:Equipa Técnica" "atletas:Atletas" "eventos:Eventos" "contactos:Contactos")
  local p k l col bb
  for p in "${pairs[@]}"; do
    k="${p%%:*}"; l="${p#*:}"
    if [ "$k" = "$active" ]; then col="#F6F1EC"; bb="border-bottom:1px solid #E8B93C;"; else col="#A79DA4"; bb=""; fi
    printf '    <span style="font-size:14.5px; font-weight:500; color:%s; padding-bottom:4px; %s">%s</span>\n' "$col" "$bb" "$l"
  done
  printf '%s' '    <span class="btn" style="padding:13px 24px; font-size:13px;">Inscrições abertas</span>
  </div>
</div>
'
}

# ---------- rodapé ----------
footer_html() {
  printf '%s' '<div style="border-top:1px solid rgba(246,241,236,.07); background:#080608; padding:72px 96px 40px;">
  <div style="display:grid; grid-template-columns:1.5fr 1fr 1fr 1.2fr; gap:56px;">
    <div>
      <div style="display:flex; align-items:center; gap:14px; margin-bottom:20px;">'
  emblem 52 "f"
  printf '%s' '        <span style="font-family:Instrument Serif,Georgia,serif; font-size:21px;">Clube de Patinagem BVM</span>
      </div>
      <p class="mut" style="font-size:15px; max-width:34ch;">Patinagem artística no Montijo. Formação, competição e espetáculo — com a mesma equipa desde o primeiro dia sobre patins.</p>
      <div style="display:flex; gap:10px; margin-top:22px;">
        <span style="width:40px; height:40px; border-radius:50%; border:1px solid rgba(246,241,236,.14); display:flex; align-items:center; justify-content:center;"><svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="#E8B93C" stroke-width="1.6"><rect x="3" y="3" width="18" height="18" rx="5"/><circle cx="12" cy="12" r="4"/><circle cx="17.5" cy="6.5" r="1" fill="#E8B93C" stroke="none"/></svg></span>
        <span style="width:40px; height:40px; border-radius:50%; border:1px solid rgba(246,241,236,.14); display:flex; align-items:center; justify-content:center;"><svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="#E8B93C" stroke-width="1.6"><path d="M14 8h2.5V4.5H14c-2.2 0-3.5 1.4-3.5 3.6V10H8v3.5h2.5V21H14v-7.5h2.6l.4-3.5H14V8.4c0-.3.2-.4.5-.4z"/></svg></span>
        <span style="width:40px; height:40px; border-radius:50%; border:1px solid rgba(246,241,236,.14); display:flex; align-items:center; justify-content:center;"><svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="#E8B93C" stroke-width="1.6"><path d="M4 6.5h16v11H4z"/><path d="M4 7l8 6 8-6"/></svg></span>
      </div>
    </div>
    <div>
      <div class="ey" style="margin-bottom:18px;">Clube</div>
      <div style="display:flex; flex-direction:column; gap:11px; font-size:15px; color:#A79DA4;">
        <span>Sobre o clube</span><span>Equipa técnica</span><span>Atletas</span><span>Direção</span><span>Galeria</span>
      </div>
    </div>
    <div>
      <div class="ey" style="margin-bottom:18px;">Atividade</div>
      <div style="display:flex; flex-direction:column; gap:11px; font-size:15px; color:#A79DA4;">
        <span>Escola de patinagem</span><span>Competição</span><span>Eventos</span><span>Inscrições</span><span>Quotas</span>
      </div>
    </div>
    <div>
      <div class="ey" style="margin-bottom:18px;">Contactos</div>
      <div style="display:flex; flex-direction:column; gap:11px; font-size:15px; color:#A79DA4;">
        <span>[Pavilhão / morada de treino]</span><span>[2870-000] Montijo</span><span>[email do clube]</span><span>[telefone]</span>
      </div>
    </div>
  </div>
  <div style="display:flex; justify-content:space-between; align-items:center; margin-top:56px; padding-top:26px; border-top:1px solid rgba(246,241,236,.07); font-size:13px; color:#6E6670;">
    <span>© [ano] Clube de Patinagem BVM · Montijo</span>
    <span>Política de privacidade · Estatutos · Filiado na Federação de Patinagem de Portugal</span>
  </div>
</div>
'
}

tail_html() {
cat <<'EOF'
</div>
</x-dc>
</body>
</html>
EOF
}

# =========================================================
#  HOMEPAGE
# =========================================================
{
head_html
nav_html inicio
cat <<'EOF'
<!-- HERO -->
<div style="display:grid; grid-template-columns:1.08fr .92fr; gap:64px; align-items:center; padding:92px 96px 84px;">
  <div>
    <div class="ey" style="margin-bottom:26px;">Patinagem artística · Montijo</div>
    <h1 style="font-size:92px; line-height:.98;">Onde a técnica<br>encontra a <span class="it">arte</span>.</h1>
    <p class="mut" style="font-size:19px; line-height:1.75; max-width:46ch; margin-top:28px;">
      Escola de patinagem e equipa de competição no Montijo. Dos primeiros passos sobre patins ao pódio — com treino sério, ambiente de família e muito brilho.
    </p>
    <div style="display:flex; gap:14px; margin-top:40px;">
      <span class="btn">Inscrever atleta</span>
      <span class="btn gh">Conhecer o clube</span>
    </div>
    <div style="display:flex; gap:40px; margin-top:52px; padding-top:28px; border-top:1px solid rgba(246,241,236,.08);">
      <div><div style="font-family:Instrument Serif,Georgia,serif; font-size:34px; color:#E8B93C;">[N]</div><div class="dim" style="font-size:12px; letter-spacing:.18em; text-transform:uppercase;">Atletas</div></div>
      <div><div style="font-family:Instrument Serif,Georgia,serif; font-size:34px; color:#E8B93C;">[N]</div><div class="dim" style="font-size:12px; letter-spacing:.18em; text-transform:uppercase;">Escalões</div></div>
      <div><div style="font-family:Instrument Serif,Georgia,serif; font-size:34px; color:#E8B93C;">[ano]</div><div class="dim" style="font-size:12px; letter-spacing:.18em; text-transform:uppercase;">Desde</div></div>
    </div>
  </div>
  <div style="position:relative; display:flex; align-items:center; justify-content:center; min-height:520px;">
    <div style="position:absolute; width:440px; height:440px; border-radius:50%; background:radial-gradient(circle, rgba(212,16,42,.45), rgba(212,16,42,0) 66%);"></div>
    <div style="position:absolute; width:470px; height:470px; border-radius:50%; border:1px dashed rgba(232,185,60,.3);"></div>
    <div style="position:absolute; width:560px; height:560px; border-radius:50%; border:1px solid rgba(212,16,42,.28);"></div>
EOF
emblem 330 "h"
cat <<'EOF'
    <div class="card" style="position:absolute; right:-10px; bottom:8px; width:186px; padding:16px; border-radius:4px;">
      <div class="ph" style="height:104px; border-radius:2px;"><span class="phl">[foto do equipamento]</span></div>
      <div style="margin-top:12px; font-size:13px; font-weight:600;">Equipamento oficial</div>
      <div class="dim" style="font-size:12px;">Época [ano/ano]</div>
    </div>
  </div>
</div>

<!-- FAIXA -->
<div style="display:flex; gap:44px; align-items:center; padding:18px 96px; border-block:1px solid rgba(246,241,236,.07); background:linear-gradient(90deg, rgba(212,16,42,.14), rgba(14,107,55,.10), rgba(232,185,60,.12)); overflow:hidden; white-space:nowrap;">
  <span class="ey" style="font-size:13px; color:rgba(246,241,236,.65);">Técnica</span><span style="color:#E8B93C;">◆</span>
  <span class="ey" style="font-size:13px; color:rgba(246,241,236,.65);">Arte</span><span style="color:#E8B93C;">◆</span>
  <span class="ey" style="font-size:13px; color:rgba(246,241,236,.65);">Equipa</span><span style="color:#E8B93C;">◆</span>
  <span class="ey" style="font-size:13px; color:rgba(246,241,236,.65);">Competição</span><span style="color:#E8B93C;">◆</span>
  <span class="ey" style="font-size:13px; color:rgba(246,241,236,.65);">Montijo</span><span style="color:#E8B93C;">◆</span>
  <span class="ey" style="font-size:13px; color:rgba(246,241,236,.65);">Espetáculo</span><span style="color:#E8B93C;">◆</span>
  <span class="ey" style="font-size:13px; color:rgba(246,241,236,.65);">Família</span>
</div>

<!-- O QUE FAZEMOS -->
<div style="padding:110px 96px 0;">
  <div style="display:flex; justify-content:space-between; align-items:flex-end; gap:40px; margin-bottom:52px;">
    <div>
      <div class="ey" style="margin-bottom:18px;">O que fazemos</div>
      <h2 style="font-size:56px; line-height:1.05;">Três caminhos,<br>a mesma <span class="it">pista</span>.</h2>
    </div>
    <p class="mut" style="font-size:16px; max-width:38ch;">Cada atleta entra no seu ritmo. Uns ficam pelo prazer de patinar, outros levam a época inteira a preparar uma prova. No CPBVM há lugar para os dois.</p>
  </div>
  <div style="display:grid; grid-template-columns:repeat(3,minmax(0,1fr)); gap:24px;">
    <div class="card" style="padding:34px; border-radius:4px;">
      <svg width="34" height="34" viewBox="0 0 24 24" fill="none" stroke="#E8B93C" stroke-width="1.4"><path d="M7 4h4l1 7h4"/><path d="M6 15h11"/><circle cx="7.5" cy="18.5" r="1.8"/><circle cx="12" cy="18.5" r="1.8"/><circle cx="16.5" cy="18.5" r="1.8"/></svg>
      <h3 style="font-size:27px; margin:22px 0 10px;">Escola de Patinagem</h3>
      <p class="mut" style="font-size:15.5px;">Primeiros passos, equilíbrio e confiança sobre rodas. Turmas a partir dos [idade] anos, sem experiência nenhuma.</p>
      <div style="margin-top:22px;"><span class="chip">Iniciação</span></div>
    </div>
    <div class="card" style="padding:34px; border-radius:4px; border-color:rgba(232,185,60,.22);">
      <svg width="34" height="34" viewBox="0 0 24 24" fill="none" stroke="#E8B93C" stroke-width="1.4"><path d="M12 3l2.6 5.6 6.1.8-4.5 4.2 1.2 6-5.4-3-5.4 3 1.2-6L3.3 9.4l6.1-.8z"/></svg>
      <h3 style="font-size:27px; margin:22px 0 10px;">Artística — Competição</h3>
      <p class="mut" style="font-size:15.5px;">Treino técnico e coreográfico para provas regionais e nacionais: exercícios de escola, programa curto e livre.</p>
      <div style="margin-top:22px;"><span class="chip g">Federado</span></div>
    </div>
    <div class="card" style="padding:34px; border-radius:4px;">
      <svg width="34" height="34" viewBox="0 0 24 24" fill="none" stroke="#E8B93C" stroke-width="1.4"><circle cx="9" cy="8" r="3"/><circle cx="17" cy="9.5" r="2.3"/><path d="M3.5 19c0-3 2.5-5 5.5-5s5.5 2 5.5 5"/><path d="M15.5 19c0-2.2 1-3.6 2.5-3.6s2.5 1.4 2.5 3.6"/></svg>
      <h3 style="font-size:27px; margin:22px 0 10px;">Grupos &amp; Exibições</h3>
      <p class="mut" style="font-size:15.5px;">Coreografias de conjunto, galas e o espetáculo de fim de época — a parte em que o clube brilha todo junto.</p>
      <div style="margin-top:22px;"><span class="chip r">Equipa</span></div>
    </div>
  </div>
</div>

<!-- SOBRE / EQUIPAMENTO -->
<div style="display:grid; grid-template-columns:1fr 1fr; gap:72px; align-items:center; padding:110px 96px;">
  <div style="display:grid; grid-template-columns:1fr 1fr; gap:16px;">
    <div class="ph" style="height:300px; border-radius:4px;"><span class="phl">[foto — equipa]</span></div>
    <div style="display:grid; gap:16px;">
      <div class="ph" style="height:142px; border-radius:4px;"><span class="phl">[foto — treino]</span></div>
      <div class="ph" style="height:142px; border-radius:4px;"><span class="phl">[foto — gala]</span></div>
    </div>
  </div>
  <div>
    <div class="ey" style="margin-bottom:18px;">O clube</div>
    <h2 style="font-size:54px; line-height:1.06;">Um clube pequeno<br>com <span class="it">ambição grande</span>.</h2>
    <p class="mut" style="font-size:16.5px; margin-top:24px;">Nascemos no Montijo [ano] e crescemos como se faz nos clubes de bairro: com pais nas bancadas, treinadoras que sabem o nome de cada atleta e um pavilhão cheio às sextas-feiras.</p>
    <p class="mut" style="font-size:16.5px; margin-top:16px;">O preto e o vermelho do equipamento vêm do emblema; a linha dourada é a que seguimos em cada programa — rigor técnico, sem perder a alegria de patinar.</p>
    <div style="display:flex; gap:14px; margin-top:34px;">
      <span class="btn gh">A nossa história</span>
      <span class="btn gh">Equipa técnica</span>
    </div>
  </div>
</div>

<!-- PRÓXIMOS EVENTOS -->
<div style="padding:0 96px 110px;">
  <hr class="hair" style="margin-bottom:64px;">
  <div style="display:flex; justify-content:space-between; align-items:flex-end; margin-bottom:40px;">
    <div>
      <div class="ey" style="margin-bottom:18px;">Agenda</div>
      <h2 style="font-size:52px;">Próximos <span class="it">eventos</span></h2>
    </div>
    <span style="font-size:14px; color:#E8B93C; border-bottom:1px solid rgba(232,185,60,.4); padding-bottom:3px;">Ver calendário completo →</span>
  </div>
  <div style="display:flex; flex-direction:column; gap:12px;">
    <div class="card" style="display:grid; grid-template-columns:88px 1fr auto; gap:28px; align-items:center; padding:22px 28px; border-radius:4px;">
      <div style="text-align:center; padding:12px 0; border-radius:3px; background:linear-gradient(150deg,#D4102A,#7A0C1B);">
        <div style="font-family:Instrument Serif,Georgia,serif; font-size:30px; line-height:1;">[00]</div>
        <div style="font-size:10.5px; letter-spacing:.2em; text-transform:uppercase; opacity:.85;">[Mês]</div>
      </div>
      <div>
        <h3 style="font-size:23px;">Torneio de Abertura de Época</h3>
        <p class="dim" style="font-size:14px; margin-top:4px;">[Pavilhão] · [Localidade] · [horas]</p>
      </div>
      <span class="chip r">Competição</span>
    </div>
    <div class="card" style="display:grid; grid-template-columns:88px 1fr auto; gap:28px; align-items:center; padding:22px 28px; border-radius:4px;">
      <div style="text-align:center; padding:12px 0; border-radius:3px; background:linear-gradient(150deg,#D4102A,#7A0C1B);">
        <div style="font-family:Instrument Serif,Georgia,serif; font-size:30px; line-height:1;">[00]</div>
        <div style="font-size:10.5px; letter-spacing:.2em; text-transform:uppercase; opacity:.85;">[Mês]</div>
      </div>
      <div>
        <h3 style="font-size:23px;">Gala de Natal do CPBVM</h3>
        <p class="dim" style="font-size:14px; margin-top:4px;">[Pavilhão] · Montijo · entrada [valor]</p>
      </div>
      <span class="chip">Exibição</span>
    </div>
    <div class="card" style="display:grid; grid-template-columns:88px 1fr auto; gap:28px; align-items:center; padding:22px 28px; border-radius:4px;">
      <div style="text-align:center; padding:12px 0; border-radius:3px; background:linear-gradient(150deg,#D4102A,#7A0C1B);">
        <div style="font-family:Instrument Serif,Georgia,serif; font-size:30px; line-height:1;">[00]</div>
        <div style="font-size:10.5px; letter-spacing:.2em; text-transform:uppercase; opacity:.85;">[Mês]</div>
      </div>
      <div>
        <h3 style="font-size:23px;">Estágio técnico de inverno</h3>
        <p class="dim" style="font-size:14px; margin-top:4px;">Aberto a atletas dos escalões [—] · inscrição prévia</p>
      </div>
      <span class="chip g">Formação</span>
    </div>
  </div>
</div>

<!-- CTA -->
<div style="padding:0 96px 110px;">
  <div style="position:relative; overflow:hidden; border:1px solid rgba(232,185,60,.18); border-radius:6px; padding:78px 64px; text-align:center;
    background:radial-gradient(90% 130% at 18% 0%, rgba(212,16,42,.42), transparent 60%), radial-gradient(70% 120% at 88% 100%, rgba(232,185,60,.16), transparent 62%), linear-gradient(160deg,#150F13,#0C080B);">
    <div class="ey" style="margin-bottom:20px;">Época [ano/ano]</div>
    <h2 style="font-size:58px; line-height:1.06;">As inscrições estão <span class="it">abertas</span>.</h2>
    <p class="mut" style="font-size:17px; max-width:52ch; margin:20px auto 0;">Aula experimental gratuita para quem quer começar. Traz roupa confortável — os patins podemos emprestar.</p>
    <div style="display:flex; gap:14px; justify-content:center; margin-top:38px;">
      <span class="btn">Quero inscrever-me</span>
      <span class="btn gh">Falar com o clube</span>
    </div>
  </div>
</div>
EOF
footer_html
tail_html
} > Main.dc.html

# ---------- cabeçalho de página interior ----------
pagehead() { # $1 = migalhas, $2 = eyebrow, $3 = título (html), $4 = lead
cat <<EOF
<div style="position:relative; padding:86px 96px 64px; border-bottom:1px solid rgba(246,241,236,.07);
  background:radial-gradient(60% 120% at 82% 0%, rgba(212,16,42,.30), transparent 62%), radial-gradient(40% 80% at 6% 40%, rgba(232,185,60,.08), transparent 66%);">
  <div class="dim" style="font-size:13px; margin-bottom:26px;">Início &nbsp;/&nbsp; $1</div>
  <div class="ey" style="margin-bottom:18px;">$2</div>
  <h1 style="font-size:74px; line-height:1.02; max-width:20ch;">$3</h1>
  <p class="mut" style="font-size:18px; max-width:56ch; margin-top:24px;">$4</p>
</div>
EOF
}

# =========================================================
#  SOBRE
# =========================================================
{
head_html
nav_html sobre
pagehead "Sobre" "Quem somos" "Um clube feito de <span class=\"it\">horas de pista</span>." "Formação, competição e comunidade. O Clube de Patinagem BVM é a casa de patinagem artística do Montijo — e um sítio onde ninguém patina sozinho."
cat <<'EOF'
<!-- MISSÃO -->
<div style="display:grid; grid-template-columns:1fr 1fr; gap:72px; padding:96px 96px 0; align-items:start;">
  <div>
    <div class="ey" style="margin-bottom:18px;">A nossa missão</div>
    <h2 style="font-size:46px; line-height:1.08;">Ensinar a cair.<br>E a <span class="it">levantar com estilo</span>.</h2>
  </div>
  <div>
    <p class="mut" style="font-size:17px;">Acreditamos que a patinagem artística ensina muito mais do que saltos e piruetas: ensina disciplina, paciência e a lidar com o palco. Por isso trabalhamos os dois lados — o técnico e o artístico — desde a primeira aula.</p>
    <p class="mut" style="font-size:17px; margin-top:16px;">Cada atleta tem um plano adequado à idade e ao escalão, acompanhamento próximo da equipa técnica e uma época com objetivos claros, do treino de terça-feira à gala de fim de ano.</p>
  </div>
</div>

<!-- VALORES -->
<div style="padding:72px 96px 0;">
  <div style="display:grid; grid-template-columns:repeat(3,minmax(0,1fr)); gap:24px;">
    <div class="card" style="padding:34px; border-radius:4px;">
      <div style="font-family:Instrument Serif,Georgia,serif; font-size:44px; color:rgba(232,185,60,.55); line-height:1;">01</div>
      <h3 style="font-size:25px; margin:14px 0 10px;">Rigor sem medo</h3>
      <p class="mut" style="font-size:15.5px;">Exigimos técnica correta desde o início — porque é isso que protege as articulações e abre portas mais tarde.</p>
    </div>
    <div class="card" style="padding:34px; border-radius:4px;">
      <div style="font-family:Instrument Serif,Georgia,serif; font-size:44px; color:rgba(232,185,60,.55); line-height:1;">02</div>
      <h3 style="font-size:25px; margin:14px 0 10px;">Equipa acima de tudo</h3>
      <p class="mut" style="font-size:15.5px;">Compete-se sozinho na pista, mas treina-se em grupo. As mais velhas ajudam as mais novas — é assim que funciona cá.</p>
    </div>
    <div class="card" style="padding:34px; border-radius:4px;">
      <div style="font-family:Instrument Serif,Georgia,serif; font-size:44px; color:rgba(232,185,60,.55); line-height:1;">03</div>
      <h3 style="font-size:25px; margin:14px 0 10px;">Portas abertas</h3>
      <p class="mut" style="font-size:15.5px;">Do lazer à alta competição. Ninguém precisa de ter jeito para começar: precisa de querer voltar na semana seguinte.</p>
    </div>
  </div>
</div>

<!-- PERCURSO -->
<div style="display:grid; grid-template-columns:.9fr 1.1fr; gap:72px; padding:104px 96px; align-items:start;">
  <div>
    <div class="ey" style="margin-bottom:18px;">Percurso</div>
    <h2 style="font-size:46px; line-height:1.08;">De uma turma<br>a uma <span class="it">equipa</span>.</h2>
    <div class="ph" style="height:230px; border-radius:4px; margin-top:36px;"><span class="phl">[foto histórica do clube]</span></div>
  </div>
  <div style="padding-left:28px; border-left:1px solid rgba(232,185,60,.25);">
    <div style="margin-bottom:34px;">
      <div style="font-family:Instrument Serif,Georgia,serif; font-size:30px; color:#E8B93C;">[ano]</div>
      <h3 style="font-size:22px; margin:2px 0 6px;">Fundação do clube</h3>
      <p class="mut" style="font-size:15.5px;">[Breve descrição de como e por quem o clube foi criado.]</p>
    </div>
    <div style="margin-bottom:34px;">
      <div style="font-family:Instrument Serif,Georgia,serif; font-size:30px; color:#E8B93C;">[ano]</div>
      <h3 style="font-size:22px; margin:2px 0 6px;">Primeira equipa de competição</h3>
      <p class="mut" style="font-size:15.5px;">[Primeiras atletas federadas e primeira participação em prova oficial.]</p>
    </div>
    <div style="margin-bottom:34px;">
      <div style="font-family:Instrument Serif,Georgia,serif; font-size:30px; color:#E8B93C;">[ano]</div>
      <h3 style="font-size:22px; margin:2px 0 6px;">[Marco importante]</h3>
      <p class="mut" style="font-size:15.5px;">[Título, subida de escalão, novo pavilhão, aumento de turmas…]</p>
    </div>
    <div>
      <div style="font-family:Instrument Serif,Georgia,serif; font-size:30px; color:#E8B93C;">Hoje</div>
      <h3 style="font-size:22px; margin:2px 0 6px;">[N] atletas em [N] escalões</h3>
      <p class="mut" style="font-size:15.5px;">Treinos no [pavilhão], competição federada e uma gala anual que enche a sala.</p>
    </div>
  </div>
</div>

<!-- EQUIPAMENTO -->
<div style="padding:0 96px 104px;">
  <div class="card" style="display:grid; grid-template-columns:1.15fr .85fr; gap:56px; align-items:center; padding:56px; border-radius:6px;">
    <div>
      <div class="ey" style="margin-bottom:18px;">Identidade</div>
      <h2 style="font-size:44px; line-height:1.08;">Preto, vermelho<br>e uma linha <span class="it">dourada</span>.</h2>
      <p class="mut" style="font-size:16.5px; margin-top:22px;">O equipamento de competição segue o emblema: o preto do fundo, o degradê vermelho dos anéis e a linha dourada da patinadora. Cada atleta recebe-o ao entrar para a equipa de competição.</p>
      <div style="display:flex; gap:12px; margin-top:28px;">
        <span style="width:44px; height:44px; border-radius:50%; background:#0A0709; border:1px solid rgba(246,241,236,.2);"></span>
        <span style="width:44px; height:44px; border-radius:50%; background:linear-gradient(140deg,#FF3A4E,#8E0F21);"></span>
        <span style="width:44px; height:44px; border-radius:50%; background:linear-gradient(140deg,#FFE9A8,#C08C24);"></span>
        <span style="width:44px; height:44px; border-radius:50%; background:#0E6B37;"></span>
      </div>
    </div>
    <div style="display:grid; grid-template-columns:1fr 1fr; gap:14px;">
      <div class="ph" style="height:210px; border-radius:4px;"><span class="phl">[fato — frente]</span></div>
      <div class="ph" style="height:210px; border-radius:4px;"><span class="phl">[fato — perfil]</span></div>
    </div>
  </div>
</div>
EOF
footer_html
tail_html
} > Sobre.dc.html

# =========================================================
#  EQUIPA TÉCNICA
# =========================================================
coach() { # $1 nome, $2 função, $3 bio, $4 chip
cat <<EOF
<div class="card" style="border-radius:4px; overflow:hidden;">
  <div class="ph" style="height:290px;"><span class="phl">[fotografia]</span></div>
  <div style="padding:26px 26px 30px;">
    <h3 style="font-size:25px;">$1</h3>
    <div class="ey" style="display:block; margin:6px 0 14px; font-size:10.5px;">$2</div>
    <p class="mut" style="font-size:15px;">$3</p>
    <div style="margin-top:18px;"><span class="chip">$4</span></div>
  </div>
</div>
EOF
}
{
head_html
nav_html equipa
pagehead "Equipa Técnica" "Quem treina" "As pessoas que estão na <span class=\"it\">pista</span> convosco." "Treinadoras e treinadores certificados, coreógrafos e a direção do clube. É com esta equipa que cada atleta trabalha, semana a semana."
cat <<'EOF'
<div style="padding:96px 96px 0;">
  <div style="display:grid; grid-template-columns:repeat(3,minmax(0,1fr)); gap:24px;">
EOF
coach "[Nome da treinadora]" "Treinadora principal · Artística" "[Anos de experiência, percurso como atleta, certificação de treinador e escalões que acompanha.]" "Grau [—] FPP"
coach "[Nome do treinador]" "Treinador · Escola de patinagem" "[Percurso, formação e turmas que acompanha — iniciação e primeiros escalões.]" "Iniciação"
coach "[Nome]" "Coreografia e expressão" "[Formação em dança/expressão corporal e trabalho com os programas livres da equipa.]" "Coreografia"
cat <<'EOF'
  </div>
  <div style="display:grid; grid-template-columns:repeat(3,minmax(0,1fr)); gap:24px; margin-top:24px;">
EOF
coach "[Nome]" "Preparação física" "[Trabalho de condição física, prevenção de lesões e acompanhamento fora da pista.]" "Condição física"
coach "[Nome]" "Direção · Presidente" "[Responsável pela gestão do clube, ligação à federação e à autarquia.]" "Direção"
coach "[Nome]" "Secretaria e inscrições" "[Ponto de contacto para famílias: inscrições, quotas, licenças e documentação.]" "Apoio às famílias"
cat <<'EOF'
  </div>
</div>

<!-- FILOSOFIA -->
<div style="padding:104px 96px;">
  <div class="card" style="padding:64px; border-radius:6px; background:radial-gradient(80% 130% at 12% 0%, rgba(212,16,42,.26), transparent 62%), linear-gradient(160deg,#150F13,#0C080B);">
    <div class="ey" style="margin-bottom:20px;">Como treinamos</div>
    <h2 style="font-size:46px; line-height:1.08; max-width:22ch;">Um plano por atleta, não um plano por turma.</h2>
    <div style="display:grid; grid-template-columns:repeat(3,minmax(0,1fr)); gap:40px; margin-top:52px;">
      <div>
        <h3 style="font-size:21px; color:#E8B93C;">Avaliação no início da época</h3>
        <p class="mut" style="font-size:15.5px; margin-top:8px;">Cada atleta é avaliada tecnicamente e define-se com a família os objetivos até junho.</p>
      </div>
      <div>
        <h3 style="font-size:21px; color:#E8B93C;">Acompanhamento contínuo</h3>
        <p class="mut" style="font-size:15.5px; margin-top:8px;">Feedback regular aos encarregados de educação e ajustes ao plano sempre que é preciso.</p>
      </div>
      <div>
        <h3 style="font-size:21px; color:#E8B93C;">Competir com sentido</h3>
        <p class="mut" style="font-size:15.5px; margin-top:8px;">Ninguém vai a prova sem estar preparada. A prova é a consequência do treino, não o contrário.</p>
      </div>
    </div>
  </div>
</div>
EOF
footer_html
tail_html
} > EquipaTecnica.dc.html

# =========================================================
#  ATLETAS
# =========================================================
athlete() { # $1 nome, $2 escalão, $3 nota
cat <<EOF
<div class="card" style="border-radius:4px; overflow:hidden;">
  <div class="ph" style="height:230px;"><span class="phl">[fotografia]</span></div>
  <div style="padding:20px 22px 24px;">
    <h3 style="font-size:21px;">$1</h3>
    <div class="dim" style="font-size:13px; margin-top:2px;">$3</div>
    <div style="margin-top:14px;"><span class="chip" style="font-size:10px;">$2</span></div>
  </div>
</div>
EOF
}
{
head_html
nav_html atletas
pagehead "Atletas" "A equipa" "Quem veste o <span class=\"it\">preto e vermelho</span>." "Do primeiro ano de escola aos escalões federados. Filtra por escalão para conheceres cada grupo do clube."
cat <<'EOF'
<div style="padding:72px 96px 0;">
  <div style="display:flex; flex-wrap:wrap; gap:10px; margin-bottom:44px;">
    <span style="padding:11px 22px; border-radius:999px; font-size:14px; font-weight:600; background:linear-gradient(120deg,#D4102A,#7A0C1B); color:#fff;">Todos</span>
    <span style="padding:11px 22px; border-radius:999px; font-size:14px; font-weight:500; border:1px solid rgba(246,241,236,.14); color:#A79DA4;">Escola</span>
    <span style="padding:11px 22px; border-radius:999px; font-size:14px; font-weight:500; border:1px solid rgba(246,241,236,.14); color:#A79DA4;">Iniciados</span>
    <span style="padding:11px 22px; border-radius:999px; font-size:14px; font-weight:500; border:1px solid rgba(246,241,236,.14); color:#A79DA4;">Cadetes</span>
    <span style="padding:11px 22px; border-radius:999px; font-size:14px; font-weight:500; border:1px solid rgba(246,241,236,.14); color:#A79DA4;">Infantis</span>
    <span style="padding:11px 22px; border-radius:999px; font-size:14px; font-weight:500; border:1px solid rgba(246,241,236,.14); color:#A79DA4;">Juvenis</span>
    <span style="padding:11px 22px; border-radius:999px; font-size:14px; font-weight:500; border:1px solid rgba(246,241,236,.14); color:#A79DA4;">Juniores</span>
    <span style="padding:11px 22px; border-radius:999px; font-size:14px; font-weight:500; border:1px solid rgba(246,241,236,.14); color:#A79DA4;">Seniores</span>
  </div>
  <div style="display:grid; grid-template-columns:repeat(4,minmax(0,1fr)); gap:20px;">
EOF
athlete "[Nome da atleta]" "Cadetes" "No clube desde [ano]"
athlete "[Nome da atleta]" "Infantis" "No clube desde [ano]"
athlete "[Nome da atleta]" "Iniciados" "No clube desde [ano]"
athlete "[Nome da atleta]" "Juvenis" "No clube desde [ano]"
cat <<'EOF'
  </div>
  <div style="display:grid; grid-template-columns:repeat(4,minmax(0,1fr)); gap:20px; margin-top:20px;">
EOF
athlete "[Nome da atleta]" "Escola" "No clube desde [ano]"
athlete "[Nome do atleta]" "Cadetes" "No clube desde [ano]"
athlete "[Nome da atleta]" "Juniores" "No clube desde [ano]"
athlete "[Nome da atleta]" "Escola" "No clube desde [ano]"
cat <<'EOF'
  </div>
</div>

<!-- DESTAQUES -->
<div style="padding:104px 96px;">
  <hr class="hair" style="margin-bottom:60px;">
  <div class="ey" style="margin-bottom:18px;">Época [ano/ano]</div>
  <h2 style="font-size:48px; margin-bottom:40px;">Resultados a <span class="it">guardar</span></h2>
  <div style="display:grid; grid-template-columns:repeat(3,minmax(0,1fr)); gap:24px;">
    <div class="card" style="padding:34px; border-radius:4px; border-color:rgba(232,185,60,.28);">
      <div style="display:flex; align-items:center; gap:10px; color:#E8B93C;">
        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#E8B93C" stroke-width="1.5"><circle cx="12" cy="9" r="5"/><path d="M8.5 13.5L7 21l5-2.5L17 21l-1.5-7.5"/></svg>
        <span style="font-size:12px; letter-spacing:.2em; text-transform:uppercase; font-weight:600;">[Classificação]</span>
      </div>
      <h3 style="font-size:24px; margin:16px 0 6px;">[Nome da atleta]</h3>
      <p class="mut" style="font-size:15px;">[Prova] · [escalão] · [local e data]</p>
    </div>
    <div class="card" style="padding:34px; border-radius:4px;">
      <div style="display:flex; align-items:center; gap:10px; color:#E8B93C;">
        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#E8B93C" stroke-width="1.5"><circle cx="12" cy="9" r="5"/><path d="M8.5 13.5L7 21l5-2.5L17 21l-1.5-7.5"/></svg>
        <span style="font-size:12px; letter-spacing:.2em; text-transform:uppercase; font-weight:600;">[Classificação]</span>
      </div>
      <h3 style="font-size:24px; margin:16px 0 6px;">[Nome da atleta]</h3>
      <p class="mut" style="font-size:15px;">[Prova] · [escalão] · [local e data]</p>
    </div>
    <div class="card" style="padding:34px; border-radius:4px;">
      <div style="display:flex; align-items:center; gap:10px; color:#E8B93C;">
        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#E8B93C" stroke-width="1.5"><path d="M4 5h16v6a8 8 0 01-16 0z"/><path d="M4 7H2.5v2a3 3 0 003 3M20 7h1.5v2a3 3 0 01-3 3"/><path d="M9 21h6"/></svg>
        <span style="font-size:12px; letter-spacing:.2em; text-transform:uppercase; font-weight:600;">Equipa</span>
      </div>
      <h3 style="font-size:24px; margin:16px 0 6px;">Grupo de [—]</h3>
      <p class="mut" style="font-size:15px;">[Prova de conjuntos] · [local e data]</p>
    </div>
  </div>
</div>
EOF
footer_html
tail_html
} > Atletas.dc.html

# =========================================================
#  EVENTOS
# =========================================================
evrow() { # $1 dia, $2 mes, $3 titulo, $4 detalhe, $5 chip-class, $6 chip, $7 opacidade
cat <<EOF
<div class="card" style="display:grid; grid-template-columns:88px 1fr auto; gap:28px; align-items:center; padding:22px 28px; border-radius:4px; opacity:$7;">
  <div style="text-align:center; padding:12px 0; border-radius:3px; background:linear-gradient(150deg,#D4102A,#7A0C1B);">
    <div style="font-family:Instrument Serif,Georgia,serif; font-size:30px; line-height:1;">$1</div>
    <div style="font-size:10.5px; letter-spacing:.2em; text-transform:uppercase; opacity:.85;">$2</div>
  </div>
  <div>
    <h3 style="font-size:23px;">$3</h3>
    <p class="dim" style="font-size:14px; margin-top:4px;">$4</p>
  </div>
  <span class="chip $5">$6</span>
</div>
EOF
}
{
head_html
nav_html eventos
pagehead "Eventos" "Calendário" "A época, de <span class=\"it\">setembro a junho</span>." "Provas federadas, galas, estágios e os momentos do clube. As datas confirmadas são atualizadas sempre que a federação publica o calendário."
cat <<'EOF'
<!-- DESTAQUE -->
<div style="padding:80px 96px 0;">
  <div class="card" style="display:grid; grid-template-columns:1fr 1fr; gap:0; border-radius:6px; overflow:hidden; border-color:rgba(232,185,60,.22);">
    <div style="padding:56px;">
      <span class="chip r">Próximo evento</span>
      <h2 style="font-size:46px; line-height:1.08; margin:24px 0 16px;">Gala de Natal<br>do <span class="it">CPBVM</span></h2>
      <p class="mut" style="font-size:16.5px;">Todas as turmas em palco, das mais pequenas à equipa de competição. É o momento em que o clube se mostra inteiro — e a sala enche sempre.</p>
      <div style="display:grid; grid-template-columns:1fr 1fr; gap:22px; margin-top:34px; padding-top:26px; border-top:1px solid rgba(246,241,236,.08);">
        <div><div class="ey" style="font-size:10px;">Data</div><div style="font-size:16px; margin-top:5px;">[dia] de [mês], [hora]</div></div>
        <div><div class="ey" style="font-size:10px;">Local</div><div style="font-size:16px; margin-top:5px;">[Pavilhão], Montijo</div></div>
        <div><div class="ey" style="font-size:10px;">Bilhetes</div><div style="font-size:16px; margin-top:5px;">[valor] · [onde comprar]</div></div>
        <div><div class="ey" style="font-size:10px;">Duração</div><div style="font-size:16px; margin-top:5px;">[cerca de X horas]</div></div>
      </div>
      <div style="margin-top:34px;"><span class="btn">Reservar bilhete</span></div>
    </div>
    <div class="ph" style="min-height:430px;"><span class="phl">[foto da gala do ano passado]</span></div>
  </div>
</div>

<!-- PRÓXIMOS -->
<div style="padding:88px 96px 0;">
  <h2 style="font-size:42px; margin-bottom:32px;">Próximos</h2>
  <div style="display:flex; flex-direction:column; gap:12px;">
EOF
evrow "[00]" "[Mês]" "Torneio de Abertura de Época" "[Pavilhão] · [Localidade] · escalões [—]" "r" "Competição" "1"
evrow "[00]" "[Mês]" "Estágio técnico de inverno" "[Local] · inscrição prévia até [data]" "g" "Formação" "1"
evrow "[00]" "[Mês]" "Taça Regional — 1.ª jornada" "[Pavilhão] · [Localidade]" "r" "Competição" "1"
evrow "[00]" "[Mês]" "Convívio de famílias do clube" "[Local] · aberto a pais e encarregados de educação" "" "Clube" "1"
cat <<'EOF'
  </div>
</div>

<!-- PASSADOS -->
<div style="padding:80px 96px 104px;">
  <hr class="hair" style="margin-bottom:56px;">
  <h2 style="font-size:38px; margin-bottom:28px;" class="mut">Já aconteceram</h2>
  <div style="display:flex; flex-direction:column; gap:12px;">
EOF
evrow "[00]" "[Mês]" "[Nome da prova]" "[Local] · [resultados do clube]" "" "Competição" ".55"
evrow "[00]" "[Mês]" "Apresentação da época [ano/ano]" "[Pavilhão], Montijo" "" "Clube" ".55"
evrow "[00]" "[Mês]" "Aulas abertas de experimentação" "[Local] · [n.º] novos inscritos" "" "Escola" ".55"
cat <<'EOF'
  </div>
</div>
EOF
footer_html
tail_html
} > Eventos.dc.html

# =========================================================
#  INSCRIÇÕES
# =========================================================
field() { # $1 label, $2 placeholder, $3 tipo(select?)
  local arrow=""
  [ "${3:-}" = "select" ] && arrow='<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#E8B93C" stroke-width="1.8" style="position:absolute; right:16px; top:44px;"><path d="M6 9l6 6 6-6"/></svg>'
cat <<EOF
<div style="position:relative;">
  <div style="font-size:11px; font-weight:600; letter-spacing:.16em; text-transform:uppercase; color:#A79DA4; margin-bottom:9px;">$1</div>
  <div style="padding:15px 18px; border:1px solid rgba(246,241,236,.13); border-radius:3px; background:rgba(246,241,236,.03); font-size:15px; color:#6E6670;">$2</div>
  $arrow
</div>
EOF
}
{
head_html
nav_html contactos
pagehead "Inscrições" "Época [ano/ano]" "Começar é mais simples do que <span class=\"it\">parece</span>." "Aula experimental gratuita, sem compromisso. Traz roupa confortável e meias altas — os patins emprestamos nós."
cat <<'EOF'
<!-- PASSOS -->
<div style="padding:88px 96px 0;">
  <div style="display:grid; grid-template-columns:repeat(3,minmax(0,1fr)); gap:24px;">
    <div class="card" style="padding:36px; border-radius:4px;">
      <div style="width:46px; height:46px; border-radius:50%; border:1px solid rgba(232,185,60,.4); display:flex; align-items:center; justify-content:center; font-family:Instrument Serif,Georgia,serif; font-size:22px; color:#E8B93C;">1</div>
      <h3 style="font-size:24px; margin:20px 0 10px;">Marca a aula experimental</h3>
      <p class="mut" style="font-size:15.5px;">Preenche o formulário aqui ao lado. Respondemos em [prazo] com dia e hora.</p>
    </div>
    <div class="card" style="padding:36px; border-radius:4px;">
      <div style="width:46px; height:46px; border-radius:50%; border:1px solid rgba(232,185,60,.4); display:flex; align-items:center; justify-content:center; font-family:Instrument Serif,Georgia,serif; font-size:22px; color:#E8B93C;">2</div>
      <h3 style="font-size:24px; margin:20px 0 10px;">Vem experimentar</h3>
      <p class="mut" style="font-size:15.5px;">Uma aula completa com a turma do escalão certo. Sem custos e sem compromisso.</p>
    </div>
    <div class="card" style="padding:36px; border-radius:4px;">
      <div style="width:46px; height:46px; border-radius:50%; border:1px solid rgba(232,185,60,.4); display:flex; align-items:center; justify-content:center; font-family:Instrument Serif,Georgia,serif; font-size:22px; color:#E8B93C;">3</div>
      <h3 style="font-size:24px; margin:20px 0 10px;">Formaliza a inscrição</h3>
      <p class="mut" style="font-size:15.5px;">Ficha de sócio, documentos e primeira mensalidade. A partir daí, és do clube.</p>
    </div>
  </div>
</div>

<!-- QUOTAS + FORMULÁRIO -->
<div style="display:grid; grid-template-columns:.95fr 1.05fr; gap:56px; padding:96px 96px 0; align-items:start;">
  <div>
    <div class="ey" style="margin-bottom:18px;">Mensalidades</div>
    <h2 style="font-size:42px; line-height:1.08; margin-bottom:30px;">Escolhe o <span class="it">ritmo</span></h2>
    <div style="display:flex; flex-direction:column; gap:14px;">
      <div class="card" style="display:flex; justify-content:space-between; align-items:center; padding:26px 30px; border-radius:4px;">
        <div>
          <h3 style="font-size:22px;">Escola — 1x por semana</h3>
          <p class="dim" style="font-size:14px; margin-top:3px;">[dia] · [horário] · a partir dos [idade] anos</p>
        </div>
        <div style="font-family:Instrument Serif,Georgia,serif; font-size:34px; color:#E8B93C;">[00]€</div>
      </div>
      <div class="card" style="display:flex; justify-content:space-between; align-items:center; padding:26px 30px; border-radius:4px; border-color:rgba(232,185,60,.3);">
        <div>
          <h3 style="font-size:22px;">Escola — 2x por semana</h3>
          <p class="dim" style="font-size:14px; margin-top:3px;">[dias] · [horário] · o mais escolhido</p>
        </div>
        <div style="font-family:Instrument Serif,Georgia,serif; font-size:34px; color:#E8B93C;">[00]€</div>
      </div>
      <div class="card" style="display:flex; justify-content:space-between; align-items:center; padding:26px 30px; border-radius:4px;">
        <div>
          <h3 style="font-size:22px;">Competição</h3>
          <p class="dim" style="font-size:14px; margin-top:3px;">[n.º] treinos semanais · inclui acompanhamento a provas</p>
        </div>
        <div style="font-family:Instrument Serif,Georgia,serif; font-size:34px; color:#E8B93C;">[00]€</div>
      </div>
    </div>
    <div class="card" style="padding:26px 30px; border-radius:4px; margin-top:22px;">
      <div class="ey" style="margin-bottom:14px; font-size:10px;">A ter em conta</div>
      <div style="display:flex; flex-direction:column; gap:9px; font-size:15px; color:#A79DA4;">
        <span>· Joia de inscrição anual: [00]€ (inclui seguro desportivo)</span>
        <span>· Desconto de irmãos: [—]%</span>
        <span>· Equipamento de competição: [00]€, uma vez por época</span>
        <span>· Licença federativa: [00]€ para atletas de competição</span>
      </div>
    </div>
  </div>

  <div class="card" style="padding:48px; border-radius:6px; background:radial-gradient(90% 120% at 90% 0%, rgba(212,16,42,.24), transparent 62%), linear-gradient(160deg,#150F13,#0C080B);">
    <div class="ey" style="margin-bottom:16px;">Formulário</div>
    <h2 style="font-size:36px; margin-bottom:30px;">Pedido de aula experimental</h2>
    <div style="display:grid; grid-template-columns:1fr 1fr; gap:20px;">
EOF
field "Nome do atleta" "Nome completo"
field "Data de nascimento" "DD / MM / AAAA"
field "Encarregado de educação" "Nome completo"
field "Telemóvel" "9XX XXX XXX"
cat <<'EOF'
    </div>
    <div style="margin-top:20px;">
EOF
field "E-mail" "nome@exemplo.pt"
cat <<'EOF'
    </div>
    <div style="display:grid; grid-template-columns:1fr 1fr; gap:20px; margin-top:20px;">
EOF
field "Já patina?" "Selecionar…" select
field "Preferência de horário" "Selecionar…" select
cat <<'EOF'
    </div>
    <div style="margin-top:20px;">
      <div style="font-size:11px; font-weight:600; letter-spacing:.16em; text-transform:uppercase; color:#A79DA4; margin-bottom:9px;">Mensagem (opcional)</div>
      <div style="padding:15px 18px; height:96px; border:1px solid rgba(246,241,236,.13); border-radius:3px; background:rgba(246,241,236,.03); font-size:15px; color:#6E6670;">Alguma coisa que devamos saber?</div>
    </div>
    <div style="display:flex; gap:12px; align-items:flex-start; margin-top:24px;">
      <span style="width:20px; height:20px; border:1px solid rgba(246,241,236,.25); border-radius:3px; flex:none; margin-top:2px;"></span>
      <span class="mut" style="font-size:14px;">Autorizo o tratamento dos dados para efeitos de contacto, nos termos da política de privacidade do clube.</span>
    </div>
    <div style="margin-top:30px;"><span class="btn" style="display:block; text-align:center;">Enviar pedido</span></div>
    <p class="dim" style="font-size:13px; text-align:center; margin-top:16px;">Respondemos em [prazo]. Preferes falar? [telefone]</p>
  </div>
</div>

<!-- FAQ -->
<div style="padding:96px 96px 104px;">
  <hr class="hair" style="margin-bottom:60px;">
  <div style="display:grid; grid-template-columns:.8fr 1.2fr; gap:56px;">
    <div>
      <div class="ey" style="margin-bottom:18px;">Dúvidas</div>
      <h2 style="font-size:42px; line-height:1.08;">Perguntas que<br>nos fazem <span class="it">sempre</span></h2>
    </div>
    <div style="display:flex; flex-direction:column; gap:1px; background:rgba(246,241,236,.08);">
      <div style="background:#0A0709; padding:24px 4px;">
        <div style="display:flex; justify-content:space-between; align-items:center;">
          <h3 style="font-size:21px;">A partir de que idade se pode começar?</h3><span style="color:#E8B93C; font-size:22px;">−</span>
        </div>
        <p class="mut" style="font-size:15.5px; margin-top:12px; max-width:62ch;">[Idade mínima e como funcionam as turmas dos mais pequenos.]</p>
      </div>
      <div style="background:#0A0709; padding:24px 4px;">
        <div style="display:flex; justify-content:space-between; align-items:center;">
          <h3 style="font-size:21px;">É preciso ter patins?</h3><span style="color:#E8B93C; font-size:22px;">+</span>
        </div>
      </div>
      <div style="background:#0A0709; padding:24px 4px;">
        <div style="display:flex; justify-content:space-between; align-items:center;">
          <h3 style="font-size:21px;">Quantos treinos tem cada escalão?</h3><span style="color:#E8B93C; font-size:22px;">+</span>
        </div>
      </div>
      <div style="background:#0A0709; padding:24px 4px;">
        <div style="display:flex; justify-content:space-between; align-items:center;">
          <h3 style="font-size:21px;">Que documentos são precisos para a inscrição?</h3><span style="color:#E8B93C; font-size:22px;">+</span>
        </div>
      </div>
      <div style="background:#0A0709; padding:24px 4px;">
        <div style="display:flex; justify-content:space-between; align-items:center;">
          <h3 style="font-size:21px;">Pode-se entrar a meio da época?</h3><span style="color:#E8B93C; font-size:22px;">+</span>
        </div>
      </div>
    </div>
  </div>
</div>
EOF
footer_html
tail_html
} > Inscricoes.dc.html

# =========================================================
#  MOBILE — HOMEPAGE (390px)
# =========================================================
{
head_html
cat <<'EOF'
<div style="width:390px;">
  <div style="display:flex; align-items:center; justify-content:space-between; padding:16px 20px; border-bottom:1px solid rgba(246,241,236,.07);">
    <div style="display:flex; align-items:center; gap:10px;">
EOF
emblem 38 "m"
cat <<'EOF'
      <span style="font-family:Instrument Serif,Georgia,serif; font-size:16px; line-height:1.1;">Clube de Patinagem BVM</span>
    </div>
    <span style="width:44px; height:44px; border:1px solid rgba(246,241,236,.14); border-radius:10px; display:flex; flex-direction:column; justify-content:center; align-items:center; gap:5px;">
      <span style="width:18px; height:1.5px; background:#F6F1EC; display:block;"></span>
      <span style="width:18px; height:1.5px; background:#F6F1EC; display:block;"></span>
    </span>
  </div>

  <div style="padding:40px 20px 44px; text-align:center;">
    <div class="ey" style="font-size:10px;">Patinagem artística · Montijo</div>
    <h1 style="font-size:46px; line-height:1.02; margin-top:18px;">Onde a técnica encontra a <span class="it">arte</span>.</h1>
    <p class="mut" style="font-size:16px; margin-top:18px;">Escola de patinagem e equipa de competição no Montijo, dos primeiros passos ao pódio.</p>
    <div style="display:flex; flex-direction:column; gap:10px; margin-top:28px;">
      <span class="btn" style="display:block; text-align:center; padding:17px;">Inscrever atleta</span>
      <span class="btn gh" style="display:block; text-align:center; padding:17px;">Conhecer o clube</span>
    </div>
    <div style="position:relative; display:flex; justify-content:center; margin-top:44px;">
      <div style="position:absolute; width:250px; height:250px; border-radius:50%; background:radial-gradient(circle, rgba(212,16,42,.45), rgba(212,16,42,0) 66%); top:-8px;"></div>
EOF
emblem 234 "mb"
cat <<'EOF'
    </div>
  </div>

  <div style="display:flex; gap:18px; justify-content:center; padding:14px 20px; border-block:1px solid rgba(246,241,236,.07); background:linear-gradient(90deg, rgba(212,16,42,.14), rgba(232,185,60,.12));">
    <span class="ey" style="font-size:10px; color:rgba(246,241,236,.6);">Técnica</span><span style="color:#E8B93C; font-size:10px;">◆</span>
    <span class="ey" style="font-size:10px; color:rgba(246,241,236,.6);">Arte</span><span style="color:#E8B93C; font-size:10px;">◆</span>
    <span class="ey" style="font-size:10px; color:rgba(246,241,236,.6);">Equipa</span>
  </div>

  <div style="padding:44px 20px 0;">
    <div class="ey" style="font-size:10px;">O que fazemos</div>
    <h2 style="font-size:34px; line-height:1.06; margin-top:14px;">Três caminhos, a mesma <span class="it">pista</span>.</h2>
    <div style="display:flex; flex-direction:column; gap:14px; margin-top:28px;">
      <div class="card" style="padding:26px; border-radius:4px;">
        <h3 style="font-size:22px;">Escola de Patinagem</h3>
        <p class="mut" style="font-size:15px; margin-top:8px;">Primeiros passos e confiança sobre rodas, a partir dos [idade] anos.</p>
      </div>
      <div class="card" style="padding:26px; border-radius:4px; border-color:rgba(232,185,60,.22);">
        <h3 style="font-size:22px;">Artística — Competição</h3>
        <p class="mut" style="font-size:15px; margin-top:8px;">Treino técnico e coreográfico para provas regionais e nacionais.</p>
      </div>
      <div class="card" style="padding:26px; border-radius:4px;">
        <h3 style="font-size:22px;">Grupos &amp; Exibições</h3>
        <p class="mut" style="font-size:15px; margin-top:8px;">Coreografias de conjunto, galas e o espetáculo de fim de época.</p>
      </div>
    </div>
  </div>

  <div style="padding:44px 20px 0;">
    <div class="card" style="display:grid; grid-template-columns:64px 1fr; gap:18px; align-items:center; padding:18px; border-radius:4px;">
      <div style="text-align:center; padding:10px 0; border-radius:3px; background:linear-gradient(150deg,#D4102A,#7A0C1B);">
        <div style="font-family:Instrument Serif,Georgia,serif; font-size:24px; line-height:1;">[00]</div>
        <div style="font-size:9px; letter-spacing:.2em; text-transform:uppercase;">[Mês]</div>
      </div>
      <div>
        <h3 style="font-size:19px;">Gala de Natal do CPBVM</h3>
        <p class="dim" style="font-size:13px; margin-top:2px;">[Pavilhão] · Montijo</p>
      </div>
    </div>
  </div>

  <div style="padding:44px 20px 52px;">
    <div style="border:1px solid rgba(232,185,60,.18); border-radius:6px; padding:36px 24px; text-align:center;
      background:radial-gradient(90% 130% at 20% 0%, rgba(212,16,42,.4), transparent 62%), linear-gradient(160deg,#150F13,#0C080B);">
      <h2 style="font-size:32px; line-height:1.08;">Inscrições <span class="it">abertas</span></h2>
      <p class="mut" style="font-size:15px; margin-top:12px;">Aula experimental gratuita. Os patins podemos emprestar.</p>
      <span class="btn" style="display:block; text-align:center; padding:16px; margin-top:22px;">Quero inscrever-me</span>
    </div>
  </div>
</div>
EOF
tail_html
} > MobileHome.dc.html
