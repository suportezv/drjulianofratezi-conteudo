# Vendor (dependências de runtime servidas localmente)

- `gsap.min.js`: GSAP 3.14.2 (`gsap-VERSION.txt`), copiado de `node_modules/gsap/dist/` após `npm install gsap@3.14.2` pelo `registry.npmjs.org`. Motivo: `cdn.jsdelivr.net` está fora da allowlist deste environment e o render do HyperFrames barra quando o script do CDN não carrega. Licença: GSAP é gratuito para uso comercial desde a 3.13 (gsap.com/licensing). O wrapper `scripts/hf` copia este arquivo para `assets/vendor/` de cada projeto novo e troca o `<script>` do CDN pelo local.
