# Dr. Juliano Fratezi Conteúdo Studio (memória persistente do projeto)

Este repositório é o **Dr. Juliano Fratezi Conteúdo Studio**: edição e agendamento de conteúdo para as redes do **Dr. Juliano Fratezi**. A infraestrutura é a mesma dos estúdios irmãos da agência (`profissioai-conteudo`, `eita-conteudo`, `ana-conteudo`, `normalyze.conteudo`, `profecia-conteudo` e os seis da conta Zavi); o posicionamento é o desta marca.

**Antes de editar qualquer vídeo ou escrever qualquer caption, leia `FRAMEWORK.md`** (posicionamento "Fratezi sem jaleco", regras inegociáveis, pilares, compliance CFM, assinaturas de edição e fluxo por vídeo).

> Ferramenta é genérica, marca não é. Os scripts, o `setup.sh`, o `validate.sh` e o `remotion/` vieram do `profissioai-conteudo` (branch `claude/reels-automaticos-profissio-d0qk2d`, guia `PORTAR.md`) **sem nenhuma referência àquela marca**. Persona, voz, pilares e credencial daqui vêm do briefing do próprio Dr. Juliano, nunca de outro estúdio. O que ainda não foi confirmado está marcado **PENDENTE** e deve ser perguntado, nunca inventado.

## A marca: quem é o Dr. Juliano Fratezi

- **Nome público**: Dr. Juliano Fratezi (nome completo: Juliano Paulo Fratezi).
- **Credencial** (para citação em texto público): **"Dr. Juliano Fratezi, ortopedista e traumatologista, especialista em coluna e médico da dor, CRM-SP 116845, RQE 94203"**. CRM e RQE vieram de busca na web sobre o site oficial (`drjulianofratezi.com.br`) e Doctoralia; o site está fora da allowlist e **não foi lido diretamente**. **PENDENTE: confirmar no site ou com o próprio médico, antes do primeiro post, qual RQE cobre "coluna" e "dor"** (pela Resolução CFM 2.336/2023, cada especialidade ou área de atuação anunciada precisa do RQE correspondente; "ortopedia e traumatologia" é a especialidade, "cirurgia da coluna" e "dor" são áreas de atuação).
- **Atuação**: tratamento clínico e cirúrgico da coluna, bloqueios e infiltrações, neuromodulação, abordagens minimamente invasivas. Consultórios em Osasco (Av. dos Autonomistas, 896) e São Paulo (Vila Mariana e Pompeia). Sócio-fundador da **Zero Dor** (ZD Clínicas), rede com cinco clínicas.
- **Fora do consultório**: motociclista (viaja de moto, Capital Moto Week em Brasília com o Dr. Felipe Chiota), rally, pai, empresário. "Sou um médico, mas não tenho aquela cara de médico de jaleco e gravata" (fala dele, reunião de 29/jul/2026).
- **Relação com a EITA**: cliente da Anaclaudia Zani há cerca de 8 anos e **investidor** do projeto EITA. Isso é conflito de interesse declarável em qualquer peça que cite a EITA (ver `FRAMEWORK.md`).
- **Site**: `drjulianofratezi.com.br`. **Instagram**: `@drjulianofratezi` (São Paulo, SP; cerca de 38 mil seguidores em jul/2026, conta parada). **Facebook**: página `drjulianofratezi`. TikTok, YouTube e LinkedIn: **PENDENTE** (não encontrados em busca; perguntar).

## Fontes do briefing (Drive, lidas integralmente em 18/set/2026)

- **Reunião "Juliano + Time EITA | Projeto Influenciadores" (29/jul/2026)**, notas e transcrição do Gemini: Google Doc `1TYsIFyMa7xel0yPk4cwGdsxhiFShM4C_7zO-aAtmfgA` (dona: `thaila.conessa@zavi.ag`). É a fonte da voz, das dores e dos interesses dele.
- **"Juliano Fratezi - Apresentação Comercial Zavi"** (Google Slides `1qLB7KDGhh3XqbESo1AU5RAjYrtZZLdC4tu_EdM8WLFQ`), que contém o planejamento **"FRATEZI SEM JALECO. Planejamento de reposicionamento de conteúdo, Estúdio Zavi, agosto 2026"**: ponto de partida, 3 armadilhas, tese, regra de ouro da EITA, 4 pilares com mix, referências, compliance, captação em blocos, 8 primeiras pautas, medição e proposta comercial (fee R$ 2.500/mês, uma diária de captação por mês).
- **Atenção**: a busca por "Fratezi" no Drive também devolve uma planilha de rodada de investimento da EITA com dados pessoais de terceiros (CPF, RG, endereço). **Nunca usar nem citar em conteúdo.**

