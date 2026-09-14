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

## Fontes da informação

Tudo o que o site afirma vem dos cartazes do clube, dos comunicados do grupo de
pais (época 2025/26) ou de fontes públicas:

- **Comunicados do clube**: cinco grupos de treino, os três pavilhões, mensalidades
  (36/38/40 €, 10 % no segundo irmão, agosto sem mensalidade, pagamento até dia 10),
  exame médico desportivo, calendário próprio (Torneio Cidade do Montijo, Festival
  de Patinagem BVM, gala do clube), Festas de São Pedro, "A Minha Cena" na RTP2.
- **Resultados 2025/26**: 1.º por equipas na XVI Taça Cidade de Portimão (20–21 dez,
  22 atletas), 2.º entre 24 clubes no Torneio Aberto APS, 6.º entre 23 clubes no
  Torneio Intercalar, 100 % nos 3.ºs Testes Distritais (17 atletas, níveis I a V).
- **Cartazes 2026/27**: a partir dos 3 anos, horários, contactos, morada, Instagram.
- **Câmara Municipal do Montijo**: treinadora Cristina Oliveira; XIV Torneio de
  Portimão de 2023 (2.º lugar), para a comparação com 2025.
- **Registo**: constituição a 13 de setembro de 2022.

## O que ainda é provisório

- **Fotografias dos atletas.** As fotos de patins em `img/patim-*.jpg` e
  `img/patins-par.jpg` são do clube. As restantes (`gala-*`, `escola-01`,
  `atleta-03`, `treino-01`) continuam a ser de banco de imagem com licença livre,
  tratadas na mesma paleta. As fotografias de equipa do clube existem mas mostram
  menores — só entram com autorização da direção e das famílias.
- **O emblema** é um desenho SVG por aproximação ao original, à espera do ficheiro real.

## Dados pessoais

O site não publica nomes de atletas, de pais nem contactos privados. Os únicos
contactos são os que o clube divulga nos seus cartazes.
