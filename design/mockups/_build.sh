#!/usr/bin/env bash
# Gera os artboards .dc.html do site do CPBVM.
# Linguagem visual: cartaz de espetáculo (tipo gigante, tarjas) + parede de clube
# (fotos com fita-cola, letra manuscrita, notas afixadas).
# NOTA: nomes, datas, valores e resultados são de exemplo (fictícios).
set -euo pipefail
cd "$(dirname "$0")"

source /tmp/emblem.sh 2>/dev/null || true

# ---------- ícones ----------
ico_diamond() { printf '%s' '<svg width="8" height="8" viewBox="0 0 10 10" aria-hidden="true" style="display:block; flex:none"><path d="M5 0l5 5-5 5-5-5z" fill="currentColor"/></svg>'; }
ico_arrow()   { printf '%s' '<svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" aria-hidden="true"><path d="M4 12h15"/><path d="M13 6l6 6-6 6"/></svg>'; }
ico_squiggle(){ printf '%s' '<svg width="58" height="34" viewBox="0 0 58 34" fill="none" stroke="#E9B949" stroke-width="2.4" stroke-linecap="round" aria-hidden="true"><path d="M3 5c14 20 34 25 51 22"/><path d="M46 20l8 7-11 4"/></svg>'; }

# ---------- fotografias ----------
photo() { # $1 ficheiro, $2 css do contentor, $3 legenda opcional
  printf '<div style="position:relative; overflow:hidden; background:#150E0B; %s"><img src="%s" alt="" style="width:100%%; height:100%%; object-fit:cover; display:block">' "$2" "$1"
  [ -n "${3:-}" ] && printf '<span class="lbl" style="position:absolute; left:16px; bottom:14px; color:#fff; text-shadow:0 2px 12px rgba(0,0,0,.9);">%s</span>' "$3"
  printf '</div>'
}
polaroid() { # $1 ficheiro, $2 altura da foto, $3 legenda, $4 rotação, $5 css extra, $6 cor da fita
  printf '<div class="polaroid" style="transform:rotate(%sdeg); %s"><span class="tape" style="background:%s"></span><img src="%s" alt="" style="height:%s; object-fit:cover;"><span>%s</span></div>' \
    "$4" "${5:-}" "${6:-rgba(233,185,73,.45)}" "$1" "$2" "$3"
}

