/**
 * Paleta e tokens do Dr. Juliano Fratezi Conteúdo Studio.
 *
 * PROVISÓRIA (18/set/2026): a paleta oficial da marca ainda não foi confirmada.
 * Instagram, site (drjulianofratezi.com.br) e o logo no CDN do Metricool estão
 * fora da allowlist deste environment, então não deu para medir nada. Trocar os
 * hexes quando a marca chegar; nada mais precisa mudar.
 *
 * Os NOMES dos tokens são herdados do template de propósito: Aurora.tsx e
 * CartaoTitulo.tsx leem por esses nomes e não são editados no porte.
 *   rosaVivo   = acento principal (a palavra em destaque do título)
 *   rosa       = acento escuro     rosaSuave = acento claro
 *   violeta / ciano = as outras duas manchas da aurora
 *   auroraBase = fundo claro       tinta     = cor do texto
 */
export const marca = {
  rosaVivo: "#E8792B",
  rosa: "#C4621F",
  rosaSuave: "#F2A65A",
  violeta: "#2B3A4A",
  ciano: "#4F7CAC",
  azulNeon: "#8FB8DE",
  azulProfundo: "#1B2530",
  fundoEscuro: "#0E1216",
  superficie: "#1B2530",
  auroraBase: "#F4F1EC",
  tinta: "#141A20",
  /** Lettering da casa é condensado bold; sem rede no render, cai para a sans do sistema. */
  fonte: '"Helvetica Neue Condensed Black", "Inter Tight", "Liberation Sans", system-ui, -apple-system, sans-serif',
} as const;
