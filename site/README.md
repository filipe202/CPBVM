# Site do Clube de Patinagem BVM

Página única, sem dependências de build: `index.html` (HTML + CSS + JS), `img/` e
`fonts/`. Abre-se diretamente no browser ou serve-se como ficheiros estáticos.

## O que tem

- Intro animada com o emblema, barra de progresso de leitura e cursor dourado.
- Herói em ecrã inteiro com fotografia em ken burns e paralaxe.
- Tarjas em movimento (gala e horários), inclinadas.
- Manifesto que acende palavra a palavra à medida que se desce.
- Painéis de modalidades que se abrem ao passar o rato.
- Contadores animados.
- Galeria horizontal que corre com o scroll (secção fixa).
- Secção da gala com paralaxe, quadro de avisos e tabela de mensalidades.
- Menu móvel, `prefers-reduced-motion` respeitado, sem scroll horizontal.

## Fontes

Por omissão carrega Anton, Bricolage Grotesque e Caveat do Google Fonts. Para
alojamento sem dependências externas, troca esse `<link>` por
`<link rel="stylesheet" href="fonts.css">` — os ficheiros `.woff2` já estão em `fonts/`.

## Avisos

- **Todo o conteúdo é fictício**: nomes, datas, mensalidades, resultados e contactos.
- **As fotografias** vêm de bancos de imagem com licença livre (Openverse/Wikimedia),
  tratadas na paleta do clube. São para substituir por fotografias do CPBVM.
- **O emblema** é um desenho SVG por aproximação ao original, à espera do ficheiro real.