## Regras que valem em qualquer resposta pública

- Nunca usar travessão em texto público (caption, lettering, legenda): reescrever a frase.
- Quando citar o criador: sempre a credencial completa acima, com CRM e RQE (exigência da Resolução CFM 2.336/2023 para médico que se anuncia especialista).
- Nunca prometer resultado terapêutico; nunca chamar a EITA de psicóloga ou terapeuta (é "mentora virtual" ou "companheira emocional"); casos clínicos sempre anonimizados; conflito de interesse com a EITA sempre declarado.
- Palavrão em vídeo **se bipa, não se corta**.
- Loudness final: **-14 LUFS**.

## Working dirs

- Estúdio: este repo (symlink `~/drjulianofratezi-conteudo` aponta para cá). Projetos em `projects/<nome>/` (BRIEFING.md com o framework de motion na primeira linha, CENAS.md, CAPTION.md, POS.md, `edl.json` quando houver decupagem).
- Ferramentas: `video-use` e `hyperframes` clonados em `/workspace/browser-use/` e `/workspace/heygen-com/` (Linux/cloud) ou `~/video-editor/` (Mac). Skills registradas em `~/.claude/skills/`. Remotion em `remotion/` (deps instaladas pelo setup).
- Ambiente novo (container limpo): rode `bash scripts/setup.sh` e depois `bash scripts/validate.sh`. **Em sessão nova, conferir `ls /workspace` antes de contar com video-use ou hyperframes**: o gatilho de boot do environment não roda o setup de forma confiável (ver gotcha do caminho relativo).

## Ferramentas do estúdio (`scripts/`, genéricas, portadas em 18/set/2026)

| Script | O que faz |
|---|---|
| `decupar.py` | Decupa brutos por **âncoras de texto** ("de tal frase até tal frase") casadas contra a transcrição com timestamp por palavra do Scribe. Junta trechos, gira para vertical, aplica LUT, normaliza áudio. Entrada: `edl.json` |
| `relatorio_decupagem.py` | Retranscreve as peças finais e monta o relatório do que ficou e do que caiu |
| `gera_lut_slog2.py` | Gera LUT 3D de S-Log2/S-Gamut para Rec.709 (`colour-science`) |
| `zip_index_remoto.py` | Lista e extrai arquivos de um ZIP gigante no Drive por range request, sem baixar o ZIP |
| `gera_imagem.py` | Imagem pela OpenAI ou pelo Gemini, mesma interface; chaves só do ambiente (**neste environment ainda não há chave nem rede para isso**, ver abaixo) |
| `sobe_para_drive.py` | Sobe arquivos para uma pasta do Drive com token pronto (**`www.googleapis.com` está bloqueado aqui**, ver abaixo) |
| `setup.sh` / `validate.sh` | Setup em 6 passos que nunca derruba o boot; validação **por comportamento** (3 filtros reais do ffmpeg, `is_portrait_source` em retrato/paisagem/girado, 1 frame real do Remotion, hosts da rede) |

## IDs e contas (verificados em 18/set/2026)