# ---------- cabeçalho do documento ----------
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
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Anton&amp;family=Bricolage+Grotesque:opsz,wght@12..96,400;12..96,500;12..96,700;12..96,800&amp;family=Caveat:wght@600;700&amp;display=swap">
  <style>
    body{ margin:0; background:#0D0806; color:#F6EDE1;
      font-family:'Bricolage Grotesque','Trebuchet MS',sans-serif; font-size:17px; line-height:1.62;
      -webkit-font-smoothing:antialiased; }
    a{ color:#E9B949; text-decoration:none; } a:hover{ color:#FFF6EC; }
    h1,h2,h3{ margin:0; font-family:Anton,'Arial Narrow',Impact,sans-serif; font-weight:400;
      text-transform:uppercase; line-height:.88; letter-spacing:-.012em; }
    p{ margin:0; }
    .out{ color:transparent; -webkit-text-stroke:2px #E9B949; }
    .out-r{ color:transparent; -webkit-text-stroke:2px #FF2E1F; }
    .lbl{ font-family:'Bricolage Grotesque',sans-serif; font-size:11.5px; font-weight:700; letter-spacing:.24em;
      text-transform:uppercase; }
    .hand{ font-family:Caveat,'Comic Sans MS',cursive; font-weight:700; color:#E9B949; }
    .mut{ color:#C6B6A8; }
    .dim{ color:#A2948A; }
    .btn{ box-sizing:border-box; display:inline-flex; align-items:center; gap:10px; padding:16px 30px; border-radius:38px 34px 40px 32px;
      font-weight:800; font-size:15px; background:#D2261F; color:#fff; }
    .btn.k{ background:#E9B949; color:#28190C; }
    .btn.o{ background:transparent; border:2px solid rgba(246,237,225,.28); color:#F6EDE1; }
    .polaroid{ position:relative; background:#F6EDE1; padding:12px 12px 38px; box-shadow:0 26px 60px rgba(0,0,0,.62); }
    .polaroid img{ width:100%; display:block; }
    .polaroid span{ display:block; margin-top:10px; font-family:Caveat,cursive; font-weight:700; font-size:20px;
      color:#2A1B12; text-align:center; }
    .tape{ position:absolute; top:-13px; left:50%; margin-left:-52px; width:104px; height:26px; transform:rotate(-5deg); }
    .note{ position:relative; background:#170F0B; border:1px solid rgba(246,237,225,.12); border-radius:14px 12px 16px 10px; padding:26px; }
    .pin{ position:absolute; top:-9px; left:50%; margin-left:-8px; width:16px; height:16px; border-radius:50%;
      background:#D2261F; box-shadow:0 3px 8px rgba(0,0,0,.6); }
    .chip{ box-sizing:border-box; display:inline-block; padding:7px 15px; border:2px solid rgba(233,185,73,.4); border-radius:999px;
      font-size:11.5px; font-weight:700; letter-spacing:.16em; text-transform:uppercase; color:#E9B949; }
    .chip.r{ border-color:rgba(255,46,31,.55); color:#FF8A76; }
    .chip.g{ border-color:rgba(18,105,59,.7); color:#5FC98C; }
    .grain{ position:absolute; inset:0; pointer-events:none; opacity:.42; mix-blend-mode:overlay;
      background-image:url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='140' height='140'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='.9' numOctaves='3'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23n)'/%3E%3C/svg%3E"); }
  </style>
</helmet>
<div style="position:relative; background:
   radial-gradient(85% 55% at 10% 0%, rgba(210,38,31,.30), transparent 58%),
   radial-gradient(55% 45% at 94% 26%, rgba(233,185,73,.10), transparent 62%), #0D0806; overflow:hidden;">
<div class="grain"></div>
EOF
}

# ---------- navegação ----------
nav_html() { # $1 chave ativa
  local active="$1"
  printf '%s' '<div style="position:relative; display:flex; align-items:center; justify-content:space-between; gap:30px; padding:20px 58px; border-bottom:2px solid #E9B949;">
<div style="display:flex; align-items:center; gap:13px;">'
  emblem 50 "n"
  printf '%s' '<div style="line-height:1.12;">
<div style="font-family:Anton,sans-serif; font-size:21px; letter-spacing:.01em; text-transform:uppercase;">Patinagem BVM</div>
<div class="lbl" style="color:#E9B949; font-size:11px;">Montijo · desde 2012</div>
</div>
</div>
<div style="display:flex; align-items:center; gap:26px;">'
  local pairs=("inicio:Início" "sobre:O clube" "equipa:Treinadores" "atletas:Atletas" "eventos:Agenda" "contactos:Contactos")
  local p k l col
  for p in "${pairs[@]}"; do
    k="${p%%:*}"; l="${p#*:}"
    if [ "$k" = "$active" ]; then col="#E9B949; border-bottom:2px solid #FF2E1F"; else col="#F6EDE1"; fi
    printf '<span class="lbl" style="color:%s; padding-bottom:3px;">%s</span>' "$col" "$l"
  done
  if [ "$active" = "inscricoes" ]; then
    printf '<span class="btn" style="padding:12px 22px; font-size:14px; background:#FF2E1F;">Inscrever</span>'
  else
    printf '<span class="btn k" style="padding:12px 22px; font-size:14px;">Inscrever</span>'
  fi
  printf '%s' '
</div>
</div>
'
}

# ---------- tarja tipo bilhete ----------
ticket() { # $1..$n = campos
  printf '<div style="position:relative; background:#E9B949; color:#170A02; padding:15px 58px; display:flex; align-items:center; justify-content:space-between; gap:24px; font-family:Anton,sans-serif; font-size:25px; letter-spacing:.01em; text-transform:uppercase; white-space:nowrap;">'
  for f in "$@"; do printf '<span>%s</span>' "$f"; done
  printf '</div>'
}

# ---------- rodapé ----------
footer_html() {
  printf '%s' '<div style="position:relative; border-top:2px solid #E9B949; background:#0A0605; padding:64px 58px 34px;">
<div style="display:grid; grid-template-columns:1.4fr 1fr 1fr 1.1fr; gap:48px;">
<div>
<div style="display:flex; align-items:center; gap:14px;">'
  emblem 62 "f"
  printf '%s' '<div style="font-family:Anton,sans-serif; font-size:34px; line-height:.9; text-transform:uppercase;">Patinagem<br>BVM</div>
</div>
<p class="mut" style="font-size:15.5px; max-width:33ch; margin-top:20px;">Clube de patinagem artística do Montijo. Escola, competição e a gala que enche o pavilhão todos os dezembros desde 2012.</p>
<div class="hand" style="font-size:26px; margin-top:16px;">aparece num sábado!</div>
</div>
<div>
<div class="lbl" style="color:#E9B949; margin-bottom:16px;">O clube</div>
<div style="display:flex; flex-direction:column; gap:10px; font-size:15.5px; color:#C6B6A8;">
<span>Quem somos</span><span>Treinadores</span><span>Atletas</span><span>Direção</span><span>Galeria</span>
</div>
</div>
<div>
<div class="lbl" style="color:#E9B949; margin-bottom:16px;">Patinar</div>
<div style="display:flex; flex-direction:column; gap:10px; font-size:15.5px; color:#C6B6A8;">
<span>Escola de patinagem</span><span>Competição</span><span>Agenda</span><span>Inscrições</span><span>Mensalidades</span>
</div>
</div>
<div>
<div class="lbl" style="color:#E9B949; margin-bottom:16px;">Encontrar-nos</div>
<div style="display:flex; flex-direction:column; gap:10px; font-size:15.5px; color:#C6B6A8;">
<span>Pavilhão Municipal do Montijo</span><span>Rua das Palmeiras 12, 2870-355</span><span>geral@cpbvm.pt</span><span>212 345 678</span>
</div>
<div style="display:flex; gap:9px; margin-top:18px;">
<span style="width:40px; height:40px; border-radius:50%; border:2px solid rgba(246,237,225,.18); display:flex; align-items:center; justify-content:center; color:#E9B949;"><svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" aria-hidden="true"><rect x="3" y="3" width="18" height="18" rx="5"/><circle cx="12" cy="12" r="4"/><circle cx="17.5" cy="6.5" r="1" fill="currentColor" stroke="none"/></svg></span>
<span style="width:40px; height:40px; border-radius:50%; border:2px solid rgba(246,237,225,.18); display:flex; align-items:center; justify-content:center; color:#E9B949;"><svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" aria-hidden="true"><path d="M14 8h2.5V4.5H14c-2.2 0-3.5 1.4-3.5 3.6V10H8v3.5h2.5V21H14v-7.5h2.6l.4-3.5H14V8.4c0-.3.2-.4.5-.4z"/></svg></span>
<span style="width:40px; height:40px; border-radius:50%; border:2px solid rgba(246,237,225,.18); display:flex; align-items:center; justify-content:center; color:#E9B949;"><svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" aria-hidden="true"><path d="M4 6.5h16v11H4z"/><path d="M4 7l8 6 8-6"/></svg></span>
</div>
</div>
</div>
<div style="display:flex; justify-content:space-between; align-items:center; margin-top:46px; padding-top:22px; border-top:1px solid rgba(246,237,225,.12); font-size:13.5px; color:#A2948A;">
<span>© 2026 Clube de Patinagem BVM · Montijo</span>
<span>Política de privacidade · Estatutos · Filiado na Federação de Patinagem de Portugal</span>
</div>
</div>
'
}

tail_html() { printf '%s' '</div>
</x-dc>
</body>
</html>
'; }

# ---------- cabeçalho de página interior ----------
pagehead() { # $1 migalhas, $2 etiqueta, $3 título (linha 1), $4 título contornado (linha 2), $5 lead, $6 manuscrito
cat <<EOF
<div style="position:relative; padding:52px 58px 60px;">
  <div class="lbl" style="color:#A2948A; margin-bottom:26px;">Início &nbsp;·&nbsp; $1</div>
  <div class="lbl" style="color:#FF2E1F; margin-bottom:20px;">$2</div>
  <h1 style="font-size:124px;">$3</h1>
  <h1 class="out" style="font-size:124px; margin-top:-6px;">$4</h1>
  <div style="display:grid; grid-template-columns:1.1fr .9fr; gap:40px; align-items:end; margin-top:26px;">
    <p style="font-size:19.5px; color:#C6B6A8; max-width:52ch;">$5</p>
    <div class="hand" style="font-size:32px; transform:rotate(-2deg); text-align:right;">$6</div>
  </div>
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
<div style="position:relative; padding:50px 58px 0;">
  <div style="display:flex; align-items:center; gap:16px; margin-bottom:24px;">
    <span style="height:3px; width:58px; background:#FF2E1F; display:block;"></span>
    <span class="lbl">Época 2026/27 · inscrições abertas</span>
  </div>
  <h1 style="font-size:192px;">Patinagem</h1>
  <div style="display:flex; align-items:flex-end; gap:28px; margin-top:-10px;">
    <h1 class="out" style="font-size:192px;">Artística</h1>
    <div style="font-family:Anton,sans-serif; font-size:66px; color:#FF2E1F; line-height:.82; padding-bottom:30px; text-transform:uppercase;">Montijo</div>
  </div>

  <div style="display:grid; grid-template-columns:1.02fr .98fr; gap:50px; margin-top:40px; align-items:start;">
    <div>
      <p style="font-size:21px; color:#C6B6A8; max-width:45ch;">Treinamos no Pavilhão Municipal do Montijo: exercícios de escola, saltos, piruetas e os programas que levamos a prova. Começa-se aos 4 anos e sem saber nada.</p>
      <div class="hand" style="font-size:38px; transform:rotate(-3deg); margin:14px 0 0 4px;">os patins emprestamos nós</div>
      <div style="display:flex; gap:13px; margin-top:30px;">
        <span class="btn">Marcar aula grátis</span>
        <span class="btn o">Conhecer o clube</span>
      </div>
      <div style="display:flex; margin-top:48px; border-top:3px solid rgba(246,237,225,.18);">
        <div style="flex:1; padding:20px 0;"><div style="font-family:Anton,sans-serif; font-size:56px; color:#E9B949; line-height:.9;">94</div><span class="lbl dim">Atletas</span></div>
        <div style="flex:1; padding:20px 0 20px 24px; border-left:3px solid rgba(246,237,225,.18);"><div style="font-family:Anton,sans-serif; font-size:56px; color:#E9B949; line-height:.9;">7</div><span class="lbl dim">Escalões</span></div>
        <div style="flex:1; padding:20px 0 20px 24px; border-left:3px solid rgba(246,237,225,.18);"><div style="font-family:Anton,sans-serif; font-size:56px; color:#E9B949; line-height:.9;">14</div><span class="lbl dim">Anos de clube</span></div>
      </div>
    </div>
    <div style="position:relative; height:560px;">
EOF
polaroid "atleta-01.jpg" "330px" "Beatriz, Cadetes" "-4" "position:absolute; right:66px; top:-30px; width:300px;"
polaroid "gala-01.jpg" "210px" "Gala de Natal, 2025" "6" "position:absolute; left:0; top:230px; width:262px;" "rgba(210,38,31,.5)"
cat <<'EOF'
      <div style="position:absolute; right:0; bottom:6px; width:138px; height:138px; border-radius:50%; background:#E9B949; color:#28190C; display:flex; flex-direction:column; align-items:center; justify-content:center; text-align:center; transform:rotate(-12deg); font-family:Anton,sans-serif; font-size:23px; line-height:.94; text-transform:uppercase;">
        Aula<br>grátis
        <span class="lbl" style="font-size:11px; margin-top:6px;">é já!</span>
      </div>
    </div>
  </div>
</div>

<div style="margin-top:56px;">
EOF
ticket "Gala de Natal" "12 dez" "21h00" "Pavilhão Municipal" "Bilhete 5 €" "Reservar →"
cat <<'EOF'
</div>

<div style="position:relative; padding:80px 58px 0;">
  <h2 style="font-size:82px;">O que se faz<br><span style="color:#FF2E1F;">nesta pista</span></h2>
  <div style="margin-top:42px; border-top:3px solid rgba(246,237,225,.18);">
    <div style="display:grid; grid-template-columns:96px 1fr 320px 60px; gap:28px; align-items:center; padding:32px 0; border-bottom:3px solid rgba(246,237,225,.18);">
      <span style="font-family:Anton,sans-serif; font-size:46px; color:#E9B949;">01</span>
      <h3 style="font-size:54px;">Escola de patinagem</h3>
      <p class="dim" style="font-size:15px;">A partir dos 4 anos, sem saber nada. Os patins são emprestados pelo clube.</p>
      <span style="color:#FF2E1F; text-align:right; display:flex; justify-content:flex-end;">
EOF
ico_arrow
cat <<'EOF'
      </span>
    </div>
    <div style="display:grid; grid-template-columns:96px 1fr 320px 60px; gap:28px; align-items:center; padding:32px 0; border-bottom:3px solid rgba(246,237,225,.18);">
      <span style="font-family:Anton,sans-serif; font-size:46px; color:#E9B949;">02</span>
      <h3 style="font-size:54px;">Competição federada</h3>
      <p class="dim" style="font-size:15px;">Quatro treinos por semana, exercícios de escola e programa livre. Provas regionais e nacionais.</p>
      <span style="color:#FF2E1F; display:flex; justify-content:flex-end;">
EOF
ico_arrow
cat <<'EOF'
      </span>
    </div>
    <div style="display:grid; grid-template-columns:96px 1fr 320px 60px; gap:28px; align-items:center; padding:32px 0; border-bottom:3px solid rgba(246,237,225,.18);">
      <span style="font-family:Anton,sans-serif; font-size:46px; color:#E9B949;">03</span>
      <h3 style="font-size:54px;">Grupos e galas</h3>
      <p class="dim" style="font-size:15px;">Coreografias de conjunto e o espetáculo de fim de época que enche o pavilhão.</p>
      <span style="color:#FF2E1F; display:flex; justify-content:flex-end;">
EOF
ico_arrow
cat <<'EOF'
      </span>
    </div>
  </div>
</div>

<div style="position:relative; padding:84px 58px 0;">
  <div style="display:flex; align-items:flex-end; justify-content:space-between; gap:40px;">
    <h2 style="font-size:68px;">Quadro de <span style="color:#E9B949;">avisos</span></h2>
    <span class="hand" style="font-size:30px; transform:rotate(2deg);">o que aí vem →</span>
  </div>
  <div style="display:grid; grid-template-columns:repeat(4,minmax(0,1fr)); gap:20px; margin-top:44px;">
    <div class="note" style="transform:rotate(-1.4deg);"><span class="pin"></span>
      <div class="lbl" style="color:#FF2E1F;">17 out · sábado</div>
      <h3 style="font-size:27px; margin:10px 0 8px;">Torneio de abertura</h3>
      <p class="dim" style="font-size:14.5px;">Pavilhão do Bonfim, Setúbal. Autocarro às 8h00 — boleias combinam-se no grupo.</p>
    </div>
    <div class="note" style="transform:rotate(1deg);"><span class="pin" style="background:#E9B949;"></span>
      <div class="lbl" style="color:#FF2E1F;">21 nov</div>
      <h3 style="font-size:27px; margin:10px 0 8px;">Estágio de inverno</h3>
      <p class="dim" style="font-size:14.5px;">Dois dias de trabalho técnico em casa. Inscrições até 7 de novembro na secretaria.</p>
    </div>
    <div class="note" style="transform:rotate(-.6deg);"><span class="pin" style="background:#12693B;"></span>
      <div class="lbl" style="color:#FF2E1F;">12 dez</div>
      <h3 style="font-size:27px; margin:10px 0 8px;">Gala de Natal</h3>
      <p class="dim" style="font-size:14.5px;">21h00, aqui em casa. Bilhete 5 €, à venda na secretaria. Leva a família toda.</p>
    </div>
    <div class="note" style="transform:rotate(1.6deg); background:#E9B949; border-color:transparent;"><span class="pin" style="background:#0D0806;"></span>
      <div class="lbl" style="color:#5C2B0C;">Todo o ano</div>
      <h3 style="font-size:27px; margin:10px 0 8px; color:#28190C;">Aula experimental</h3>
      <p style="font-size:14.5px; color:#4A3620;">Grátis e sem compromisso, em qualquer altura da época. Basta aparecer com meias altas.</p>
    </div>
  </div>
</div>

<div style="position:relative; padding:88px 58px 0;">
  <div style="display:grid; grid-template-columns:.95fr 1.05fr; gap:56px; align-items:center;">
    <div>
      <span class="lbl" style="color:#E9B949;">As pessoas</span>
      <h2 style="font-size:62px; margin-top:16px;">Treinadores que<br>sabem o nome<br>de cada atleta.</h2>
      <p class="mut" style="font-size:17px; margin-top:20px; max-width:44ch;">A Sofia patinou catorze anos antes de começar a treinar. O Ricardo põe os mais pequenos de pé. A Inês trata das coreografias. E a Helena, que fundou isto em 2012, ainda aparece aos sábados.</p>
      <div style="display:flex; align-items:center; margin-top:26px;">
        <img src="treinador-01.jpg" alt="" style="width:76px; height:76px; border-radius:50%; object-fit:cover; border:3px solid #0D0806;">
        <img src="treinador-02.jpg" alt="" style="width:76px; height:76px; border-radius:50%; object-fit:cover; border:3px solid #0D0806; margin-left:-20px;">
        <img src="treinador-03.jpg" alt="" style="width:76px; height:76px; border-radius:50%; object-fit:cover; border:3px solid #0D0806; margin-left:-20px;">
        <img src="treinador-05.jpg" alt="" style="width:76px; height:76px; border-radius:50%; object-fit:cover; border:3px solid #0D0806; margin-left:-20px;">
        <span class="hand" style="font-size:27px; margin-left:18px;">e mais dois!</span>
      </div>
    </div>
    <div style="display:grid; grid-template-columns:1fr 1fr; gap:16px;">
EOF
polaroid "treino-01.jpg" "186px" "Treino de terça" "-2"
polaroid "patins-01.jpg" "186px" "Os patins de sempre" "2.4" "margin-top:26px;"
polaroid "equipa-01.jpg" "186px" "A equipa, 2026" "1.4"
polaroid "gala-03.jpg" "186px" "Fim de época" "-3" "margin-top:22px;" "rgba(210,38,31,.5)"
cat <<'EOF'
    </div>
  </div>
</div>

<div style="position:relative; padding:90px 58px 0;">
  <div style="display:grid; grid-template-columns:1fr 1fr 1fr; gap:18px;">
EOF
photo "escola-01.jpg" "height:270px;" "Turma de sábado"
photo "atleta-05.jpg" "height:270px;" "Programa livre"
cat <<'EOF'
    <div style="position:relative; height:270px; background:#FF2E1F; display:flex; flex-direction:column; justify-content:space-between; padding:28px;">
      <span class="lbl">Segue o clube</span>
      <div style="font-family:Anton,sans-serif; font-size:44px; line-height:.88; text-transform:uppercase;">@cpbvm<br>montijo</div>
    </div>
  </div>
</div>

<div style="position:relative; padding:88px 58px 92px;">
  <div style="position:relative; border-radius:26px 22px 28px 20px; padding:64px; text-align:center; background:linear-gradient(140deg,#D2261F,#6E0C10);">
    <h2 style="font-size:74px;">Vem experimentar<br>num sábado.</h2>
    <p style="font-size:18.5px; color:#FFF5F3; max-width:50ch; margin:18px auto 0;">Roupa confortável, meias altas e vontade de cair umas quantas vezes. Os patins são por nossa conta.</p>
    <div style="display:flex; gap:13px; justify-content:center; margin-top:32px;">
      <span class="btn k">Marcar aula grátis</span>
      <span class="btn o" style="border-color:rgba(255,255,255,.45);">212 345 678</span>
    </div>
    <div class="hand" style="font-size:30px; margin-top:22px; color:#FFE08A;">até já!</div>
  </div>
</div>
EOF
footer_html
tail_html
} > Main.dc.html
echo "Main ok"

# =========================================================
#  O CLUBE (SOBRE)
# =========================================================
{
head_html
nav_html sobre
pagehead "O clube" "Desde 2012 no Montijo" "O clube" "por dentro" "Começámos com dezoito miúdos e duas treinadoras num pavilhão emprestado. Hoje somos noventa e quatro e continuamos a conhecer-nos todos pelo nome." "somos noventa e quatro"
cat <<'EOF'
<div style="position:relative; padding:0 58px;">
  <div style="display:grid; grid-template-columns:1fr 1fr; gap:16px;">
EOF
photo "equipa-01.jpg" "height:300px;" "A equipa, 2026"
photo "gala-02.jpg" "height:300px;" "Gala de Natal, 2025"
cat <<'EOF'
  </div>
</div>

<div style="position:relative; padding:84px 58px 0;">
  <div style="display:grid; grid-template-columns:1fr 1fr; gap:60px; align-items:start;">
    <h2 style="font-size:72px;">Ensinar a cair.<br><span class="out-r" style="-webkit-text-stroke:2px #FF2E1F;">E a levantar</span><br>com estilo.</h2>
    <div>
      <p class="mut" style="font-size:18px;">Metade do trabalho é técnico: apoios, quedas, saltos, piruetas. A outra metade é entrar em pista com a sala cheia e conseguir contar a música até ao fim. Trabalhamos as duas desde a primeira aula.</p>
      <p class="mut" style="font-size:18px; margin-top:16px;">Cada atleta tem um plano à medida da idade e do escalão, definido em setembro com a família e revisto ao longo do ano — do primeiro treino de terça à gala de dezembro.</p>
      <div style="display:grid; grid-template-columns:repeat(3,minmax(0,1fr)); gap:14px; margin-top:30px;">
        <div class="note" style="transform:rotate(-1deg); padding:20px;"><div style="font-family:Anton,sans-serif; font-size:32px; color:#E9B949;">01</div><div style="font-weight:800; margin-top:6px;">Técnica primeiro</div><p class="dim" style="font-size:14px; margin-top:4px;">Dois anos de apoios e quedas antes dos saltos. Vêm mais tarde e vêm melhores.</p></div>
        <div class="note" style="transform:rotate(1.2deg); padding:20px;"><div style="font-family:Anton,sans-serif; font-size:32px; color:#E9B949;">02</div><div style="font-weight:800; margin-top:6px;">As mais velhas ensinam</div><p class="dim" style="font-size:14px; margin-top:4px;">Às quintas, a equipa de competição fica meia hora com as turmas de iniciação.</p></div>
        <div class="note" style="transform:rotate(-.6deg); padding:20px;"><div style="font-family:Anton,sans-serif; font-size:32px; color:#E9B949;">03</div><div style="font-weight:800; margin-top:6px;">Ninguém fica de fora</div><p class="dim" style="font-size:14px; margin-top:4px;">Quem não quer competir treina na mesma e entra na gala de dezembro.</p></div>
      </div>
    </div>
  </div>
</div>

<div style="margin-top:84px;">
EOF
ticket "94 atletas" "7 escalões" "4 treinadores na pista" "4 treinos por semana" "14 anos de clube"
cat <<'EOF'
</div>

<div style="position:relative; padding:84px 58px 0;">
  <div style="display:flex; align-items:flex-end; justify-content:space-between; gap:40px; margin-bottom:46px;">
    <h2 style="font-size:72px;">Como aqui<br><span style="color:#FF2E1F;">chegámos</span></h2>
    <span class="hand" style="font-size:30px; transform:rotate(-2deg);">catorze anos, sempre no Montijo</span>
  </div>
  <div style="position:relative; border-top:3px solid rgba(233,185,73,.45); padding-top:40px;">
    <div style="display:grid; grid-template-columns:repeat(5,minmax(0,1fr)); gap:18px;">
      <div class="note" style="transform:rotate(-1.6deg);"><span class="pin"></span>
        <div style="font-family:Anton,sans-serif; font-size:40px; color:#E9B949;">2012</div>
        <div style="font-weight:800; margin-top:6px;">Nasce o clube</div>
        <p class="dim" style="font-size:14.5px; margin-top:6px;">Um grupo de pais e duas treinadoras abrem as primeiras turmas: 18 atletas.</p>
      </div>
      <div class="note" style="transform:rotate(1.2deg); margin-top:22px;"><span class="pin" style="background:#E9B949;"></span>
        <div style="font-family:Anton,sans-serif; font-size:40px; color:#E9B949;">2015</div>
        <div style="font-weight:800; margin-top:6px;">Primeira equipa</div>
        <p class="dim" style="font-size:14.5px; margin-top:6px;">Cinco atletas federadas e a estreia no Campeonato Regional de Setúbal.</p>
      </div>
      <div class="note" style="transform:rotate(-.8deg);"><span class="pin" style="background:#12693B;"></span>
        <div style="font-family:Anton,sans-serif; font-size:40px; color:#E9B949;">2019</div>
        <div style="font-weight:800; margin-top:6px;">Primeiro pódio</div>
        <p class="dim" style="font-size:14.5px; margin-top:6px;">Terceiro lugar em conjuntos no Encontro Nacional — o troféu ainda está na vitrina.</p>
      </div>
      <div class="note" style="transform:rotate(1.6deg); margin-top:22px;"><span class="pin"></span>
        <div style="font-family:Anton,sans-serif; font-size:40px; color:#E9B949;">2023</div>
        <div style="font-weight:800; margin-top:6px;">Casa nova</div>
        <p class="dim" style="font-size:14.5px; margin-top:6px;">Passámos para o Pavilhão Municipal e duplicámos as turmas.</p>
      </div>
      <div class="note" style="transform:rotate(-1deg); background:#E9B949; border-color:transparent;"><span class="pin" style="background:#0D0806;"></span>
        <div style="font-family:Anton,sans-serif; font-size:40px; color:#28190C;">Hoje</div>
        <div style="font-weight:800; margin-top:6px; color:#28190C;">94 atletas</div>
        <p style="font-size:14.5px; margin-top:6px; color:#4A3620;">Sete escalões, competição federada e uma gala que esgota.</p>
      </div>
    </div>
  </div>
</div>

<div style="position:relative; padding:88px 58px 0;">
  <div style="display:grid; grid-template-columns:1.05fr .95fr; gap:56px; align-items:center;">
    <div>
      <span class="lbl" style="color:#FF2E1F;">Identidade</span>
      <h2 style="font-size:70px; margin-top:16px;">Preto, vermelho<br>e uma linha<br><span style="color:#E9B949;">dourada</span>.</h2>
      <p class="mut" style="font-size:17.5px; margin-top:20px; max-width:46ch;">O emblema tem tudo: o preto do fundo, o anel vermelho, o traço verde por dentro, a patinadora e o dourado das letras. O fato de competição nasce daí — preto a abrir para vermelho, com uma linha dourada a atravessar. Cada atleta recebe-o ao entrar para a equipa.</p>
      <div style="display:flex; gap:12px; margin-top:26px;">
        <span style="width:52px; height:52px; border-radius:50%; background:#0D0806; border:2px solid rgba(246,237,225,.25);"></span>
        <span style="width:52px; height:52px; border-radius:50%; background:linear-gradient(140deg,#FF3A2A,#7C0E12);"></span>
        <span style="width:52px; height:52px; border-radius:50%; background:linear-gradient(140deg,#FFE9A8,#C08C24);"></span>
        <span style="width:52px; height:52px; border-radius:50%; background:#12693B;"></span>
      </div>
      <div style="display:flex; align-items:center; gap:12px; margin-top:22px;">
EOF
ico_squiggle
cat <<'EOF'
        <span class="hand" style="font-size:26px;">as mesmas cores desde 2012</span>
      </div>
    </div>
    <div style="display:grid; grid-template-columns:1fr 1fr; gap:16px;">
EOF
polaroid "equipamento-01.jpg" "250px" "Fato de competição" "-3"
polaroid "equipamento-02.jpg" "250px" "Programa livre" "3" "margin-top:24px;" "rgba(210,38,31,.5)"
cat <<'EOF'
    </div>
  </div>
</div>

<div style="position:relative; padding:88px 58px 92px;">
  <div style="border-radius:24px 20px 26px 18px; padding:56px; background:linear-gradient(140deg,#D2261F,#6E0C10); display:grid; grid-template-columns:1fr auto; gap:40px; align-items:center;">
    <div>
      <h2 style="font-size:56px;">Queres fazer parte disto?</h2>
      <p style="font-size:18px; color:#FFF5F3; margin-top:12px; max-width:46ch;">A aula experimental é grátis e não obriga a nada. Vem ver como é um treino.</p>
    </div>
    <span class="btn k" style="padding:19px 34px;">Marcar aula grátis</span>
  </div>
</div>
EOF
footer_html
tail_html
} > Sobre.dc.html

# =========================================================
#  TREINADORES
# =========================================================
coach() { # $1 foto, $2 nome, $3 função, $4 bio, $5 chip, $6 rotação
  printf '<div style="position:relative;">'
  polaroid "$1" "300px" "$2" "$6"
  cat <<EOF
  <div style="padding:20px 6px 0;">
    <div class="lbl" style="color:#FF2E1F;">$3</div>
    <h3 style="font-size:34px; margin-top:10px;">$2</h3>
    <p class="dim" style="font-size:15px; margin-top:10px;">$4</p>
    <div style="margin-top:14px;"><span class="chip">$5</span></div>
  </div>
</div>
EOF
}
{
head_html
nav_html equipa
pagehead "Treinadores" "Equipa técnica" "Quem está" "na pista" "Seis pessoas: quatro na pista, uma na secretaria e uma a segurar o clube de pé desde 2012. Os contactos diretos estão na ficha de cada turma." "conhece-os um a um"
cat <<'EOF'
<div style="position:relative; padding:0 58px;">
  <div style="display:grid; grid-template-columns:repeat(3,minmax(0,1fr)); gap:34px;">
EOF
coach "treinador-01.jpg" "Sofia Marques" "Treinadora principal" "Patinou catorze anos em competição e está no clube desde 2014. Acompanha de Cadetes a Seniores e monta os programas de prova." "Grau II · FPP" "-2"
coach "treinador-02.jpg" "Ricardo Nunes" "Escola de patinagem" "Dá as turmas de iniciação desde 2016. É com ele que se aprende a travar antes de aprender a andar." "Grau I · FPP" "1.6"
coach "treinador-03.jpg" "Inês Carvalho" "Coreografia e expressão" "Formada em dança contemporânea. Escolhe as músicas, monta as coreografias e ensaia-as até saírem de olhos fechados." "Coreografia" "-1"
cat <<'EOF'
  </div>
  <div style="display:grid; grid-template-columns:repeat(3,minmax(0,1fr)); gap:34px; margin-top:56px;">
EOF
coach "treinador-04.jpg" "Tiago Lopes" "Preparação física" "Licenciado em Ciências do Desporto. Força, mobilidade e prevenção de lesões, às segundas, fora da pista." "Condição física" "1.2"
coach "treinador-05.jpg" "Helena Duarte" "Presidente da direção" "Fundou o clube em 2012 com mais duas famílias. Trata da federação, da câmara e dos autocarros para as provas." "Direção" "-1.8"
coach "treinador-06.jpg" "Marta Ribeiro" "Secretaria e inscrições" "Inscrições, quotas, licenças e seguros. É quem responde ao email do clube, normalmente no próprio dia." "Apoio às famílias" "2"
cat <<'EOF'
  </div>
</div>

<div style="margin-top:88px;">
EOF
ticket "Avaliação no início da época" "Plano por atleta" "Feedback aos pais" "Competir com sentido"
cat <<'EOF'
</div>

<div style="position:relative; padding:84px 58px 92px;">
  <div style="display:grid; grid-template-columns:.9fr 1.1fr; gap:56px; align-items:start;">
    <div>
      <h2 style="font-size:70px;">Um plano por<br>atleta, não um<br>plano por <span style="color:#FF2E1F;">turma</span>.</h2>
      <div class="hand" style="font-size:30px; transform:rotate(-2deg); margin-top:18px;">ninguém avança à pressa</div>
    </div>
    <div style="display:flex; flex-direction:column; gap:16px;">
      <div class="note" style="transform:rotate(-.8deg);"><span class="pin"></span>
        <h3 style="font-size:30px;">Avaliação no início da época</h3>
        <p class="mut" style="font-size:16px; margin-top:8px;">Cada atleta é avaliado tecnicamente e definem-se com a família os objetivos até junho. Ninguém fica a treinar sem saber para onde vai.</p>
      </div>
      <div class="note" style="transform:rotate(.9deg);"><span class="pin" style="background:#E9B949;"></span>
        <h3 style="font-size:30px;">Acompanhamento contínuo</h3>
        <p class="mut" style="font-size:16px; margin-top:8px;">Ponto de situação com os encarregados de educação em janeiro e em junho, e sempre que alguma coisa mude.</p>
      </div>
      <div class="note" style="transform:rotate(-.5deg);"><span class="pin" style="background:#12693B;"></span>
        <h3 style="font-size:30px;">Competir com sentido</h3>
        <p class="mut" style="font-size:16px; margin-top:8px;">Vai a prova quem já faz o programa inteiro em treino, duas vezes seguidas e sem falhas.</p>
      </div>
    </div>
  </div>
</div>
EOF
footer_html
tail_html
} > EquipaTecnica.dc.html
echo "Sobre + Treinadores ok"

# =========================================================
#  ATLETAS
# =========================================================
athlete() { # $1 foto, $2 nome, $3 escalão, $4 nota, $5 rotação
  printf '<div>'
  polaroid "$1" "260px" "$2" "$5"
  cat <<EOF
  <div style="padding:16px 4px 0;">
    <div class="lbl" style="color:#E9B949;">$3</div>
    <div class="dim" style="font-size:14.5px; margin-top:6px;">$4</div>
  </div>
</div>
EOF
}
{
head_html
nav_html atletas
pagehead "Atletas" "Noventa e quatro" "Quem veste o" "preto e vermelho" "Da turma de sábado aos escalões federados. Escolhe um escalão para veres o grupo — e sim, todos começaram sem saber patinar." "cada um com a sua história"
cat <<'EOF'
<div style="position:relative; padding:0 58px;">
  <div style="display:flex; flex-wrap:wrap; gap:10px; margin-bottom:48px;">
    <span class="lbl" style="padding:12px 22px; border-radius:999px; background:#FF2E1F; color:#fff;">Todos</span>
EOF
for e in Escola Iniciados Infantis Cadetes Juvenis Juniores Seniores; do
  printf '<span class="lbl" style="padding:12px 22px; border-radius:999px; border:2px solid rgba(246,237,225,.18); color:#C6B6A8;">%s</span>' "$e"
done
cat <<'EOF'
  </div>
  <div style="display:grid; grid-template-columns:repeat(4,minmax(0,1fr)); gap:30px;">
EOF
athlete "atleta-01.jpg" "Beatriz Antunes" "Cadetes" "No clube desde 2017 · 2.ª no Regional de Setúbal" "-2"
athlete "atleta-02.jpg" "Matilde Rocha" "Infantis" "No clube desde 2019" "1.6"
athlete "atleta-03.jpg" "Leonor Pires" "Iniciados" "No clube desde 2021" "-1.2"
athlete "atleta-04.jpg" "Carolina Mendes" "Juvenis" "No clube desde 2015 · Campeonato Nacional" "2"
cat <<'EOF'
  </div>
  <div style="display:grid; grid-template-columns:repeat(4,minmax(0,1fr)); gap:30px; margin-top:46px;">
EOF
athlete "atleta-05.jpg" "Mariana Gomes" "Juniores" "No clube desde 2013 · capitã de equipa" "1.2"
athlete "atleta-06.jpg" "Rodrigo Silva" "Cadetes" "No clube desde 2018" "-1.8"
athlete "atleta-07.jpg" "Francisca Tavares" "Escola" "No clube desde 2025" "2.2"
athlete "atleta-08.jpg" "Alice Fonseca" "Escola" "Entrou esta época" "-1"
cat <<'EOF'
  </div>
</div>

<div style="margin-top:90px;">
EOF
ticket "Época 2025/26" "3 pódios" "11 provas" "um recorde atrás do outro"
cat <<'EOF'
</div>

<div style="position:relative; padding:84px 58px 92px;">
  <div style="display:flex; align-items:flex-end; justify-content:space-between; gap:40px; margin-bottom:44px;">
    <h2 style="font-size:72px;">Resultados a<br><span style="color:#E9B949;">guardar</span></h2>
    <span class="hand" style="font-size:30px; transform:rotate(2deg);">com muito orgulho</span>
  </div>
  <div style="display:grid; grid-template-columns:repeat(3,minmax(0,1fr)); gap:20px;">
    <div style="position:relative; border:3px solid #E9B949; border-radius:4px; padding:34px; background:linear-gradient(150deg, rgba(233,185,73,.14), transparent);">
      <div style="font-family:Anton,sans-serif; font-size:72px; color:#E9B949; line-height:.86;">2.º</div>
      <h3 style="font-size:34px; margin-top:12px;">Beatriz Antunes</h3>
      <p class="mut" style="font-size:15.5px; margin-top:8px;">Campeonato Regional de Setúbal · Cadetes<br>Palmela, maio de 2026</p>
    </div>
    <div style="position:relative; border:3px solid rgba(246,237,225,.2); border-radius:4px; padding:34px;">
      <div style="font-family:Anton,sans-serif; font-size:72px; color:#F6EDE1; line-height:.86;">5.º</div>
      <h3 style="font-size:34px; margin-top:12px;">Carolina Mendes</h3>
      <p class="mut" style="font-size:15.5px; margin-top:8px;">Campeonato Nacional · Juvenis<br>Anadia, abril de 2026</p>
    </div>
    <div style="position:relative; border:3px solid #12693B; border-radius:4px; padding:34px; background:linear-gradient(150deg, rgba(18,105,59,.16), transparent);">
      <div style="font-family:Anton,sans-serif; font-size:72px; color:#5FC98C; line-height:.86;">3.º</div>
      <h3 style="font-size:34px; margin-top:12px;">Grupo de quartetos</h3>
      <p class="mut" style="font-size:15.5px; margin-top:8px;">Encontro Nacional de Conjuntos<br>Maia, março de 2026</p>
    </div>
  </div>
</div>
EOF
footer_html
tail_html
} > Atletas.dc.html

# =========================================================
#  AGENDA
# =========================================================
evrow() { # $1 dia, $2 mês, $3 título, $4 detalhe, $5 classe chip, $6 chip, $7 opacidade
cat <<EOF
<div style="display:grid; grid-template-columns:120px 1fr auto; gap:30px; align-items:center; padding:26px 0; border-bottom:3px solid rgba(246,237,225,.16); opacity:$7;">
  <div style="font-family:Anton,sans-serif; line-height:.84;">
    <span style="font-size:52px; color:#E9B949;">$1</span>
    <span style="display:block; font-size:20px; color:#FF2E1F; text-transform:uppercase;">$2</span>
  </div>
  <div>
    <h3 style="font-size:40px;">$3</h3>
    <p class="dim" style="font-size:15px; margin-top:6px;">$4</p>
  </div>
  <span class="chip $5">$6</span>
</div>
EOF
}
{
head_html
nav_html eventos
pagehead "Agenda" "Setembro a junho" "A época" "toda aqui" "Provas federadas, estágios, galas e os convívios do clube. Atualizamos sempre que a federação publica novas datas." "marca no calendário!"
cat <<'EOF'
<div style="position:relative; padding:0 58px;">
  <div style="position:relative; border:3px solid #E9B949; border-radius:4px; overflow:hidden; display:grid; grid-template-columns:1.05fr .95fr;">
    <div style="padding:52px;">
      <span class="chip r">Próximo evento</span>
      <h2 style="font-size:80px; margin-top:22px;">Gala de<br>Natal</h2>
      <div class="hand" style="font-size:34px; transform:rotate(-2deg); margin-top:8px;">a noite do ano cá em casa</div>
      <p class="mut" style="font-size:17px; margin-top:18px;">Todas as turmas em palco, das mais pequenas à equipa de competição. Dura cerca de duas horas e a sala enche sempre — vem cedo.</p>
      <div style="display:grid; grid-template-columns:1fr 1fr; gap:20px; margin-top:30px; padding-top:24px; border-top:3px solid rgba(246,237,225,.16);">
        <div><div class="lbl" style="color:#FF2E1F;">Data</div><div style="font-size:17px; margin-top:5px;">12 de dezembro, 21h00</div></div>
        <div><div class="lbl" style="color:#FF2E1F;">Local</div><div style="font-size:17px; margin-top:5px;">Pavilhão Municipal do Montijo</div></div>
        <div><div class="lbl" style="color:#FF2E1F;">Bilhetes</div><div style="font-size:17px; margin-top:5px;">5 € · secretaria e à porta</div></div>
        <div><div class="lbl" style="color:#FF2E1F;">Duração</div><div style="font-size:17px; margin-top:5px;">Cerca de 2 horas</div></div>
      </div>
      <div style="margin-top:30px;"><span class="btn">Reservar bilhete</span></div>
    </div>
EOF
photo "gala-02.jpg" "min-height:520px;" "Gala de Natal de 2025"
cat <<'EOF'
  </div>
</div>

<div style="position:relative; padding:80px 58px 0;">
  <h2 style="font-size:72px; margin-bottom:30px;">Aí <span style="color:#FF2E1F;">vem</span></h2>
  <div style="border-top:3px solid rgba(246,237,225,.16);">
EOF
evrow "17" "Out" "Torneio de abertura de época" "Pavilhão do Bonfim, Setúbal · 9h30 · Iniciados a Juniores" "r" "Competição" "1"
evrow "21" "Nov" "Estágio técnico de inverno" "Pavilhão Municipal do Montijo · inscrição até 7 de novembro" "g" "Formação" "1"
evrow "12" "Dez" "Gala de Natal do CPBVM" "Pavilhão Municipal do Montijo · 21h00 · bilhete 5 €" "" "Exibição" "1"
evrow "23" "Jan" "Taça Regional — 1.ª jornada" "Pavilhão da Quinta dos Bacelos, Palmela · 10h00" "r" "Competição" "1"
evrow "13" "Fev" "Convívio de famílias do clube" "Sede do clube · aberto a pais e encarregados de educação" "" "Clube" "1"
evrow "18" "Abr" "Campeonato Regional de Setúbal" "Local a confirmar pela associação" "r" "Competição" "1"
cat <<'EOF'
  </div>
</div>

<div style="margin-top:80px;">
EOF
ticket "Treinos" "Terça 18h30" "Quinta 18h30" "Sexta 18h30" "Sábado 10h00"
cat <<'EOF'
</div>

<div style="position:relative; padding:80px 58px 92px;">
  <h2 style="font-size:52px; color:#A2948A; margin-bottom:26px;">Já aconteceu</h2>
  <div style="border-top:3px solid rgba(246,237,225,.16);">
EOF
evrow "13" "Set" "Aulas abertas" "Pavilhão Municipal do Montijo · 27 novos inscritos" "g" "Escola" ".72"
evrow "20" "Jun" "Gala de fim de época 2025/26" "Pavilhão Municipal do Montijo · 380 espectadores" "" "Exibição" ".72"
evrow "9" "Mai" "Campeonato Regional de Setúbal" "Palmela · três pódios para o clube" "r" "Competição" ".72"
cat <<'EOF'
  </div>
</div>
EOF
footer_html
tail_html
} > Eventos.dc.html
echo "Atletas + Agenda ok"

# =========================================================
#  INSCRIÇÕES
# =========================================================
pfield() { # $1 etiqueta, $2 valor, $3 "select"
  printf '<div><div class="lbl" style="color:#6A5643; margin-bottom:8px;">%s</div>' "$1"
  printf '<div style="display:flex; align-items:center; justify-content:space-between; gap:12px; padding:14px 16px; border:2px solid #D9CBB8; border-radius:8px 7px 9px 6px; background:#FFFBF3; font-size:15.5px; color:#4A3620;"><span>%s</span>' "$2"
  [ "${3:-}" = "select" ] && printf '<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#B4471E" stroke-width="2.2" aria-hidden="true"><path d="M6 9l6 6 6-6"/></svg>'
  printf '</div></div>'
}
faq() { # $1 pergunta, $2 resposta, $3 rotação
  printf '<div class="note" style="transform:rotate(%sdeg);"><span class="pin" style="background:%s"></span><h3 style="font-size:28px;">%s</h3>' \
    "$3" "$( [ -n "${2:-}" ] && echo '#E9B949' || echo '#D2261F' )" "$1"
  [ -n "${2:-}" ] && printf '<p class="mut" style="font-size:15.5px; margin-top:10px;">%s</p>' "$2"
  printf '</div>'
}
{
head_html
nav_html inscricoes
pagehead "Inscrições" "Época 2026/27" "Começar é" "fácil" "Aula experimental grátis, sem compromisso, em qualquer altura do ano. Traz roupa confortável e meias altas — os patins emprestamos nós." "é só aparecer"
cat <<'EOF'
<div style="position:relative; padding:0 58px;">
  <div style="display:grid; grid-template-columns:repeat(3,minmax(0,1fr)); gap:20px;">
    <div class="note" style="transform:rotate(-1.2deg);"><span class="pin"></span>
      <div style="font-family:Anton,sans-serif; font-size:64px; color:#E9B949; line-height:.86;">01</div>
      <h3 style="font-size:30px; margin-top:12px;">Diz que queres vir</h3>
      <p class="dim" style="font-size:15px; margin-top:8px;">Preenche o formulário aqui em baixo ou liga. Respondemos em 48 horas com dia e hora.</p>
    </div>
    <div class="note" style="transform:rotate(1deg);"><span class="pin" style="background:#E9B949;"></span>
      <div style="font-family:Anton,sans-serif; font-size:64px; color:#E9B949; line-height:.86;">02</div>
      <h3 style="font-size:30px; margin-top:12px;">Vem experimentar</h3>
      <p class="dim" style="font-size:15px; margin-top:8px;">Uma aula completa com a turma do escalão certo. Sem custos e sem compromisso nenhum.</p>
    </div>
    <div class="note" style="transform:rotate(-.7deg);"><span class="pin" style="background:#12693B;"></span>
      <div style="font-family:Anton,sans-serif; font-size:64px; color:#E9B949; line-height:.86;">03</div>
      <h3 style="font-size:30px; margin-top:12px;">Ficas sócio</h3>
      <p class="dim" style="font-size:15px; margin-top:8px;">Ficha de sócio, documentos e primeira mensalidade. A partir daí é preto e vermelho.</p>
    </div>
  </div>
</div>

<div style="margin-top:80px;">
EOF
ticket "Escola 1x · 28 €" "Escola 2x · 42 €" "Competição · 65 €" "Joia anual · 35 €" "Irmãos · −15 %"
cat <<'EOF'
</div>

<div style="position:relative; padding:80px 58px 0;">
  <div style="display:grid; grid-template-columns:.95fr 1.05fr; gap:50px; align-items:start;">
    <div>
      <h2 style="font-size:70px;">Escolhe o<br><span style="color:#FF2E1F;">ritmo</span></h2>
      <div class="hand" style="font-size:30px; transform:rotate(-2deg); margin:10px 0 30px;">dá para mudar a meio do ano</div>
      <div style="display:flex; flex-direction:column; gap:14px;">
        <div style="display:flex; justify-content:space-between; align-items:center; gap:20px; padding:26px 30px; border:3px solid rgba(246,237,225,.18); border-radius:4px;">
          <div>
            <h3 style="font-size:32px;">Escola · 1 vez</h3>
            <p class="dim" style="font-size:14.5px; margin-top:4px;">Sábado, 10h00–11h30 · a partir dos 4 anos</p>
          </div>
          <div style="font-family:Anton,sans-serif; font-size:50px; color:#E9B949; line-height:.9;">28 €</div>
        </div>
        <div style="position:relative; display:flex; justify-content:space-between; align-items:center; gap:20px; padding:26px 30px; border:3px solid #E9B949; border-radius:4px; background:linear-gradient(150deg, rgba(233,185,73,.14), transparent);">
          <span class="lbl" style="position:absolute; top:-11px; left:26px; background:#E9B949; color:#28190C; padding:3px 10px;">O mais escolhido</span>
          <div>
            <h3 style="font-size:32px;">Escola · 2 vezes</h3>
            <p class="dim" style="font-size:14.5px; margin-top:4px;">Terça e quinta, 18h30–20h00</p>
          </div>
          <div style="font-family:Anton,sans-serif; font-size:50px; color:#E9B949; line-height:.9;">42 €</div>
        </div>
        <div style="display:flex; justify-content:space-between; align-items:center; gap:20px; padding:26px 30px; border:3px solid rgba(255,46,31,.5); border-radius:4px;">
          <div>
            <h3 style="font-size:32px;">Competição</h3>
            <p class="dim" style="font-size:14.5px; margin-top:4px;">Terça, quinta, sexta e sábado · inclui provas</p>
          </div>
          <div style="font-family:Anton,sans-serif; font-size:50px; color:#E9B949; line-height:.9;">65 €</div>
        </div>
      </div>
      <div class="note" style="margin-top:20px; transform:rotate(.6deg);">
        <div class="lbl" style="color:#FF2E1F; margin-bottom:12px;">A ter em conta</div>
        <div style="display:flex; flex-direction:column; gap:8px; font-size:15.5px; color:#C6B6A8;">
          <span>· Joia de inscrição anual: 35 €, com seguro desportivo incluído</span>
          <span>· Desconto de irmãos: 15 % na segunda mensalidade</span>
          <span>· Equipamento de competição: 120 €, uma vez por época</span>
          <span>· Licença federativa: 45 € para atletas de competição</span>
        </div>
      </div>
    </div>

    <div style="position:relative; background:#F6EDE1; color:#2A1B12; padding:44px; border-radius:10px 8px 12px 7px; box-shadow:0 30px 70px rgba(0,0,0,.6); transform:rotate(-.6deg);">
      <span class="tape" style="background:rgba(210,38,31,.42); top:-14px; left:44px; margin-left:0;"></span>
      <div class="lbl" style="color:#98360F;">Ficha de inscrição</div>
      <h2 style="font-size:46px; margin:12px 0 26px; color:#2A1B12;">Aula experimental</h2>
      <div style="display:grid; grid-template-columns:1fr 1fr; gap:18px;">
EOF
pfield "Nome do atleta" "Carlota Neves Ferreira"
pfield "Data de nascimento" "14 / 03 / 2018"
pfield "Encarregado de educação" "Rita Neves Ferreira"
pfield "Telemóvel" "962 118 340"
cat <<'EOF'
      </div>
      <div style="margin-top:18px;">
EOF
pfield "E-mail" "rita.neves@exemplo.pt"
cat <<'EOF'
      </div>
      <div style="display:grid; grid-template-columns:1fr 1fr; gap:18px; margin-top:18px;">
EOF
pfield "Já patina?" "Nunca experimentou" select
pfield "Horário preferido" "Terça e quinta, fim do dia" select
cat <<'EOF'
      </div>
      <div style="margin-top:18px;">
        <div class="lbl" style="color:#6A5643; margin-bottom:8px;">Alguma coisa que devamos saber?</div>
        <div style="padding:14px 16px; height:92px; border:2px solid #D9CBB8; border-radius:8px 7px 9px 6px; background:#FFFBF3; font-size:15.5px; color:#4A3620;">A Carlota tem uma amiga na turma de sábado e gostava de ficar no mesmo grupo.</div>
      </div>
      <div style="display:flex; gap:12px; align-items:flex-start; margin-top:20px;">
        <span style="width:22px; height:22px; border:2px solid #B4471E; border-radius:5px; flex:none; display:flex; align-items:center; justify-content:center;"><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#B4471E" stroke-width="3" aria-hidden="true"><path d="M5 12.5l5 5L19 7"/></svg></span>
        <span style="font-size:14.5px; color:#5C4632;">Autorizo o tratamento dos dados para efeitos de contacto, nos termos da política de privacidade do clube.</span>
      </div>
      <div style="margin-top:26px;"><span class="btn" style="display:block; text-align:center; justify-content:center;">Enviar inscrição</span></div>
      <div class="hand" style="font-size:26px; text-align:center; margin-top:14px; color:#B4471E;">respondemos em 48 horas!</div>
    </div>
  </div>
</div>

<div style="position:relative; padding:88px 58px 92px;">
  <div style="display:flex; align-items:flex-end; justify-content:space-between; gap:40px; margin-bottom:44px;">
    <h2 style="font-size:70px;">Perguntas que<br>nos fazem <span style="color:#E9B949;">sempre</span></h2>
    <span class="hand" style="font-size:30px; transform:rotate(2deg);">e as respostas de sempre</span>
  </div>
  <div style="display:grid; grid-template-columns:repeat(3,minmax(0,1fr)); gap:20px;">
EOF
faq "A partir de que idade se pode começar?" "A escola recebe crianças a partir dos 4 anos. Dos 4 aos 6 há turmas próprias, mais curtas e com duas treinadoras na pista." "-1.2"
faq "É preciso ter patins?" "Nas primeiras semanas emprestamos nós. A partir do segundo mês vale a pena comprar — aconselhamos o modelo na secretaria." "1"
faq "Quantos treinos tem cada escalão?" "A escola tem um ou dois treinos por semana, de hora e meia. A equipa de competição treina quatro vezes, incluindo a sessão de preparação física à segunda." "-.6"
cat <<'EOF'
  </div>
  <div style="display:grid; grid-template-columns:repeat(3,minmax(0,1fr)); gap:20px; margin-top:20px;">
EOF
faq "Que documentos são precisos?" "Cartão de cidadão do atleta e do encarregado de educação, atestado médico, uma fotografia e o IBAN para o débito da mensalidade." "1.4"
faq "Pode-se entrar a meio da época?" "Pode. A joia é proporcional aos meses que faltam e a turma é escolhida conforme o nível — há sempre quem entre em janeiro." "-1"
faq "E se a minha filha não gostar?" "Avisa-nos e a mensalidade seguinte não é cobrada. Não há fidelização nem contratos: só o mês em curso." ".8"
cat <<'EOF'
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
pagehead "Contactos" "Pavilhão Municipal do Montijo" "Passa por" "cá" "Aparece num treino, liga ou escreve. Respondemos a tudo em 48 horas — e às urgências bem mais depressa." "a porta está aberta"
cat <<'EOF'
<div style="position:relative; padding:0 58px;">
  <div style="display:grid; grid-template-columns:repeat(4,minmax(0,1fr)); gap:20px;">
    <div class="note" style="transform:rotate(-1.2deg);"><span class="pin"></span>
      <div class="lbl" style="color:#FF2E1F;">Morada</div>
      <p style="font-size:16.5px; margin-top:10px;">Pavilhão Municipal do Montijo<br>Rua das Palmeiras 12<br>2870-355 Montijo</p>
    </div>
    <div class="note" style="transform:rotate(1deg);"><span class="pin" style="background:#E9B949;"></span>
      <div class="lbl" style="color:#FF2E1F;">Falar connosco</div>
      <p style="font-size:16.5px; margin-top:10px;">geral@cpbvm.pt<br>212 345 678<br>963 214 587</p>
    </div>
    <div class="note" style="transform:rotate(-.6deg);"><span class="pin" style="background:#12693B;"></span>
      <div class="lbl" style="color:#FF2E1F;">Treinos</div>
      <p style="font-size:16.5px; margin-top:10px;">Escola · terça e quinta, 18h30<br>Competição · sexta, 18h30<br>Escola · sábado, 10h00</p>
    </div>
    <div class="note" style="transform:rotate(1.5deg);"><span class="pin"></span>
      <div class="lbl" style="color:#FF2E1F;">Secretaria</div>
      <p style="font-size:16.5px; margin-top:10px;">Terça e quinta · 18h00–20h00<br>Sábado · 10h00–12h00</p>
    </div>
  </div>
</div>

<div style="position:relative; padding:80px 58px 0;">
  <div style="display:grid; grid-template-columns:1.05fr .95fr; gap:50px; align-items:start;">
    <div>
      <h2 style="font-size:70px;">Como se<br><span style="color:#FF2E1F;">chega cá</span></h2>
      <p class="mut" style="font-size:17px; margin-top:18px; max-width:46ch;">O pavilhão fica junto ao parque municipal, com estacionamento à porta. As carreiras 431 e 437 param a 200 metros; de barco, são quinze minutos a pé do Terminal Fluvial.</p>
      <div style="position:relative; height:330px; margin-top:26px; border:3px solid rgba(246,237,225,.18); overflow:hidden; background:
        repeating-linear-gradient(0deg, rgba(246,237,225,.05) 0 1px, transparent 1px 48px),
        repeating-linear-gradient(90deg, rgba(246,237,225,.05) 0 1px, transparent 1px 48px),
        linear-gradient(150deg,#1A110C,#0B0705);">
        <div style="position:absolute; left:0; right:0; top:46%; height:12px; background:rgba(233,185,73,.16); transform:rotate(-7deg);"></div>
        <div style="position:absolute; top:0; bottom:0; left:34%; width:9px; background:rgba(246,237,225,.06);"></div>
        <div style="position:absolute; left:52%; top:42%; transform:translate(-50%,-50%); display:flex; flex-direction:column; align-items:center; gap:8px;">
          <svg width="38" height="38" viewBox="0 0 24 24" fill="none" stroke="#FF2E1F" stroke-width="1.8" aria-hidden="true"><path d="M12 21s7-5.6 7-11a7 7 0 10-14 0c0 5.4 7 11 7 11z"/><circle cx="12" cy="10" r="2.6"/></svg>
          <span class="lbl">Pavilhão Municipal</span>
        </div>
        <span class="hand" style="position:absolute; right:26px; bottom:20px; font-size:26px; transform:rotate(-4deg);">é já ali!</span>
      </div>
    </div>

    <div style="position:relative; background:#F6EDE1; color:#2A1B12; padding:44px; border-radius:10px 8px 12px 7px; box-shadow:0 30px 70px rgba(0,0,0,.6); transform:rotate(.5deg);">
      <span class="tape" style="background:rgba(233,185,73,.55); top:-14px; left:46px; margin-left:0;"></span>
      <div class="lbl" style="color:#98360F;">Escreve-nos</div>
      <h2 style="font-size:46px; margin:12px 0 26px; color:#2A1B12;">Manda recado</h2>
      <div style="display:grid; grid-template-columns:1fr 1fr; gap:18px;">
EOF
pfield "Nome" "João Almeida"
pfield "E-mail" "joao.almeida@exemplo.pt"
cat <<'EOF'
      </div>
      <div style="margin-top:18px;">
EOF
pfield "Assunto" "Horários da escola de patinagem" select
cat <<'EOF'
      </div>
      <div style="margin-top:18px;">
        <div class="lbl" style="color:#6A5643; margin-bottom:8px;">Mensagem</div>
        <div style="padding:14px 16px; height:190px; border:2px solid #D9CBB8; border-radius:8px 7px 9px 6px; background:#FFFBF3; font-size:15.5px; color:#4A3620;">Boa tarde. O meu filho tem 7 anos e queria perceber se ainda há vagas na turma de sábado. Obrigado!</div>
      </div>
      <div style="margin-top:26px;"><span class="btn" style="display:block; text-align:center; justify-content:center;">Enviar mensagem</span></div>
    </div>
  </div>
</div>

<div style="margin-top:88px;">
EOF
ticket "geral@cpbvm.pt" "212 345 678" "@cpbvmmontijo" "Rua das Palmeiras 12, Montijo"
cat <<'EOF'
</div>
<div style="height:92px;"></div>
EOF
footer_html
tail_html
} > Contactos.dc.html
echo "Inscricoes + Contactos ok"

# =========================================================
#  TELEMÓVEL — HOMEPAGE (390px)
# =========================================================
{
head_html
cat <<'EOF'
<div style="width:390px; position:relative;">
  <div style="display:flex; align-items:center; justify-content:space-between; padding:14px 18px; border-bottom:2px solid #E9B949;">
    <div style="display:flex; align-items:center; gap:10px;">
EOF
emblem 42 "m"
cat <<'EOF'
      <div style="line-height:1.1;">
        <div style="font-family:Anton,sans-serif; font-size:17px; text-transform:uppercase;">Patinagem BVM</div>
        <div class="lbl" style="color:#E9B949; font-size:11px;">Montijo</div>
      </div>
    </div>
    <span style="width:44px; height:44px; border:2px solid rgba(246,237,225,.2); border-radius:10px; display:flex; flex-direction:column; justify-content:center; align-items:center; gap:4px; flex:none;">
      <span style="width:18px; height:2px; background:#E9B949; display:block;"></span>
      <span style="width:18px; height:2px; background:#E9B949; display:block;"></span>
      <span style="width:18px; height:2px; background:#E9B949; display:block;"></span>
    </span>
  </div>

  <div style="padding:30px 18px 0;">
    <div class="lbl" style="color:#FF2E1F;">Época 2026/27 · inscrições abertas</div>
    <h1 style="font-size:70px; margin-top:16px;">Patinagem</h1>
    <h1 class="out" style="font-size:70px; -webkit-text-stroke:1.6px #E9B949;">Artística</h1>
    <div style="font-family:Anton,sans-serif; font-size:34px; color:#FF2E1F; text-transform:uppercase; line-height:1;">Montijo</div>
    <p class="mut" style="font-size:16.5px; margin-top:16px;">Exercícios de escola, saltos, piruetas e os programas que levamos a prova. Começa-se aos 4 anos e sem saber nada.</p>
    <div class="hand" style="font-size:30px; transform:rotate(-3deg); margin-top:10px;">os patins emprestamos nós</div>
    <div style="display:flex; flex-direction:column; gap:10px; margin-top:24px;">
      <span class="btn" style="justify-content:center; padding:17px;">Marcar aula grátis</span>
      <span class="btn o" style="justify-content:center; padding:17px;">Conhecer o clube</span>
    </div>
    <div style="position:relative; height:400px; margin-top:28px;">
EOF
polaroid "atleta-01.jpg" "230px" "Beatriz, Cadetes" "-4" "position:absolute; right:0; top:0; width:215px;"
polaroid "gala-01.jpg" "150px" "Gala de Natal" "6" "position:absolute; left:0; top:120px; width:180px;" "rgba(210,38,31,.5)"
cat <<'EOF'
    </div>
    <div style="display:flex; margin-top:10px; border-top:3px solid rgba(246,237,225,.18);">
      <div style="flex:1; padding:16px 0;"><div style="font-family:Anton,sans-serif; font-size:40px; color:#E9B949; line-height:.9;">94</div><span class="lbl dim" style="font-size:10.5px;">Atletas</span></div>
      <div style="flex:1; padding:16px 0 16px 16px; border-left:3px solid rgba(246,237,225,.18);"><div style="font-family:Anton,sans-serif; font-size:40px; color:#E9B949; line-height:.9;">7</div><span class="lbl dim" style="font-size:10.5px;">Escalões</span></div>
      <div style="flex:1; padding:16px 0 16px 16px; border-left:3px solid rgba(246,237,225,.18);"><div style="font-family:Anton,sans-serif; font-size:40px; color:#E9B949; line-height:.9;">14</div><span class="lbl dim" style="font-size:10.5px;">Anos</span></div>
    </div>
  </div>

  <div style="margin-top:26px; background:#E9B949; color:#170A02; padding:13px 18px; display:flex; justify-content:space-between; font-family:Anton,sans-serif; font-size:17px; text-transform:uppercase;">
    <span>Gala de Natal</span><span>12 dez</span><span>21h00</span>
  </div>

  <div style="padding:36px 18px 0;">
    <h2 style="font-size:44px;">O que se faz<br><span style="color:#FF2E1F;">nesta pista</span></h2>
    <div style="margin-top:24px; border-top:3px solid rgba(246,237,225,.18);">
      <div style="display:flex; gap:16px; align-items:center; padding:20px 0; border-bottom:3px solid rgba(246,237,225,.18);">
        <span style="font-family:Anton,sans-serif; font-size:30px; color:#E9B949;">01</span>
        <div><h3 style="font-size:26px;">Escola de patinagem</h3><p class="dim" style="font-size:14px; margin-top:4px;">A partir dos 4 anos.</p></div>
      </div>
      <div style="display:flex; gap:16px; align-items:center; padding:20px 0; border-bottom:3px solid rgba(246,237,225,.18);">
        <span style="font-family:Anton,sans-serif; font-size:30px; color:#E9B949;">02</span>
        <div><h3 style="font-size:26px;">Competição</h3><p class="dim" style="font-size:14px; margin-top:4px;">Quatro treinos por semana.</p></div>
      </div>
      <div style="display:flex; gap:16px; align-items:center; padding:20px 0; border-bottom:3px solid rgba(246,237,225,.18);">
        <span style="font-family:Anton,sans-serif; font-size:30px; color:#E9B949;">03</span>
        <div><h3 style="font-size:26px;">Grupos e galas</h3><p class="dim" style="font-size:14px; margin-top:4px;">O espetáculo de dezembro.</p></div>
      </div>
    </div>
  </div>

  <div style="padding:36px 18px 0;">
    <h2 style="font-size:40px;">Quadro de <span style="color:#E9B949;">avisos</span></h2>
    <div style="display:flex; flex-direction:column; gap:16px; margin-top:22px;">
      <div class="note" style="transform:rotate(-1deg);"><span class="pin"></span>
        <div class="lbl" style="color:#FF2E1F;">17 out</div>
        <h3 style="font-size:24px; margin-top:8px;">Torneio de abertura</h3>
        <p class="dim" style="font-size:14px; margin-top:6px;">Pavilhão do Bonfim, Setúbal. Autocarro às 8h00.</p>
      </div>
      <div class="note" style="transform:rotate(1.2deg); background:#E9B949; border-color:transparent;"><span class="pin" style="background:#0D0806;"></span>
        <div class="lbl" style="color:#5C2B0C;">Todo o ano</div>
        <h3 style="font-size:24px; margin-top:8px; color:#28190C;">Aula experimental</h3>
        <p style="font-size:14px; margin-top:6px; color:#4A3620;">Grátis, sem compromisso. Basta aparecer com meias altas.</p>
      </div>
    </div>
  </div>

  <div style="padding:36px 18px 0;">
    <div style="display:grid; grid-template-columns:1fr 1fr; gap:14px;">
EOF
polaroid "treino-01.jpg" "130px" "Treino de terça" "-2"
polaroid "patins-01.jpg" "130px" "Os patins" "2.4" "margin-top:18px;"
polaroid "equipa-01.jpg" "130px" "A equipa" "1.4"
polaroid "gala-03.jpg" "130px" "Fim de época" "-3" "margin-top:16px;" "rgba(210,38,31,.5)"
cat <<'EOF'
    </div>
  </div>

  <div style="padding:40px 18px 44px;">
    <div style="border-radius:22px 18px 24px 16px; padding:34px 24px; text-align:center; background:linear-gradient(140deg,#D2261F,#6E0C10);">
      <h2 style="font-size:40px;">Vem experimentar num sábado.</h2>
      <p style="font-size:15.5px; color:#FFF5F3; margin-top:12px;">Os patins são por nossa conta.</p>
      <span class="btn k" style="justify-content:center; padding:16px; margin-top:20px; display:flex;">Marcar aula grátis</span>
      <div class="hand" style="font-size:26px; margin-top:14px; color:#FFE08A;">até já!</div>
    </div>
  </div>

  <div style="border-top:2px solid #E9B949; background:#0A0605; padding:32px 18px 26px;">
    <div style="display:flex; align-items:center; gap:12px;">
EOF
emblem 46 "mf"
cat <<'EOF'
      <div style="font-family:Anton,sans-serif; font-size:24px; line-height:.9; text-transform:uppercase;">Patinagem<br>BVM</div>
    </div>
    <div style="display:flex; flex-wrap:wrap; gap:10px 20px; margin-top:20px;" class="lbl">
      <span>O clube</span><span>Treinadores</span><span>Atletas</span><span>Agenda</span><span>Inscrições</span><span>Contactos</span>
    </div>
    <p class="dim" style="font-size:13.5px; margin-top:18px;">Pavilhão Municipal do Montijo · geral@cpbvm.pt · 212 345 678</p>
    <p class="dim" style="font-size:12.5px; margin-top:12px;">© 2026 Clube de Patinagem BVM</p>
  </div>
</div>
EOF
tail_html
} > MobileHome.dc.html
echo "Mobile ok"
