#!/usr/bin/env bash
# Gera os artboards .dc.html dos mockups do CPBVM.
# NOTA: todos os nomes, datas, valores e resultados são de exemplo (fictícios).
set -euo pipefail
cd "$(dirname "$0")"

# ---------- emblema (decalque provisório do emblema real) ----------
emblem() { # $1 = tamanho px, $2 = sufixo de id, $3 = "texto" para incluir o lettering circular
local T="${3:-}"
cat <<EOF
<svg viewBox="0 0 200 200" width="$1" height="$1" role="img" aria-label="Emblema do Clube de Patinagem BVM Montijo" style="display:block">
  <defs>
    <path id="tp$2" d="M100,100 m-77,0 a77,77 0 1,1 154,0" fill="none"/>
    <path id="bp$2" d="M100,100 m-74,0 a74,74 0 1,0 148,0" fill="none"/>
  </defs>
  <circle cx="100" cy="100" r="100" fill="#000000"/>
  <circle cx="100" cy="100" r="94" fill="none" stroke="#F0401C" stroke-width="6"/>
  <g fill="none" stroke="#0C5A34" stroke-linecap="round">
    <path d="M100,100 m-63,0 a63,63 0 1,1 44,58" stroke-width="3.4" opacity=".95"/>
    <path d="M100,100 m-57,0 a57,57 0 1,1 52,34" stroke-width="2.4" opacity=".8" transform="rotate(24 100 100)"/>
    <path d="M100,100 m-52,0 a52,52 0 1,1 46,30" stroke-width="1.8" opacity=".6" transform="rotate(-38 100 100)"/>
    <path d="M100,100 m-67,0 a67,67 0 0,1 40,-58" stroke-width="2" opacity=".55" transform="rotate(140 100 100)"/>
  </g>
  <g fill="#E63917">
    <circle cx="99" cy="55" r="7.4"/>
    <path d="M92.5 51.5c-3.4-1.2-5.6-.2-6.2 1.6-.5 1.7 1 3.2 3.6 3.3z"/>
    <path d="M92.6 64.5c3.8-1.6 8.4-1.6 12.2.2 2.2 1 3.3 3 3.1 5.6l-1.6 22c-.2 2.4-1.6 3.7-4.2 3.9l-8.4.2c-2.6 0-4-1.2-4.2-3.6l-1.6-22.4c-.2-2.7 1-4.7 4.7-5.9z"/>
    <path d="M104.4 68.6l3.4-3.1 12.8-13.6 2.6-3.6c1-1.4 2.6-1.7 3.9-.7 1.3 1 1.5 2.6.6 4l-3 4.2-13.6 14.6-3.6 3.3z"/>
    <path d="M124.2 44.4l2.6-3.4c.9-1.2 2.3-1.5 3.4-.7 1.1.8 1.3 2.2.5 3.4l-2.5 3.6z"/>
    <path d="M91.6 72.2l-4.4.4-17.6 2.1-4.2.9c-1.6.3-3-.6-3.2-2.2-.2-1.6.8-2.8 2.4-3.1l4.6-.8 18-1.9 4.3-.2z"/>
    <path d="M65.2 69.6l-4.3.6c-1.4.2-2.6-.6-2.8-1.9-.2-1.3.7-2.4 2.1-2.6l4.2-.6z"/>
    <path d="M89.6 92.4l12.4-.3c2.6 0 4.4 1.2 5.4 3.6l8.6 21.4c.9 2.2.4 3.9-1.5 5l-4.6 2.6-10.7 4.8c-2.6 1.1-4.8 1-6.6-.6l-9.4-8.6-8.2-8.4 3.2-4.1 9.6 7.2-4.8 8.4-6.6 10.6 6-1.6 12.4-5.2c2.3-1 3.4-2.7 3.2-5l-1-12.6z"/>
    <path d="M97.4 122.6l3.2 20.4.8 14.2-6.2.3-1.2-14.8-2.6-19.4z"/>
    <path d="M108.6 120.2l6.4 19.6 5 13.4-5.7 2.2-5.4-13.8-6.5-18.6z"/>
    <path d="M87.6 155.4l10.8-.4.3 4.6-11 .4z"/>
    <path d="M112.8 151.6l10.2-3.8 1.6 4.3-10.2 3.9z"/>
    <circle cx="89.4" cy="163.4" r="3.2"/><circle cx="97.6" cy="163" r="3.2"/>
    <circle cx="115.4" cy="159.6" r="3.2"/><circle cx="123.2" cy="156.8" r="3.2"/>
  </g>
EOF
if [ -n "$T" ]; then
cat <<EOF
  <text fill="#F2C200" font-family="Archivo, Helvetica, Arial, sans-serif" font-size="17" font-weight="700" letter-spacing="1.2" stroke="#8A5A00" stroke-width=".5">
    <textPath href="#tp$2" startOffset="50%" text-anchor="middle">CLUBE PATINAGEM BVM</textPath>
  </text>
  <text fill="#FFFFFF" font-family="Archivo, Helvetica, Arial, sans-serif" font-size="18" font-weight="700" letter-spacing="2.4">
    <textPath href="#bp$2" startOffset="50%" text-anchor="middle">MONTIJO</textPath>
  </text>
EOF
fi
echo '</svg>'
}

# ---------- ícones ----------
ico_diamond() { printf '%s' '<svg width="7" height="7" viewBox="0 0 10 10" aria-hidden="true" style="display:block"><path d="M5 0l5 5-5 5-5-5z" fill="#E8B93C"/></svg>'; }
ico_arrow()   { printf '%s' '<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#E8B93C" stroke-width="1.7" aria-hidden="true"><path d="M4 12h15"/><path d="M13 6l6 6-6 6"/></svg>'; }
ico_plus()    { printf '%s' '<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#E8B93C" stroke-width="1.7" aria-hidden="true"><path d="M12 5v14"/><path d="M5 12h14"/></svg>'; }
ico_minus()   { printf '%s' '<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#E8B93C" stroke-width="1.7" aria-hidden="true"><path d="M5 12h14"/></svg>'; }

