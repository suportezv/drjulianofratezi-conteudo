# Dr. Juliano Fratezi Conteúdo Studio

Estúdio de edição e agendamento de conteúdo para as redes do **Dr. Juliano Fratezi**. Infraestrutura compartilhada da agência; posicionamento desta marca ("Fratezi sem jaleco").

- **`FRAMEWORK.md`**: persona, regras, pilares, compliance CFM, assinaturas de edição, escolha de framework de motion e fluxo por vídeo.
- **`CLAUDE.md`**: memória persistente do projeto (IDs, contas, rede, gotchas, histórico).
- **`projects/`**: um subdiretório por vídeo (BRIEFING.md, CENAS.md, CAPTION.md, POS.md, `edl.json`).
- **`scripts/`**: setup e validação do ambiente (Linux/cloud) e as ferramentas genéricas do estúdio (decupagem por âncora de texto, LUT S-Log2, índice remoto de ZIP, geração de imagem, upload para o Drive).
- **`remotion/`**: composições Remotion; a marca vive só em `src/marca.ts` e `src/Root.tsx`.

## Primeiro uso (cloud)

```bash
bash scripts/setup.sh      # 6 passos; sai com código 0 mesmo se um passo avisar: ler a saída
bash scripts/validate.sh   # tem que ficar verde; testa comportamento, não presença de arquivo
```

Em sessão nova, conferir `ls /workspace` antes de contar com video-use ou hyperframes; se estiver vazio, rodar o setup à mão.