- **Metricool**: conta da agência (`suporte@zavi.ag`). Marca **`drjulianofratezi`, blog_id `6741542`**, timezone `America/Sao_Paulo`, criada em 18/ago/2026. **BLOQUEIO: o Instagram conectado nessa marca é `drajulianaromano`, não `drjulianofratezi`.** Agendar qualquer coisa nela hoje publica no perfil de outra médica. Nenhum post agendado ou em rascunho até 31/dez/2026 (conferido). **Não agendar nada até reconectar o Instagram certo** e, só então, medir o melhor horário com `getBestTimeToPostByNetwork`. Só o Instagram está conectado: TikTok, YouTube, Facebook, LinkedIn e Pinterest **PENDENTE conectar**.
- **Regra de agendamento (todas as marcas da agência)**: sempre incluir TODOS os canais conectados da marca no post, exceto YouTube horizontal. YouTube entra como **Short** (`youtubeData: {type: "short", title, madeForKids: false}`); Instagram como REEL; Facebook como REEL; TikTok, LinkedIn e Pinterest com networkData padrão. Nunca publicar vídeo vertical como YouTube horizontal comum.
- **Kairogen**: conta da agência (`suporte@zavi.ag`), plano **FREE, 0 créditos**, 1 geração simultânea. B-roll por IA **indisponível** até comprar créditos.
- **ElevenLabs**: chave `sk_` (51 chars) na env var `ELEVENLABS_API_KEY` do environment; o setup grava em `.env` na raiz do video-use. Plano **Creator**, ativo, **121.000 caracteres/mês** (601 usados; ciclo reinicia em 28/set/2026), 30 slots de voz (0 usados), clonagem instantânea e profissional liberadas. A chave tem `user_read` (o endpoint `/v1/user/subscription` responde), então dá para checar saldo antes de um lote. Voz da marca para narração: **PENDENTE** (a biblioteca já tem vozes pt-BR profissionais: Bruno, Carlos, Raquel, Carla, Lax; clonar a voz do Juliano exige autorização dele por escrito).
- **OpenAI / Gemini** (`gera_imagem.py`): `OPENAI_API_KEY` e `GEMINI_API_KEY` **ausentes** no environment, e `api.openai.com` e `generativelanguage.googleapis.com` **fora da allowlist**. Para usar: cadastrar as chaves no environment, liberar os dois hosts e **abrir sessão nova** (variável entra na criação do container).
- **Drive (brutos)**: pasta do projeto **PENDENTE: criar/apontar** (padrão: pasta com "qualquer pessoa com o link: leitor" para download direto). Não existe pasta com "Fratezi" ou "Juliano" no nome no Drive da agência hoje.

## Rede do environment (verificado em 18/set/2026)

Liberados (respondem HTTP pelo proxy): `drive.google.com`, `drive.usercontent.google.com`, `api.elevenlabs.io`, `api.github.com`, `github.com`, `objects.githubusercontent.com`, `pypi.org`, `files.pythonhosted.org`, `registry.npmjs.org`.

Bloqueados (000 no CONNECT): `raw.githubusercontent.com` (não precisa: skills do hyperframes vêm do clone local), `static.metricool.com` (logo da marca), `www.googleapis.com` (upload para o Drive), `api.openai.com`, `generativelanguage.googleapis.com`, `www.instagram.com`, `www.facebook.com`, `drjulianofratezi.com.br`, `www.doctoralia.com.br`.

Diagnóstico em um comando: `curl -sv https://host/ 2>&1 | grep CONNECT`. `HTTP/1.1 403` no CONNECT é allowlist; qualquer outra resposta é a rede passando e o problema sendo outro (chave, quota, rota). A allowlist é literal por subdomínio: para um site inteiro, `*.dominio.com` junto do apex.

## Gotchas essenciais (herdados dos estúdios da agência, todos validados)