# ---------- foto ----------
photo() { # $1 = ficheiro, $2 = css extra do contentor, $3 = legenda (opcional)
  printf '<div style="position:relative; overflow:hidden; background:#120D11; %s"><img src="%s" alt="" style="width:100%%; height:100%%; object-fit:cover; display:block">' "$2" "$1"
  [ -n "${3:-}" ] && printf '<span style="position:absolute; left:16px; bottom:13px; font-size:11.5px; letter-spacing:.14em; text-transform:uppercase; color:rgba(255,255,255,.85); text-shadow:0 2px 10px rgba(0,0,0,.8);">%s</span>' "$3"
  printf '</div>'
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
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Archivo:wght@400;500;600;700&amp;family=Instrument+Serif:ital@0;1&amp;display=swap">
  <style>
    body{ margin:0; background:#0A0709; color:#F6F1EC;
      font-family:Archivo,'Helvetica Neue',Helvetica,Arial,sans-serif; font-size:17px; line-height:1.7;
      -webkit-font-smoothing:antialiased; }
    a{ color:#E8B93C; text-decoration:none; } a:hover{ color:#FFE9A8; }
    h1,h2,h3{ margin:0; font-family:'Instrument Serif',Georgia,'Times New Roman',serif; font-weight:400;
      letter-spacing:-.015em; line-height:1.1; }
    p{ margin:0; }
    .ey{ font-family:Archivo,Helvetica,Arial,sans-serif; font-size:11.5px; font-weight:600; letter-spacing:.28em;
      text-transform:uppercase; color:#E8B93C; }
    .mut{ color:#A79DA4; }
    .dim{ color:#8C8490; }
    .it{ font-style:italic; color:#E8B93C; }
    .chip{ display:inline-block; padding:5px 12px; border:1px solid rgba(232,185,60,.28); border-radius:999px;
      font-size:11.5px; font-weight:600; letter-spacing:.12em; text-transform:uppercase; color:#E8B93C; }
    .chip.r{ border-color:rgba(212,16,42,.5); color:#FF8A96; }
    .chip.g{ border-color:rgba(14,107,55,.6); color:#6FD69A; }
    .btn{ display:inline-block; padding:16px 30px; border-radius:999px; font-size:14px; font-weight:600;
      letter-spacing:.06em; background:linear-gradient(120deg,#FFE9A8,#E8B93C 55%,#C08C24); color:#1B1206; }
    .btn.gh{ background:none; border:1px solid rgba(246,241,236,.22); color:#F6F1EC; }
    .hair{ height:1px; background:linear-gradient(90deg,transparent,rgba(232,185,60,.35),transparent); border:0; }
    .card{ background:linear-gradient(180deg,#150F13,#0E0A0D); border:1px solid rgba(246,241,236,.08); }
    .date{ text-align:center; padding:12px 0; border-radius:3px; background:linear-gradient(150deg,#D4102A,#7A0C1B); }
    .date b{ display:block; font-family:'Instrument Serif',Georgia,serif; font-size:30px; line-height:1; font-weight:400; }
    .date small{ display:block; font-size:11px; letter-spacing:.2em; text-transform:uppercase; opacity:.9; margin-top:2px; }
  </style>
</helmet>
<div style="background:#0A0709; background-image:radial-gradient(60% 40% at 82% 0%, rgba(212,16,42,.22), transparent 62%), radial-gradient(40% 30% at 8% 12%, rgba(232,185,60,.07), transparent 66%);">
EOF
}

# ---------- navegação ----------
nav_html() { # $1 = chave ativa
  local active="$1"
  printf '%s' '<div style="display:flex; align-items:center; justify-content:space-between; gap:32px; padding:22px 96px; border-bottom:1px solid rgba(246,241,236,.07);">
<div style="display:flex; align-items:center; gap:14px;">'
  emblem 52 "n"
  printf '%s' '<div style="display:flex; flex-direction:column; line-height:1.2;">
<span style="font-family:Instrument Serif,Georgia,serif; font-size:19px;">Clube de Patinagem BVM</span>
<span class="ey" style="font-size:10.5px; letter-spacing:.32em;">Montijo</span>
</div>
</div>
<div style="display:flex; align-items:center; gap:28px;">'
  local pairs=("inicio:Início" "sobre:Sobre" "equipa:Equipa Técnica" "atletas:Atletas" "eventos:Eventos" "contactos:Contactos")
  local p k l col bb
  for p in "${pairs[@]}"; do
    k="${p%%:*}"; l="${p#*:}"
    if [ "$k" = "$active" ]; then col="#F6F1EC"; bb="border-bottom:1px solid #E8B93C;"; else col="#A79DA4"; bb=""; fi
    printf '<span style="font-size:14.5px; font-weight:500; color:%s; padding-bottom:4px;%s">%s</span>' "$col" "$bb" "$l"
  done
  printf '%s' '<span class="btn" style="padding:13px 24px; font-size:13px;">Inscrições abertas</span>
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
  emblem 56 "f"
  printf '%s' '<span style="font-family:Instrument Serif,Georgia,serif; font-size:21px;">Clube de Patinagem BVM</span>
</div>
<p class="mut" style="font-size:15px; max-width:34ch;">Patinagem artística no Montijo desde 2012. Formação, competição e espetáculo — com a mesma equipa desde o primeiro dia sobre patins.</p>
<div style="display:flex; gap:10px; margin-top:22px;">
<span style="width:40px; height:40px; border-radius:50%; border:1px solid rgba(246,241,236,.14); display:flex; align-items:center; justify-content:center;"><svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="#E8B93C" stroke-width="1.6" aria-hidden="true"><rect x="3" y="3" width="18" height="18" rx="5"/><circle cx="12" cy="12" r="4"/><circle cx="17.5" cy="6.5" r="1" fill="#E8B93C" stroke="none"/></svg></span>
<span style="width:40px; height:40px; border-radius:50%; border:1px solid rgba(246,241,236,.14); display:flex; align-items:center; justify-content:center;"><svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="#E8B93C" stroke-width="1.6" aria-hidden="true"><path d="M14 8h2.5V4.5H14c-2.2 0-3.5 1.4-3.5 3.6V10H8v3.5h2.5V21H14v-7.5h2.6l.4-3.5H14V8.4c0-.3.2-.4.5-.4z"/></svg></span>
<span style="width:40px; height:40px; border-radius:50%; border:1px solid rgba(246,241,236,.14); display:flex; align-items:center; justify-content:center;"><svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="#E8B93C" stroke-width="1.6" aria-hidden="true"><path d="M4 6.5h16v11H4z"/><path d="M4 7l8 6 8-6"/></svg></span>
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
<span>Escola de patinagem</span><span>Competição</span><span>Eventos</span><span>Inscrições</span><span>Mensalidades</span>
</div>
</div>
<div>
<div class="ey" style="margin-bottom:18px;">Contactos</div>
<div style="display:flex; flex-direction:column; gap:11px; font-size:15px; color:#A79DA4;">
<span>Pavilhão Municipal do Montijo</span><span>2870-355 Montijo</span><span>geral@cpbvm.pt</span><span>212 345 678</span>
</div>
</div>
</div>
<div style="display:flex; justify-content:space-between; align-items:center; margin-top:56px; padding-top:26px; border-top:1px solid rgba(246,241,236,.07); font-size:13px; color:#8C8490;">
<span>© 2026 Clube de Patinagem BVM · Montijo</span>
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

# ---------- cabeçalho de página interior ----------
pagehead() { # $1 migalhas, $2 eyebrow, $3 título, $4 lead
cat <<EOF
<div style="position:relative; padding:86px 96px 64px; border-bottom:1px solid rgba(246,241,236,.07);
  background:radial-gradient(60% 120% at 82% 0%, rgba(212,16,42,.30), transparent 62%), radial-gradient(40% 80% at 6% 40%, rgba(232,185,60,.08), transparent 66%);">
  <div class="dim" style="font-size:13px; margin-bottom:26px;">Início &nbsp;/&nbsp; $1</div>
  <div class="ey" style="margin-bottom:18px;">$2</div>
  <h1 style="font-size:74px; max-width:20ch;">$3</h1>
  <p class="mut" style="font-size:18px; max-width:56ch; margin-top:24px;">$4</p>
</div>
EOF
}

# =========================================================
#  HOMEPAGE
# =========================================================
{
head_html
nav_html inicio
cat <<'EOF'
<div style="display:grid; grid-template-columns:1.08fr .92fr; gap:64px; align-items:center; padding:88px 96px 80px;">
  <div>
    <div class="ey" style="margin-bottom:26px;">Patinagem artística · Montijo</div>
    <h1 style="font-size:92px; line-height:.98;">Onde a técnica<br>encontra a <span class="it">arte</span>.</h1>
    <p class="mut" style="font-size:19px; max-width:46ch; margin-top:28px;">
      Escola de patinagem e equipa de competição no Montijo. Dos primeiros passos sobre patins ao pódio — com treino sério, ambiente de família e muito brilho.
    </p>
    <div style="display:flex; gap:14px; margin-top:40px;">
      <span class="btn">Inscrever atleta</span>
      <span class="btn gh">Conhecer o clube</span>
    </div>
    <div style="display:flex; gap:44px; margin-top:52px; padding-top:28px; border-top:1px solid rgba(246,241,236,.08);">
      <div><div style="font-family:Instrument Serif,Georgia,serif; font-size:36px; color:#E8B93C; line-height:1;">94</div><div class="dim" style="font-size:12px; letter-spacing:.18em; text-transform:uppercase; margin-top:6px;">Atletas</div></div>
      <div><div style="font-family:Instrument Serif,Georgia,serif; font-size:36px; color:#E8B93C; line-height:1;">7</div><div class="dim" style="font-size:12px; letter-spacing:.18em; text-transform:uppercase; margin-top:6px;">Escalões</div></div>
      <div><div style="font-family:Instrument Serif,Georgia,serif; font-size:36px; color:#E8B93C; line-height:1;">2012</div><div class="dim" style="font-size:12px; letter-spacing:.18em; text-transform:uppercase; margin-top:6px;">Desde</div></div>
    </div>
  </div>
  <div style="position:relative; display:flex; align-items:center; justify-content:center; min-height:520px;">
    <div style="position:absolute; width:420px; height:420px; border-radius:50%; background:radial-gradient(circle, rgba(212,16,42,.45), rgba(212,16,42,0) 66%);"></div>
    <div style="position:absolute; width:452px; height:452px; border-radius:50%; border:1px dashed rgba(232,185,60,.3);"></div>
    <div style="position:absolute; width:524px; height:524px; border-radius:50%; border:1px solid rgba(212,16,42,.28);"></div>
EOF
emblem 330 "h" texto
printf '<div class="card" style="position:absolute; right:0; bottom:6px; width:190px; padding:15px; border-radius:4px;">'
photo "equipamento-01.jpg" "height:112px; border-radius:2px;"
cat <<'EOF'
      <div style="margin-top:12px; font-size:13.5px; font-weight:600;">Equipamento oficial</div>
      <div class="dim" style="font-size:12.5px;">Época 2026/27</div>
    </div>
  </div>
</div>

<div style="display:flex; gap:40px; align-items:center; padding:18px 96px; border-block:1px solid rgba(246,241,236,.07); background:linear-gradient(90deg, rgba(212,16,42,.14), rgba(14,107,55,.10), rgba(232,185,60,.12)); white-space:nowrap;">
EOF
for w in Técnica Arte Equipa Competição Montijo Espetáculo Família; do
  printf '<span class="ey" style="font-size:13px; color:rgba(246,241,236,.62);">%s</span>' "$w"
  [ "$w" != "Família" ] && ico_diamond
done
cat <<'EOF'
</div>

<div style="padding:104px 96px 0;">
  <div style="display:flex; justify-content:space-between; align-items:flex-end; gap:40px; margin-bottom:52px;">
    <div>
      <div class="ey" style="margin-bottom:18px;">O que fazemos</div>
      <h2 style="font-size:56px;">Três caminhos,<br>a mesma <span class="it">pista</span>.</h2>
    </div>
    <p class="mut" style="font-size:16px; max-width:38ch;">Cada atleta entra no seu ritmo. Uns ficam pelo prazer de patinar, outros levam a época inteira a preparar uma prova. No CPBVM há lugar para os dois.</p>
  </div>
  <div style="display:grid; grid-template-columns:repeat(3,minmax(0,1fr)); gap:24px;">
    <div class="card" style="padding:34px; border-radius:4px;">
      <svg width="34" height="34" viewBox="0 0 24 24" fill="none" stroke="#E8B93C" stroke-width="1.4" aria-hidden="true"><path d="M7 4h4l1 7h4"/><path d="M6 15h11"/><circle cx="7.5" cy="18.5" r="1.8"/><circle cx="12" cy="18.5" r="1.8"/><circle cx="16.5" cy="18.5" r="1.8"/></svg>
      <h3 style="font-size:27px; margin:22px 0 10px;">Escola de Patinagem</h3>
      <p class="mut" style="font-size:15.5px;">Primeiros passos, equilíbrio e confiança sobre rodas. Turmas a partir dos 4 anos, sem experiência nenhuma.</p>
      <div style="margin-top:22px;"><span class="chip">Iniciação</span></div>
    </div>
    <div class="card" style="padding:34px; border-radius:4px; border-color:rgba(232,185,60,.22);">
      <svg width="34" height="34" viewBox="0 0 24 24" fill="none" stroke="#E8B93C" stroke-width="1.4" aria-hidden="true"><path d="M12 3l2.6 5.6 6.1.8-4.5 4.2 1.2 6-5.4-3-5.4 3 1.2-6L3.3 9.4l6.1-.8z"/></svg>
      <h3 style="font-size:27px; margin:22px 0 10px;">Artística — Competição</h3>
      <p class="mut" style="font-size:15.5px;">Treino técnico e coreográfico para provas regionais e nacionais: exercícios de escola, programa curto e livre.</p>
      <div style="margin-top:22px;"><span class="chip g">Federado</span></div>
    </div>
    <div class="card" style="padding:34px; border-radius:4px;">
      <svg width="34" height="34" viewBox="0 0 24 24" fill="none" stroke="#E8B93C" stroke-width="1.4" aria-hidden="true"><circle cx="9" cy="8" r="3"/><circle cx="17" cy="9.5" r="2.3"/><path d="M3.5 19c0-3 2.5-5 5.5-5s5.5 2 5.5 5"/><path d="M15.5 19c0-2.2 1-3.6 2.5-3.6s2.5 1.4 2.5 3.6"/></svg>
      <h3 style="font-size:27px; margin:22px 0 10px;">Grupos e Exibições</h3>
      <p class="mut" style="font-size:15.5px;">Coreografias de conjunto, galas e o espetáculo de fim de época — a parte em que o clube brilha todo junto.</p>
      <div style="margin-top:22px;"><span class="chip r">Equipa</span></div>
    </div>
  </div>
</div>

<div style="display:grid; grid-template-columns:1fr 1fr; gap:72px; align-items:center; padding:104px 96px;">
  <div style="display:grid; grid-template-columns:1fr 1fr; gap:16px;">
EOF
photo "equipa-01.jpg" "height:320px; border-radius:4px;" "A equipa, 2026"
printf '<div style="display:grid; gap:16px;">'
photo "treino-01.jpg" "height:152px; border-radius:4px;" "Treino de terça"
photo "gala-01.jpg" "height:152px; border-radius:4px;" "Gala de Natal"
printf '</div>'
cat <<'EOF'
  </div>
  <div>
    <div class="ey" style="margin-bottom:18px;">O clube</div>
    <h2 style="font-size:54px;">Um clube pequeno<br>com <span class="it">ambição grande</span>.</h2>
    <p class="mut" style="font-size:16.5px; margin-top:24px;">Nascemos no Montijo em 2012 e crescemos como se faz nos clubes de bairro: com pais nas bancadas, treinadoras que sabem o nome de cada atleta e um pavilhão cheio às sextas-feiras.</p>
    <p class="mut" style="font-size:16.5px; margin-top:16px;">O preto e o vermelho do equipamento vêm do emblema; a linha dourada é a que seguimos em cada programa — rigor técnico, sem perder a alegria de patinar.</p>
    <div style="display:flex; gap:14px; margin-top:34px;">
      <span class="btn gh">A nossa história</span>
      <span class="btn gh">Equipa técnica</span>
    </div>
  </div>
</div>

<div style="padding:0 96px 104px;">
  <hr class="hair" style="margin-bottom:64px;">
  <div style="display:flex; justify-content:space-between; align-items:flex-end; margin-bottom:40px;">
    <div>
      <div class="ey" style="margin-bottom:18px;">Agenda</div>
      <h2 style="font-size:52px;">Próximos <span class="it">eventos</span></h2>
    </div>
    <span style="display:flex; align-items:center; gap:9px; font-size:14px; color:#E8B93C; border-bottom:1px solid rgba(232,185,60,.4); padding-bottom:4px;">Ver calendário completo
EOF
ico_arrow
cat <<'EOF'
    </span>
  </div>
  <div style="display:flex; flex-direction:column; gap:12px;">
    <div class="card" style="display:grid; grid-template-columns:88px 1fr auto; gap:28px; align-items:center; padding:22px 28px; border-radius:4px;">
      <div class="date"><b>17</b><small>Out</small></div>
      <div>
        <h3 style="font-size:23px;">Torneio de Abertura de Época</h3>
        <p class="dim" style="font-size:14px; margin-top:4px;">Pavilhão do Bonfim, Setúbal · 9h30 · Iniciados a Juniores</p>
      </div>
      <span class="chip r">Competição</span>
    </div>
    <div class="card" style="display:grid; grid-template-columns:88px 1fr auto; gap:28px; align-items:center; padding:22px 28px; border-radius:4px;">
      <div class="date"><b>21</b><small>Nov</small></div>
      <div>
        <h3 style="font-size:23px;">Estágio técnico de inverno</h3>
        <p class="dim" style="font-size:14px; margin-top:4px;">Pavilhão Municipal do Montijo · inscrição até 7 de novembro</p>
      </div>
      <span class="chip g">Formação</span>
    </div>
    <div class="card" style="display:grid; grid-template-columns:88px 1fr auto; gap:28px; align-items:center; padding:22px 28px; border-radius:4px;">
      <div class="date"><b>12</b><small>Dez</small></div>
      <div>
        <h3 style="font-size:23px;">Gala de Natal do CPBVM</h3>
        <p class="dim" style="font-size:14px; margin-top:4px;">Pavilhão Municipal do Montijo · 21h00 · bilhete 5 €</p>
      </div>
      <span class="chip">Exibição</span>
    </div>
  </div>
</div>

<div style="padding:0 96px 104px;">
  <div class="ey" style="margin-bottom:18px;">Galeria</div>
  <h2 style="font-size:48px; margin-bottom:36px;">A época, por <span class="it">dentro</span></h2>
  <div style="display:grid; grid-template-columns:repeat(4,minmax(0,1fr)); gap:16px;">
EOF
photo "gala-03.jpg" "height:230px; border-radius:4px;" "Gala 2026"
photo "patins-01.jpg" "height:230px; border-radius:4px;" "Material"
photo "escola-01.jpg" "height:230px; border-radius:4px;" "Escola"
photo "atleta-05.jpg" "height:230px; border-radius:4px;" "Programa livre"
cat <<'EOF'
  </div>
</div>

<div style="padding:0 96px 104px;">
  <div style="position:relative; overflow:hidden; border:1px solid rgba(232,185,60,.18); border-radius:6px; padding:78px 64px; text-align:center;
    background:radial-gradient(90% 130% at 18% 0%, rgba(212,16,42,.42), transparent 60%), radial-gradient(70% 120% at 88% 100%, rgba(232,185,60,.16), transparent 62%), linear-gradient(160deg,#150F13,#0C080B);">
    <div class="ey" style="margin-bottom:20px;">Época 2026/27</div>
    <h2 style="font-size:58px;">As inscrições estão <span class="it">abertas</span>.</h2>
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
echo "Main ok"

# =========================================================
#  SOBRE
# =========================================================
{
head_html
nav_html sobre
pagehead "Sobre" "Quem somos" "Um clube feito de <span class=\"it\">horas de pista</span>." "Formação, competição e comunidade. O Clube de Patinagem BVM é a casa da patinagem artística no Montijo — e um sítio onde ninguém patina sozinho."
cat <<'EOF'
<div style="display:grid; grid-template-columns:1fr 1fr; gap:72px; padding:96px 96px 0; align-items:start;">
  <div>
    <div class="ey" style="margin-bottom:18px;">A nossa missão</div>
    <h2 style="font-size:46px;">Ensinar a cair.<br>E a <span class="it">levantar com estilo</span>.</h2>
  </div>
  <div>
    <p class="mut" style="font-size:17px;">Acreditamos que a patinagem artística ensina muito mais do que saltos e piruetas: ensina disciplina, paciência e a lidar com o palco. Por isso trabalhamos os dois lados — o técnico e o artístico — desde a primeira aula.</p>
    <p class="mut" style="font-size:17px; margin-top:16px;">Cada atleta tem um plano adequado à idade e ao escalão, acompanhamento próximo da equipa técnica e uma época com objetivos claros, do treino de terça-feira à gala de fim de ano.</p>
  </div>
</div>

<div style="padding:72px 96px 0;">
  <div style="display:grid; grid-template-columns:repeat(3,minmax(0,1fr)); gap:24px;">
    <div class="card" style="padding:34px; border-radius:4px;">
      <div style="font-family:Instrument Serif,Georgia,serif; font-size:44px; color:rgba(232,185,60,.55);">01</div>
      <h3 style="font-size:25px; margin:14px 0 10px;">Rigor sem medo</h3>
      <p class="mut" style="font-size:15.5px;">Exigimos técnica correta desde o início — porque é isso que protege as articulações e abre portas mais tarde.</p>
    </div>
    <div class="card" style="padding:34px; border-radius:4px;">
      <div style="font-family:Instrument Serif,Georgia,serif; font-size:44px; color:rgba(232,185,60,.55);">02</div>
      <h3 style="font-size:25px; margin:14px 0 10px;">Equipa acima de tudo</h3>
      <p class="mut" style="font-size:15.5px;">Compete-se sozinho na pista, mas treina-se em grupo. Quem está há mais tempo ajuda quem chegou agora — é assim que funciona cá.</p>
    </div>
    <div class="card" style="padding:34px; border-radius:4px;">
      <div style="font-family:Instrument Serif,Georgia,serif; font-size:44px; color:rgba(232,185,60,.55);">03</div>
      <h3 style="font-size:25px; margin:14px 0 10px;">Portas abertas</h3>
      <p class="mut" style="font-size:15.5px;">Do lazer à alta competição. Ninguém precisa de ter jeito para começar: precisa de querer voltar na semana seguinte.</p>
    </div>
  </div>
</div>

<div style="display:grid; grid-template-columns:.9fr 1.1fr; gap:72px; padding:104px 96px; align-items:start;">
  <div>
    <div class="ey" style="margin-bottom:18px;">Percurso</div>
    <h2 style="font-size:46px;">De uma turma<br>a uma <span class="it">equipa</span>.</h2>
EOF
printf '<div style="margin-top:36px;">'
photo "historia-01.jpg" "height:250px; border-radius:4px;" "Primeiros anos do clube"
printf '</div>'
cat <<'EOF'
  </div>
  <div style="padding-left:28px; border-left:1px solid rgba(232,185,60,.25);">
    <div style="margin-bottom:34px;">
      <div style="font-family:Instrument Serif,Georgia,serif; font-size:30px; color:#E8B93C;">2012</div>
      <h3 style="font-size:22px; margin:2px 0 6px;">Fundação do clube</h3>
      <p class="mut" style="font-size:15.5px;">Um grupo de pais e duas treinadoras abrem as primeiras turmas: 18 atletas, dois treinos por semana.</p>
    </div>
    <div style="margin-bottom:34px;">
      <div style="font-family:Instrument Serif,Georgia,serif; font-size:30px; color:#E8B93C;">2015</div>
      <h3 style="font-size:22px; margin:2px 0 6px;">Primeira equipa de competição</h3>
      <p class="mut" style="font-size:15.5px;">Cinco atletas federadas e a estreia em prova oficial, no Campeonato Regional de Setúbal.</p>
    </div>
    <div style="margin-bottom:34px;">
      <div style="font-family:Instrument Serif,Georgia,serif; font-size:30px; color:#E8B93C;">2019</div>
      <h3 style="font-size:22px; margin:2px 0 6px;">Primeiro pódio nacional</h3>
      <p class="mut" style="font-size:15.5px;">Terceiro lugar em conjuntos no Encontro Nacional — o primeiro troféu a entrar na vitrina.</p>
    </div>
    <div style="margin-bottom:34px;">
      <div style="font-family:Instrument Serif,Georgia,serif; font-size:30px; color:#E8B93C;">2023</div>
      <h3 style="font-size:22px; margin:2px 0 6px;">Casa nova</h3>
      <p class="mut" style="font-size:15.5px;">O clube passa a treinar no Pavilhão Municipal do Montijo e duplica o número de turmas.</p>
    </div>
    <div>
      <div style="font-family:Instrument Serif,Georgia,serif; font-size:30px; color:#E8B93C;">Hoje</div>
      <h3 style="font-size:22px; margin:2px 0 6px;">94 atletas em 7 escalões</h3>
      <p class="mut" style="font-size:15.5px;">Competição federada, escola de patinagem e uma gala anual que enche a sala.</p>
    </div>
  </div>
</div>

<div style="padding:0 96px 104px;">
  <div class="card" style="display:grid; grid-template-columns:1.15fr .85fr; gap:56px; align-items:center; padding:56px; border-radius:6px;">
    <div>
      <div class="ey" style="margin-bottom:18px;">Identidade</div>
      <h2 style="font-size:44px;">Preto, vermelho<br>e uma linha <span class="it">dourada</span>.</h2>
      <p class="mut" style="font-size:16.5px; margin-top:22px;">O equipamento de competição segue o emblema: o preto do fundo, o vermelho em degradé dos anéis e a linha dourada da patinadora. Cada atleta recebe-o ao entrar para a equipa de competição.</p>
      <div style="display:flex; gap:12px; margin-top:28px;">
        <span style="width:44px; height:44px; border-radius:50%; background:#0A0709; border:1px solid rgba(246,241,236,.2);"></span>
        <span style="width:44px; height:44px; border-radius:50%; background:linear-gradient(140deg,#FF3A4E,#8E0F21);"></span>
        <span style="width:44px; height:44px; border-radius:50%; background:linear-gradient(140deg,#FFE9A8,#C08C24);"></span>
        <span style="width:44px; height:44px; border-radius:50%; background:#0E6B37;"></span>
      </div>
    </div>
    <div style="display:grid; grid-template-columns:1fr 1fr; gap:14px;">
EOF
photo "equipamento-01.jpg" "height:230px; border-radius:4px;"
photo "equipamento-02.jpg" "height:230px; border-radius:4px;"
cat <<'EOF'
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
coach() { # $1 foto, $2 nome, $3 função, $4 bio, $5 chip
  printf '<div class="card" style="border-radius:4px; overflow:hidden;">'
  photo "$1" "height:300px;"
  cat <<EOF
  <div style="padding:26px 26px 30px;">
    <h3 style="font-size:25px;">$2</h3>
    <div class="ey" style="display:block; margin:8px 0 14px; font-size:11px;">$3</div>
    <p class="mut" style="font-size:15px;">$4</p>
    <div style="margin-top:18px;"><span class="chip">$5</span></div>
  </div>
</div>
EOF
}
{
head_html
nav_html equipa
pagehead "Equipa Técnica" "Quem treina" "As pessoas que estão na <span class=\"it\">pista</span> contigo." "Treinadores certificados, coreografia, preparação física e a direção do clube. É com esta equipa que cada atleta trabalha, semana a semana."
cat <<'EOF'
<div style="padding:96px 96px 0;">
  <div style="display:grid; grid-template-columns:repeat(3,minmax(0,1fr)); gap:24px;">
EOF
coach "treinador-01.jpg" "Sofia Marques" "Treinadora principal · Artística" "Patinou catorze anos em competição e treina no CPBVM desde 2014. Acompanha os escalões de Cadetes a Seniores e desenha os programas de prova." "Grau II · FPP"
coach "treinador-02.jpg" "Ricardo Nunes" "Treinador · Escola de patinagem" "Responsável pelas turmas de iniciação e pelo primeiro contacto das crianças com os patins. No clube desde 2016." "Grau I · FPP"
coach "treinador-03.jpg" "Inês Carvalho" "Coreografia e expressão" "Formada em dança contemporânea, trabalha os programas livres e a componente artística de todos os escalões." "Coreografia"
cat <<'EOF'
  </div>
  <div style="display:grid; grid-template-columns:repeat(3,minmax(0,1fr)); gap:24px; margin-top:24px;">
EOF
coach "treinador-04.jpg" "Tiago Lopes" "Preparação física" "Licenciado em Ciências do Desporto. Trata da condição física, da prevenção de lesões e do trabalho fora da pista." "Condição física"
coach "treinador-05.jpg" "Helena Duarte" "Presidente da direção" "Fundadora do clube em 2012. Faz a ligação à federação, à autarquia e às famílias — e ainda aparece nos treinos de sábado." "Direção"
coach "treinador-06.jpg" "Marta Ribeiro" "Secretaria e inscrições" "O primeiro contacto das famílias: inscrições, quotas, licenças federativas e toda a documentação da época." "Apoio às famílias"
cat <<'EOF'
  </div>
</div>

<div style="padding:104px 96px;">
  <div class="card" style="padding:64px; border-radius:6px; background:radial-gradient(80% 130% at 12% 0%, rgba(212,16,42,.26), transparent 62%), linear-gradient(160deg,#150F13,#0C080B);">
    <div class="ey" style="margin-bottom:20px;">Como treinamos</div>
    <h2 style="font-size:46px; max-width:22ch;">Um plano por atleta, não um plano por turma.</h2>
    <div style="display:grid; grid-template-columns:repeat(3,minmax(0,1fr)); gap:40px; margin-top:52px;">
      <div>
        <h3 style="font-size:21px; color:#E8B93C;">Avaliação no início da época</h3>
        <p class="mut" style="font-size:15.5px; margin-top:8px;">Cada atleta é avaliado tecnicamente e definem-se com a família os objetivos até junho.</p>
      </div>
      <div>
        <h3 style="font-size:21px; color:#E8B93C;">Acompanhamento contínuo</h3>
        <p class="mut" style="font-size:15.5px; margin-top:8px;">Feedback regular aos encarregados de educação e ajustes ao plano sempre que é preciso.</p>
      </div>
      <div>
        <h3 style="font-size:21px; color:#E8B93C;">Competir com sentido</h3>
        <p class="mut" style="font-size:15.5px; margin-top:8px;">Ninguém vai a uma prova sem estar preparado. A prova é a consequência do treino, não o contrário.</p>
      </div>
    </div>
  </div>
</div>
EOF
footer_html
tail_html
} > EquipaTecnica.dc.html
echo "Sobre + Equipa ok"

# =========================================================
#  ATLETAS
# =========================================================
athlete() { # $1 foto, $2 nome, $3 escalão, $4 nota
  printf '<div class="card" style="border-radius:4px; overflow:hidden;">'
  photo "$1" "height:250px;"
  cat <<EOF
  <div style="padding:20px 22px 24px;">
    <h3 style="font-size:21px;">$2</h3>
    <div class="dim" style="font-size:13.5px; margin-top:3px;">$4</div>
    <div style="margin-top:14px;"><span class="chip" style="font-size:11px;">$3</span></div>
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
EOF
for e in Escola Iniciados Infantis Cadetes Juvenis Juniores Seniores; do
  printf '<span style="padding:11px 22px; border-radius:999px; font-size:14px; font-weight:500; border:1px solid rgba(246,241,236,.14); color:#A79DA4;">%s</span>' "$e"
done
cat <<'EOF'
  </div>
  <div style="display:grid; grid-template-columns:repeat(4,minmax(0,1fr)); gap:20px;">
EOF
athlete "atleta-01.jpg" "Beatriz Antunes" "Cadetes" "No clube desde 2017"
athlete "atleta-02.jpg" "Matilde Rocha" "Infantis" "No clube desde 2019"
athlete "atleta-03.jpg" "Leonor Pires" "Iniciados" "No clube desde 2021"
athlete "atleta-04.jpg" "Carolina Mendes" "Juvenis" "No clube desde 2015"
cat <<'EOF'
  </div>
  <div style="display:grid; grid-template-columns:repeat(4,minmax(0,1fr)); gap:20px; margin-top:20px;">
EOF
athlete "atleta-05.jpg" "Mariana Gomes" "Juniores" "No clube desde 2013"
athlete "atleta-06.jpg" "Rodrigo Silva" "Cadetes" "No clube desde 2018"
athlete "atleta-07.jpg" "Francisca Tavares" "Escola" "No clube desde 2025"
athlete "atleta-08.jpg" "Alice Fonseca" "Escola" "No clube desde 2026"
cat <<'EOF'
  </div>
</div>

<div style="padding:104px 96px;">
  <hr class="hair" style="margin-bottom:60px;">
  <div class="ey" style="margin-bottom:18px;">Época 2025/26</div>
  <h2 style="font-size:48px; margin-bottom:40px;">Resultados a <span class="it">guardar</span></h2>
  <div style="display:grid; grid-template-columns:repeat(3,minmax(0,1fr)); gap:24px;">
    <div class="card" style="padding:34px; border-radius:4px; border-color:rgba(232,185,60,.28);">
      <div style="display:flex; align-items:center; gap:10px; color:#E8B93C;">
        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#E8B93C" stroke-width="1.5" aria-hidden="true"><circle cx="12" cy="9" r="5"/><path d="M8.5 13.5L7 21l5-2.5L17 21l-1.5-7.5"/></svg>
        <span style="font-size:12px; letter-spacing:.2em; text-transform:uppercase; font-weight:600;">2.º lugar</span>
      </div>
      <h3 style="font-size:24px; margin:16px 0 6px;">Beatriz Antunes</h3>
      <p class="mut" style="font-size:15px;">Taça Regional de Setúbal · Cadetes · Palmela, maio de 2026</p>
    </div>
    <div class="card" style="padding:34px; border-radius:4px;">
      <div style="display:flex; align-items:center; gap:10px; color:#E8B93C;">
        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#E8B93C" stroke-width="1.5" aria-hidden="true"><circle cx="12" cy="9" r="5"/><path d="M8.5 13.5L7 21l5-2.5L17 21l-1.5-7.5"/></svg>
        <span style="font-size:12px; letter-spacing:.2em; text-transform:uppercase; font-weight:600;">5.º lugar</span>
      </div>
      <h3 style="font-size:24px; margin:16px 0 6px;">Carolina Mendes</h3>
      <p class="mut" style="font-size:15px;">Campeonato Nacional · Juvenis · Anadia, abril de 2026</p>
    </div>
    <div class="card" style="padding:34px; border-radius:4px;">
      <div style="display:flex; align-items:center; gap:10px; color:#E8B93C;">
        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#E8B93C" stroke-width="1.5" aria-hidden="true"><path d="M4 5h16v6a8 8 0 01-16 0z"/><path d="M4 7H2.5v2a3 3 0 003 3M20 7h1.5v2a3 3 0 01-3 3"/><path d="M9 21h6"/></svg>
        <span style="font-size:12px; letter-spacing:.2em; text-transform:uppercase; font-weight:600;">3.º lugar</span>
      </div>
      <h3 style="font-size:24px; margin:16px 0 6px;">Grupo de Quartetos</h3>
      <p class="mut" style="font-size:15px;">Encontro Nacional de Conjuntos · Maia, março de 2026</p>
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
evrow() { # $1 dia, $2 mês, $3 título, $4 detalhe, $5 classe do chip, $6 chip, $7 opacidade
cat <<EOF
<div class="card" style="display:grid; grid-template-columns:88px 1fr auto; gap:28px; align-items:center; padding:22px 28px; border-radius:4px; opacity:$7;">
  <div class="date"><b>$1</b><small>$2</small></div>
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
pagehead "Eventos" "Calendário" "A época, de <span class=\"it\">setembro a junho</span>." "Provas federadas, galas, estágios e os momentos do clube. O calendário é atualizado sempre que a federação publica novas datas."
cat <<'EOF'
<div style="padding:80px 96px 0;">
  <div class="card" style="display:grid; grid-template-columns:1fr 1fr; border-radius:6px; overflow:hidden; border-color:rgba(232,185,60,.22);">
    <div style="padding:56px;">
      <span class="chip r">Próximo evento</span>
      <h2 style="font-size:46px; margin:24px 0 16px;">Gala de Natal<br>do <span class="it">CPBVM</span></h2>
      <p class="mut" style="font-size:16.5px;">Todas as turmas em palco, das mais pequenas à equipa de competição. É o momento em que o clube se mostra inteiro — e a sala enche sempre.</p>
      <div style="display:grid; grid-template-columns:1fr 1fr; gap:22px; margin-top:34px; padding-top:26px; border-top:1px solid rgba(246,241,236,.08);">
        <div><div class="ey" style="font-size:11px;">Data</div><div style="font-size:16px; margin-top:5px;">12 de dezembro, 21h00</div></div>
        <div><div class="ey" style="font-size:11px;">Local</div><div style="font-size:16px; margin-top:5px;">Pavilhão Municipal do Montijo</div></div>
        <div><div class="ey" style="font-size:11px;">Bilhetes</div><div style="font-size:16px; margin-top:5px;">5 € · secretaria e à porta</div></div>
        <div><div class="ey" style="font-size:11px;">Duração</div><div style="font-size:16px; margin-top:5px;">Cerca de 2 horas</div></div>
      </div>
      <div style="margin-top:34px;"><span class="btn">Reservar bilhete</span></div>
    </div>
EOF
photo "gala-02.jpg" "min-height:440px;" "Gala de Natal de 2025"
cat <<'EOF'
  </div>
</div>

<div style="padding:88px 96px 0;">
  <h2 style="font-size:42px; margin-bottom:32px;">Próximos</h2>
  <div style="display:flex; flex-direction:column; gap:12px;">
EOF
evrow "17" "Out" "Torneio de Abertura de Época" "Pavilhão do Bonfim, Setúbal · 9h30 · Iniciados a Juniores" "r" "Competição" "1"
evrow "21" "Nov" "Estágio técnico de inverno" "Pavilhão Municipal do Montijo · inscrição até 7 de novembro" "g" "Formação" "1"
evrow "12" "Dez" "Gala de Natal do CPBVM" "Pavilhão Municipal do Montijo · 21h00 · bilhete 5 €" "" "Exibição" "1"
evrow "23" "Jan" "Taça Regional — 1.ª jornada" "Pavilhão da Quinta dos Bacelos, Palmela · 10h00" "r" "Competição" "1"
evrow "13" "Fev" "Convívio de famílias do clube" "Sede do clube · aberto a pais e encarregados de educação" "" "Clube" "1"
cat <<'EOF'
  </div>
</div>

<div style="padding:80px 96px 104px;">
  <hr class="hair" style="margin-bottom:56px;">
  <h2 style="font-size:38px; margin-bottom:28px; color:#A79DA4;">Já aconteceram</h2>
  <div style="display:flex; flex-direction:column; gap:12px;">
EOF
evrow "20" "Jun" "Gala de fim de época 2025/26" "Pavilhão Municipal do Montijo · 380 espectadores" "" "Exibição" ".78"
evrow "9" "Mai" "Campeonato Regional de Setúbal" "Palmela · três pódios para o clube" "r" "Competição" ".78"
evrow "13" "Set" "Aulas abertas de experimentação" "Pavilhão Municipal do Montijo · 27 novos inscritos" "g" "Escola" ".78"
cat <<'EOF'
  </div>
</div>
EOF
footer_html
tail_html
} > Eventos.dc.html
echo "Atletas + Eventos ok"

# =========================================================
#  INSCRIÇÕES
# =========================================================
field() { # $1 etiqueta, $2 valor/placeholder, $3 "select" para mostrar a seta
  printf '<div><div style="font-size:11.5px; font-weight:600; letter-spacing:.16em; text-transform:uppercase; color:#A79DA4; margin-bottom:9px;">%s</div>' "$1"
  printf '<div style="display:flex; align-items:center; justify-content:space-between; gap:12px; padding:15px 18px; border:1px solid rgba(246,241,236,.13); border-radius:3px; background:rgba(246,241,236,.03); font-size:15px; color:#8C8490;"><span>%s</span>' "$2"
  [ "${3:-}" = "select" ] && printf '<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#E8B93C" stroke-width="1.8" aria-hidden="true"><path d="M6 9l6 6 6-6"/></svg>'
  printf '</div></div>'
}
faq() { # $1 pergunta, $2 resposta (vazia = fechada)
  printf '<div style="background:#0A0709; padding:24px 4px;"><div style="display:flex; justify-content:space-between; align-items:center; gap:20px;"><h3 style="font-size:21px;">%s</h3>' "$1"
  if [ -n "${2:-}" ]; then ico_minus; else ico_plus; fi
  printf '</div>'
  [ -n "${2:-}" ] && printf '<p class="mut" style="font-size:15.5px; margin-top:12px; max-width:62ch;">%s</p>' "$2"
  printf '</div>'
}
{
head_html
nav_html inscricoes
pagehead "Inscrições" "Época 2026/27" "Começar é mais simples do que <span class=\"it\">parece</span>." "Aula experimental gratuita, sem compromisso. Traz roupa confortável e meias altas — os patins emprestamos nós."
cat <<'EOF'
<div style="padding:88px 96px 0;">
  <div style="display:grid; grid-template-columns:repeat(3,minmax(0,1fr)); gap:24px;">
    <div class="card" style="padding:36px; border-radius:4px;">
      <div style="width:46px; height:46px; border-radius:50%; border:1px solid rgba(232,185,60,.4); display:flex; align-items:center; justify-content:center; font-family:Instrument Serif,Georgia,serif; font-size:22px; color:#E8B93C;">1</div>
      <h3 style="font-size:24px; margin:20px 0 10px;">Marca a aula experimental</h3>
      <p class="mut" style="font-size:15.5px;">Preenche o formulário aqui ao lado. Respondemos em 48 horas com dia e hora.</p>
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

<div style="display:grid; grid-template-columns:.95fr 1.05fr; gap:56px; padding:96px 96px 0; align-items:start;">
  <div>
    <div class="ey" style="margin-bottom:18px;">Mensalidades</div>
    <h2 style="font-size:42px; margin-bottom:30px;">Escolhe o <span class="it">ritmo</span></h2>
    <div style="display:flex; flex-direction:column; gap:14px;">
      <div class="card" style="display:flex; justify-content:space-between; align-items:center; gap:20px; padding:26px 30px; border-radius:4px;">
        <div>
          <h3 style="font-size:22px;">Escola — 1 vez por semana</h3>
          <p class="dim" style="font-size:14px; margin-top:3px;">Sábado, 10h00–11h30 · a partir dos 4 anos</p>
        </div>
        <div style="font-family:Instrument Serif,Georgia,serif; font-size:34px; color:#E8B93C;">28 €</div>
      </div>
      <div class="card" style="display:flex; justify-content:space-between; align-items:center; gap:20px; padding:26px 30px; border-radius:4px; border-color:rgba(232,185,60,.3);">
        <div>
          <h3 style="font-size:22px;">Escola — 2 vezes por semana</h3>
          <p class="dim" style="font-size:14px; margin-top:3px;">Terça e quinta, 18h30–20h00 · o mais escolhido</p>
        </div>
        <div style="font-family:Instrument Serif,Georgia,serif; font-size:34px; color:#E8B93C;">42 €</div>
      </div>
      <div class="card" style="display:flex; justify-content:space-between; align-items:center; gap:20px; padding:26px 30px; border-radius:4px;">
        <div>
          <h3 style="font-size:22px;">Competição</h3>
          <p class="dim" style="font-size:14px; margin-top:3px;">Quatro treinos semanais · inclui acompanhamento a provas</p>
        </div>
        <div style="font-family:Instrument Serif,Georgia,serif; font-size:34px; color:#E8B93C;">65 €</div>
      </div>
    </div>
    <div class="card" style="padding:26px 30px; border-radius:4px; margin-top:22px;">
      <div class="ey" style="margin-bottom:14px;">A ter em conta</div>
      <div style="display:flex; flex-direction:column; gap:9px; font-size:15px; color:#A79DA4;">
        <span>· Joia de inscrição anual: 35 € (inclui seguro desportivo)</span>
        <span>· Desconto de irmãos: 15 % na segunda mensalidade</span>
        <span>· Equipamento de competição: 120 €, uma vez por época</span>
        <span>· Licença federativa: 45 € para atletas de competição</span>
      </div>
    </div>
  </div>

  <div class="card" style="padding:48px; border-radius:6px; background:radial-gradient(90% 120% at 90% 0%, rgba(212,16,42,.24), transparent 62%), linear-gradient(160deg,#150F13,#0C080B);">
    <div class="ey" style="margin-bottom:16px;">Formulário</div>
    <h2 style="font-size:36px; margin-bottom:30px;">Pedido de aula experimental</h2>
    <div style="display:grid; grid-template-columns:1fr 1fr; gap:20px;">
EOF
field "Nome do atleta" "Matilde Rocha Silva"
field "Data de nascimento" "14 / 03 / 2018"
field "Encarregado de educação" "Ana Rocha Silva"
field "Telemóvel" "962 118 340"
cat <<'EOF'
    </div>
    <div style="margin-top:20px;">
EOF
field "E-mail" "ana.rocha@exemplo.pt"
cat <<'EOF'
    </div>
    <div style="display:grid; grid-template-columns:1fr 1fr; gap:20px; margin-top:20px;">
EOF
field "Já patina?" "Nunca experimentou" select
field "Preferência de horário" "Terça e quinta, fim do dia" select
cat <<'EOF'
    </div>
    <div style="margin-top:20px;">
      <div style="font-size:11.5px; font-weight:600; letter-spacing:.16em; text-transform:uppercase; color:#A79DA4; margin-bottom:9px;">Mensagem (opcional)</div>
      <div style="padding:15px 18px; height:96px; border:1px solid rgba(246,241,236,.13); border-radius:3px; background:rgba(246,241,236,.03); font-size:15px; color:#8C8490;">A Matilde tem uma amiga na turma de sábado e gostava de ficar no mesmo grupo.</div>
    </div>
    <div style="display:flex; gap:12px; align-items:flex-start; margin-top:24px;">
      <span style="width:20px; height:20px; border:1px solid rgba(232,185,60,.5); border-radius:3px; flex:none; margin-top:2px; display:flex; align-items:center; justify-content:center;"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="#E8B93C" stroke-width="2.6" aria-hidden="true"><path d="M5 12.5l5 5L19 7"/></svg></span>
      <span class="mut" style="font-size:14px;">Autorizo o tratamento dos dados para efeitos de contacto, nos termos da política de privacidade do clube.</span>
    </div>
    <div style="margin-top:30px;"><span class="btn" style="display:block; text-align:center;">Enviar pedido</span></div>
    <p class="dim" style="font-size:13px; text-align:center; margin-top:16px;">Respondemos em 48 horas. Preferes falar? 212 345 678</p>
  </div>
</div>

<div style="padding:96px 96px 104px;">
  <hr class="hair" style="margin-bottom:60px;">
  <div style="display:grid; grid-template-columns:.8fr 1.2fr; gap:56px;">
    <div>
      <div class="ey" style="margin-bottom:18px;">Dúvidas</div>
      <h2 style="font-size:42px;">Perguntas que<br>nos fazem <span class="it">sempre</span></h2>
    </div>
    <div style="display:flex; flex-direction:column; gap:1px; background:rgba(246,241,236,.08);">
EOF
faq "A partir de que idade se pode começar?" "A escola recebe crianças a partir dos 4 anos. Dos 4 aos 6 há turmas próprias, mais curtas e com duas treinadoras na pista."
faq "É preciso ter patins?"
faq "Quantos treinos tem cada escalão?"
faq "Que documentos são precisos para a inscrição?"
faq "Pode-se entrar a meio da época?"
cat <<'EOF'
    </div>
  </div>
</div>
EOF
footer_html
tail_html
} > Inscricoes.dc.html

# =========================================================
#  CONTACTOS
# =========================================================
{
head_html
nav_html contactos
pagehead "Contactos" "Falar connosco" "Estamos no <span class=\"it\">Pavilhão Municipal</span> do Montijo." "Aparece num treino, liga ou escreve. Respondemos a todas as mensagens em 48 horas — e às urgentes bem mais depressa."
cat <<'EOF'
<div style="display:grid; grid-template-columns:1fr 1fr; gap:56px; padding:88px 96px 0; align-items:start;">
  <div>
    <div style="display:grid; grid-template-columns:1fr 1fr; gap:20px;">
      <div class="card" style="padding:30px; border-radius:4px;">
        <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="#E8B93C" stroke-width="1.5" aria-hidden="true"><path d="M12 21s7-5.6 7-11a7 7 0 10-14 0c0 5.4 7 11 7 11z"/><circle cx="12" cy="10" r="2.6"/></svg>
        <div class="ey" style="margin:16px 0 8px;">Morada</div>
        <p style="font-size:15.5px;">Pavilhão Municipal do Montijo<br>Rua das Palmeiras 12<br>2870-355 Montijo</p>
      </div>
      <div class="card" style="padding:30px; border-radius:4px;">
        <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="#E8B93C" stroke-width="1.5" aria-hidden="true"><path d="M4 6.5h16v11H4z"/><path d="M4 7l8 6 8-6"/></svg>
        <div class="ey" style="margin:16px 0 8px;">Contactos</div>
        <p style="font-size:15.5px;">geral@cpbvm.pt<br>212 345 678<br>963 214 587</p>
      </div>
      <div class="card" style="padding:30px; border-radius:4px;">
        <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="#E8B93C" stroke-width="1.5" aria-hidden="true"><circle cx="12" cy="12" r="8.5"/><path d="M12 7.5V12l3 2"/></svg>
        <div class="ey" style="margin:16px 0 8px;">Treinos</div>
        <p style="font-size:15.5px;">Terça e quinta · 18h30–20h00<br>Sábado · 10h00–13h00</p>
      </div>
      <div class="card" style="padding:30px; border-radius:4px;">
        <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="#E8B93C" stroke-width="1.5" aria-hidden="true"><rect x="3" y="4.5" width="18" height="16" rx="2"/><path d="M3 9.5h18M8 3v3M16 3v3"/></svg>
        <div class="ey" style="margin:16px 0 8px;">Secretaria</div>
        <p style="font-size:15.5px;">Terça e quinta · 18h00–20h00<br>Sábado · 10h00–12h00</p>
      </div>
    </div>
EOF
printf '<div style="margin-top:20px;">'
photo "treino-01.jpg" "height:260px; border-radius:4px;" "Pavilhão Municipal do Montijo"
printf '</div>'
cat <<'EOF'
  </div>

  <div class="card" style="padding:48px; border-radius:6px; background:radial-gradient(90% 120% at 90% 0%, rgba(212,16,42,.24), transparent 62%), linear-gradient(160deg,#150F13,#0C080B);">
    <div class="ey" style="margin-bottom:16px;">Mensagem</div>
    <h2 style="font-size:36px; margin-bottom:30px;">Escreve-nos</h2>
    <div style="display:grid; grid-template-columns:1fr 1fr; gap:20px;">
EOF
field "Nome" "João Almeida"
field "E-mail" "joao.almeida@exemplo.pt"
cat <<'EOF'
    </div>
    <div style="margin-top:20px;">
EOF
field "Assunto" "Horários da escola de patinagem" select
cat <<'EOF'
    </div>
    <div style="margin-top:20px;">
      <div style="font-size:11.5px; font-weight:600; letter-spacing:.16em; text-transform:uppercase; color:#A79DA4; margin-bottom:9px;">Mensagem</div>
      <div style="padding:15px 18px; height:150px; border:1px solid rgba(246,241,236,.13); border-radius:3px; background:rgba(246,241,236,.03); font-size:15px; color:#8C8490;">Boa tarde. O meu filho tem 7 anos e queria perceber se ainda há vagas na turma de sábado.</div>
    </div>
    <div style="margin-top:28px;"><span class="btn" style="display:block; text-align:center;">Enviar mensagem</span></div>
  </div>
</div>

<div style="padding:88px 96px 104px;">
  <div class="card" style="display:grid; grid-template-columns:1fr 1fr; gap:56px; align-items:center; padding:56px; border-radius:6px;">
    <div>
      <div class="ey" style="margin-bottom:18px;">Como chegar</div>
      <h2 style="font-size:40px;">A dois minutos<br>do <span class="it">centro</span>.</h2>
      <p class="mut" style="font-size:16px; margin-top:20px;">O pavilhão fica junto ao parque municipal, com estacionamento à porta. Carreiras 431 e 437 param a 200 metros; de barco, são 15 minutos a pé do Terminal Fluvial do Montijo.</p>
    </div>
    <div style="position:relative; height:280px; border-radius:4px; overflow:hidden; border:1px solid rgba(246,241,236,.1); background:
      repeating-linear-gradient(0deg, rgba(246,241,236,.05) 0 1px, transparent 1px 46px),
      repeating-linear-gradient(90deg, rgba(246,241,236,.05) 0 1px, transparent 1px 46px),
      linear-gradient(150deg,#171016,#0B080B);">
      <div style="position:absolute; left:0; right:0; top:44%; height:10px; background:rgba(232,185,60,.14); transform:rotate(-8deg);"></div>
      <div style="position:absolute; top:0; bottom:0; left:36%; width:8px; background:rgba(246,241,236,.06);"></div>
      <div style="position:absolute; left:52%; top:40%; transform:translate(-50%,-50%); display:flex; flex-direction:column; align-items:center; gap:8px;">
        <svg width="34" height="34" viewBox="0 0 24 24" fill="none" stroke="#E8B93C" stroke-width="1.6" aria-hidden="true"><path d="M12 21s7-5.6 7-11a7 7 0 10-14 0c0 5.4 7 11 7 11z"/><circle cx="12" cy="10" r="2.6"/></svg>
        <span style="font-size:12.5px; letter-spacing:.14em; text-transform:uppercase; color:#F6F1EC;">Pavilhão Municipal</span>
      </div>
      <span class="dim" style="position:absolute; left:16px; bottom:13px; font-size:12px;">Mapa interativo no site final</span>
    </div>
  </div>
</div>
EOF
footer_html
tail_html
} > Contactos.dc.html
echo "Inscricoes + Contactos ok"

# =========================================================
#  MOBILE — HOMEPAGE (390px)
# =========================================================
{
head_html
cat <<'EOF'
<div style="width:390px;">
  <div style="display:flex; align-items:center; justify-content:space-between; padding:14px 20px; border-bottom:1px solid rgba(246,241,236,.07);">
    <div style="display:flex; align-items:center; gap:10px;">
EOF
emblem 42 "m"
cat <<'EOF'
      <span style="font-family:Instrument Serif,Georgia,serif; font-size:16px; line-height:1.15;">Clube de Patinagem BVM</span>
    </div>
    <span style="width:44px; height:44px; border:1px solid rgba(246,241,236,.14); border-radius:10px; display:flex; flex-direction:column; justify-content:center; align-items:center; gap:4px; flex:none;">
      <span style="width:18px; height:1.5px; background:#F6F1EC; display:block;"></span>
      <span style="width:18px; height:1.5px; background:#F6F1EC; display:block;"></span>
      <span style="width:18px; height:1.5px; background:#F6F1EC; display:block;"></span>
    </span>
  </div>

  <div style="padding:38px 20px 42px; text-align:center;">
    <div class="ey" style="font-size:11px;">Patinagem artística · Montijo</div>
    <h1 style="font-size:46px; margin-top:18px;">Onde a técnica encontra a <span class="it">arte</span>.</h1>
    <p class="mut" style="font-size:16px; margin-top:18px;">Escola de patinagem e equipa de competição no Montijo, dos primeiros passos ao pódio.</p>
    <div style="display:flex; flex-direction:column; gap:10px; margin-top:28px;">
      <span class="btn" style="display:block; text-align:center; padding:17px;">Inscrever atleta</span>
      <span class="btn gh" style="display:block; text-align:center; padding:17px;">Conhecer o clube</span>
    </div>
    <div style="position:relative; display:flex; justify-content:center; margin-top:40px;">
      <div style="position:absolute; width:240px; height:240px; border-radius:50%; background:radial-gradient(circle, rgba(212,16,42,.45), rgba(212,16,42,0) 66%); top:-4px;"></div>
EOF
emblem 228 "mb" texto
cat <<'EOF'
    </div>
    <div style="display:flex; justify-content:center; gap:34px; margin-top:34px; padding-top:22px; border-top:1px solid rgba(246,241,236,.08);">
      <div><div style="font-family:Instrument Serif,Georgia,serif; font-size:30px; color:#E8B93C; line-height:1;">94</div><div class="dim" style="font-size:11px; letter-spacing:.16em; text-transform:uppercase; margin-top:5px;">Atletas</div></div>
      <div><div style="font-family:Instrument Serif,Georgia,serif; font-size:30px; color:#E8B93C; line-height:1;">7</div><div class="dim" style="font-size:11px; letter-spacing:.16em; text-transform:uppercase; margin-top:5px;">Escalões</div></div>
      <div><div style="font-family:Instrument Serif,Georgia,serif; font-size:30px; color:#E8B93C; line-height:1;">2012</div><div class="dim" style="font-size:11px; letter-spacing:.16em; text-transform:uppercase; margin-top:5px;">Desde</div></div>
    </div>
  </div>

  <div style="display:flex; justify-content:center; align-items:center; gap:14px; padding:13px 20px; border-block:1px solid rgba(246,241,236,.07); background:linear-gradient(90deg, rgba(212,16,42,.14), rgba(232,185,60,.12));">
EOF
for w in Técnica Arte Equipa; do
  printf '<span class="ey" style="font-size:11px; color:rgba(246,241,236,.62);">%s</span>' "$w"
  [ "$w" != "Equipa" ] && ico_diamond
done
cat <<'EOF'
  </div>

  <div style="padding:42px 20px 0;">
    <div class="ey" style="font-size:11px;">O que fazemos</div>
    <h2 style="font-size:34px; margin-top:14px;">Três caminhos, a mesma <span class="it">pista</span>.</h2>
    <div style="display:flex; flex-direction:column; gap:14px; margin-top:26px;">
      <div class="card" style="padding:26px; border-radius:4px;">
        <h3 style="font-size:22px;">Escola de Patinagem</h3>
        <p class="mut" style="font-size:15px; margin-top:8px;">Primeiros passos e confiança sobre rodas, a partir dos 4 anos.</p>
      </div>
      <div class="card" style="padding:26px; border-radius:4px; border-color:rgba(232,185,60,.22);">
        <h3 style="font-size:22px;">Artística — Competição</h3>
        <p class="mut" style="font-size:15px; margin-top:8px;">Treino técnico e coreográfico para provas regionais e nacionais.</p>
      </div>
      <div class="card" style="padding:26px; border-radius:4px;">
        <h3 style="font-size:22px;">Grupos e Exibições</h3>
        <p class="mut" style="font-size:15px; margin-top:8px;">Coreografias de conjunto, galas e o espetáculo de fim de época.</p>
      </div>
    </div>
  </div>

  <div style="padding:42px 20px 0;">
    <div class="ey" style="font-size:11px;">Galeria</div>
    <div style="display:grid; grid-template-columns:1fr 1fr; gap:12px; margin-top:16px;">
EOF
photo "gala-01.jpg" "height:130px; border-radius:4px;"
photo "atleta-02.jpg" "height:130px; border-radius:4px;"
photo "escola-01.jpg" "height:130px; border-radius:4px;"
photo "patins-01.jpg" "height:130px; border-radius:4px;"
cat <<'EOF'
    </div>
  </div>

  <div style="padding:42px 20px 0;">
    <div class="ey" style="font-size:11px; margin-bottom:16px;">Próximo evento</div>
    <div class="card" style="display:grid; grid-template-columns:64px 1fr; gap:18px; align-items:center; padding:18px; border-radius:4px;">
      <div class="date" style="padding:10px 0;"><b style="font-size:24px;">12</b><small style="font-size:10px;">Dez</small></div>
      <div>
        <h3 style="font-size:19px;">Gala de Natal do CPBVM</h3>
        <p class="dim" style="font-size:13px; margin-top:2px;">Pavilhão Municipal · 21h00</p>
      </div>
    </div>
  </div>

  <div style="padding:42px 20px 48px;">
    <div style="border:1px solid rgba(232,185,60,.18); border-radius:6px; padding:36px 24px; text-align:center;
      background:radial-gradient(90% 130% at 20% 0%, rgba(212,16,42,.4), transparent 62%), linear-gradient(160deg,#150F13,#0C080B);">
      <h2 style="font-size:32px;">Inscrições <span class="it">abertas</span></h2>
      <p class="mut" style="font-size:15px; margin-top:12px;">Aula experimental gratuita. Os patins podemos emprestar.</p>
      <span class="btn" style="display:block; text-align:center; padding:16px; margin-top:22px;">Quero inscrever-me</span>
    </div>
  </div>

  <div style="border-top:1px solid rgba(246,241,236,.07); background:#080608; padding:36px 20px 28px;">
    <div style="display:flex; align-items:center; gap:12px;">
EOF
emblem 44 "mf"
cat <<'EOF'
      <span style="font-family:Instrument Serif,Georgia,serif; font-size:17px;">Clube de Patinagem BVM</span>
    </div>
    <div style="display:flex; flex-wrap:wrap; gap:10px 22px; margin-top:22px; font-size:14.5px; color:#A79DA4;">
      <span>Sobre</span><span>Equipa técnica</span><span>Atletas</span><span>Eventos</span><span>Inscrições</span><span>Contactos</span>
    </div>
    <p class="dim" style="font-size:13px; margin-top:22px;">Pavilhão Municipal do Montijo · geral@cpbvm.pt · 212 345 678</p>
    <p class="dim" style="font-size:12.5px; margin-top:14px;">© 2026 Clube de Patinagem BVM</p>
  </div>
</div>
EOF
tail_html
} > MobileHome.dc.html
echo "Mobile ok"
