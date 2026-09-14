# Mockups — site do Clube de Patinagem BVM

Artboards em `*.dc.html`, gerados por `_build.sh` (as partes partilhadas — emblema,
navegação, rodapé — estão lá em cima no ficheiro; cada página é gerada a seguir).

```bash
bash _build.sh        # regenera todos os .dc.html
```

## Avisos importantes

- **Dados fictícios.** Nomes da equipa técnica e das atletas, datas, horários,
  mensalidades e resultados são inventados, apenas para se ver o site cheio.
  Tudo isto tem de ser substituído por informação real antes de ir para o ar.
- **Fotografias de exemplo.** Vieram de bancos de imagem com licença livre
  (Openverse / Wikimedia Commons) e foram tratadas na paleta do clube em `img/`.
  São para substituir por fotos das atletas do CPBVM.
- **Emblema provisório.** O emblema é um desenho SVG por aproximação ao original
  (função `emblem()` em `_build.sh`), porque o ficheiro do logo ainda não está no
  repositório. Quando estiver em `assets/img/logo.png`, a função passa a devolver
  `<img src="logo.png">` e o emblema verdadeiro aparece em todas as páginas.