- Brutos de iPhone são HLG 10-bit: gerar proxy SDR uma vez antes de editar (filtro `colorspace=all=bt709:itrc=bt2020-10:iprimaries=bt2020:ispace=bt2020nc`).
- **Brutos de Sony em S-Log2 (A7 III): converter, não "filtrar".** O XML lateral de cada clipe (`C00xxM01.XML`) declara `CaptureGammaEquation` e `CaptureColorPrimaries`; quando diz `s-log2`/`s-gamut`, a imagem chega chapada e precisa de conversão para Rec.709. `scripts/gera_lut_slog2.py` gera a LUT (log → linear → primárias → ombro → gama). Dois cuidados que a prática impôs: **exposição −0,5 stop e joelho em 0,65**, senão o branco estoura; e conferir que o ffmpeg aplica a `lut3d` **em RGB, não em YUV** (verificar com `-v verbose`). Saída sempre com `out_range=tv` e `-color_range tv`.
- **Câmera pode gravar na vertical sem gravar a flag de rotação.** O arquivo vem 3840x2160 deitado e o ffprobe não mostra rotação nenhuma; só olhando um frame se descobre. Corrigir com `transpose=1` antes de escalar. Checar um frame de qualquer lote novo antes de planejar o corte.
- **Decupagem por âncora de texto, não por timecode.** `scripts/decupar.py` recebe um `edl.json` onde cada trecho é "de tal frase até tal frase"; ele casa as âncoras contra a transcrição por palavra e resolve os tempos. Revisar um corte vira editar uma frase. O campo `apos` empurra o cursor quando a mesma frase aparece antes.
- **O patch `video-use-is-portrait-source` foi aposentado (18/set/2026).** O upstream reescreveu `is_portrait_source` para ler o `rotation` do side data. O `validate.sh` testa **comportamento** (retrato, paisagem e paisagem com matriz de rotação 90) em vez de procurar o patch. Atenção: a tag de metadado `rotate=90` **não** conta (a função ignora de propósito, porque não garante autorotação); o que vale é a display matrix (`-display_rotation 90`).
- Legendas SEMPRE por último no filter chain; overlays via PIL em PNG sequence + qtrle (ou PNG estático com fade de alpha).
- Zoom animado com `zoompan`, não `crop` (crop não aceita `t` em w/h).
- **Remotion renderiza com o `headless_shell`, não com o Chromium do Playwright.** O `chromium-1194` removeu o headless antigo e o launch morre com "Old Headless mode has been removed". O binário certo é `/opt/pw-browsers/chromium_headless_shell-1194/chrome-linux/headless_shell`, fixado em `remotion/remotion.config.ts`. Baixar o browser próprio do Remotion está fora da allowlist.
- **Remotion e HyperFrames resolvem o mesmo problema.** Só existe ponte de mão única (`remotion-to-hyperframes`). Regra de escolha em `FRAMEWORK.md`; cada peça declara o framework na primeira linha do `BRIEFING.md`.
- **Licença do Remotion não é MIT**: grátis para indivíduo, organização sem fins lucrativos, empresa **de até 3 funcionários** e avaliação; acima disso exige Company License (remotion.pro). Confirmar o enquadramento da agência antes de usar em produção.
- **Sem rede de fontes no render.** Fonte da marca não carrega no Remotion headless; cai para a sans do sistema. Para usar a fonte da casa, embutir o arquivo em `assets/fonts/` como asset local.
- **Processo em background com `nohup`/`setsid` é recolhido quando a tool call retorna.** Usar `run_in_background: true` da própria ferramenta Bash, que o harness rastreia. Em lote longo, `flock` num arquivo de lock evita a corrida.
- **O setup do environment falha por caminho relativo, não por gatilho instável.** O campo de setup script do environment roda com o diretório de trabalho no **pai** do repo; `bash scripts/setup.sh` dá exit 127 e a sessão nasce sem `/workspace`. Usar caminho absoluto (`bash /home/user/drjulianofratezi-conteudo/scripts/setup.sh`) ou a versão à prova de diretório: `for p in ./scripts/setup.sh ./*/scripts/setup.sh; do [ -f "$p" ] && exec bash "$p"; done; p=$(find /home /workspace /repo /app /src -maxdepth 4 -type f -path "*/scripts/setup.sh" 2>/dev/null | head -1); [ -n "$p" ] && exec bash "$p"; echo "setup.sh nao encontrado no repo"; exit 1`. Merge não conserta a sessão: o script só roda no boot de container novo.
- **A URL do ffmpeg estático: `releases/download/latest/…` serve o arquivo; `releases/latest/download/…` devolve 404.** O `setup.sh` tenta as duas em ordem e confere a assinatura XZ (`fd377a585a00`) antes de extrair. Os 403 do apt são ruído esperado no cloud.
- Metricool MCP: sem delete (cancelar = update `draft:true`; update devolve id novo); mídia por URL pública (o Metricool copia para o CDN dele na hora).
- **Metricool, rascunho com data vencida não publica e não avisa.** Um post `draft:true` cuja data passa continua aparecendo em `getScheduledPosts` como se estivesse agendado, mas nunca dispara. Regra: **quem agenda tira do rascunho na mesma sessão e confirma com `getScheduledPosts`**; com data no passado, é preciso data nova.
- **Ler o índice de um ZIP gigante no Drive sem baixar o arquivo**: `drive.usercontent.google.com` aceita `Range`; `scripts/zip_index_remoto.py` lê o EOCD (e o ZIP64), lista tudo e extrai um arquivo `stored` sozinho por outro `Range`.
- **Upload de vídeo para o Drive não é possível deste container**: `www.googleapis.com` está fora da allowlist e o conector MCP do Drive só aceita `base64Content` (inviável para vídeo). Criar pasta funciona. Entrega de vídeo sai por commit na branch ou pelo envio direto na conversa.
- Mac: usar ffmpeg-full keg-only com PATH explícito. Linux: ffmpeg do apt já serve (ou o build estático do setup).
- Cloud, brutos do Drive: environment com network **Custom** e `drive.google.com` + `drive.usercontent.google.com` + `api.elevenlabs.io` liberados. Download direto de arquivo público, qualquer tamanho: `curl -L "https://drive.usercontent.google.com/download?id=<ID>&export=download&confirm=t"`. O conector MCP do Drive serve para busca e metadados; download por ele só até ~4 MB. Fallback para arquivo público pequeno: Kairogen `download_audio_from_url`.
- Cloud, mídia pública para o Metricool: commit temporário do render na branch (repo público, confirmado em 18/set/2026: a API do GitHub responde 200 sem autenticação; `raw.githubusercontent.com` é lido pelos servidores do Metricool, não por este container), agendar e remover o arquivo em seguida. Exige `git add -f` (o `.gitignore` barra mídia) com autorização do usuário. **Por isso este repo deve continuar público.**
- **Instagram exige login, mesmo liberado na rede.** Perfil devolve 302 para login, API `web_profile_info` devolve 401, embed devolve casca vazia. Para analisar feed (próprio ou de referência): prints/gravação de tela do usuário, o conector do Metricool (só contas conectadas à marca) ou a Graph API da Meta com token.
- **Chromium não contorna a allowlist**: o headless usa o mesmo agent proxy e devolve `ERR_TUNNEL_CONNECTION_FAILED` no mesmo host que o `curl` recusa.
- **Skills do hyperframes sem rede**: `npx hyperframes skills update` falha sem `raw.githubusercontent.com`; o `setup.sh` registra as 20 skills a partir do clone em `/workspace/heygen-com/hyperframes/skills/`.
- Testar escopo de chave da ElevenLabs sem gastar crédito: chamar o endpoint com parâmetro inválido. `401 missing_permissions` = escopo ausente; `400`/`404` de validação = escopo presente.
- Trilhas/SFX: ElevenLabs `sound-generation` (`/v1/sound-generation`, máx ~22s, `duration_seconds` entre 0.5 e 30) gera beds e SFX ótimos; para trilha maior, gerar build+drop e costurar com `acrossfade`. Detecção de BPM/batidas: script próprio com numpy (fluxo de energia + autocorrelação).
- **pypi, files.pythonhosted e npm vêm em `no_proxy`** e por isso falham mesmo na allowlist; o `setup.sh` limpa `no_proxy` e aponta pip, uv e npm para o agent proxy com o CA bundle.

## Histórico de decisões

- **18/set/2026**: repo bootstrapado (infra compartilhada) e `setup.sh` consertado por PR (ffmpeg estático, rede pelo proxy, nenhum passo derruba o boot).
- **18/set/2026**: **cinto de ferramentas portado** do `profissioai-conteudo` seguindo o `PORTAR.md`: 6 scripts genéricos (zero referência de marca, conferido por grep), `validate.sh` comportamental (2 linhas de marca trocadas), `remotion/` (marca isolada em `src/marca.ts` e `src/Root.tsx`; `Aurora.tsx` e `CartaoTitulo.tsx` intocados), `.gitignore` com mp3/aac e Remotion, patch do `is_portrait_source` aposentado, `colour-science` acrescentado ao passo 5 do setup (o guia diz que o setup instala tudo, mas não instalava). Paleta do Remotion é **provisória** até a marca mandar a oficial.
- **18/set/2026**: briefing lido do Drive (reunião de 29/jul e deck "Fratezi sem jaleco"). Persona, pilares, regra de ouro da EITA, compliance e primeiras pautas gravados no `FRAMEWORK.md`. CTA padrão registrado como **hipótese**, não como decisão da marca.
- **18/set/2026**: contas verificadas. Metricool tem a marca (blog_id 6741542) **com o Instagram errado conectado** (`drajulianaromano`); Kairogen FREE sem créditos; ElevenLabs Creator com cota; OpenAI/Gemini sem chave e sem rede. Nada foi agendado.
