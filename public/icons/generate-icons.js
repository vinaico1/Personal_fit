// Script para gerar ícones PNG a partir do SVG usando sharp
// Execute: node generate-icons.js (requer sharp instalado)
// Ou use qualquer gerador de PWA icons online (ex: https://realfavicongenerator.net)

// O SVG base do ícone FitLife
const svg = `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
  <rect width="512" height="512" rx="100" fill="#0f172a"/>
  <rect width="512" height="512" rx="100" fill="url(#grad)"/>
  <defs>
    <linearGradient id="grad" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" style="stop-color:#10b981"/>
      <stop offset="100%" style="stop-color:#059669"/>
    </linearGradient>
  </defs>
  <text x="256" y="320" font-family="system-ui" font-size="240" font-weight="900" fill="white" text-anchor="middle">F</text>
</svg>`;

console.log("Coloque este SVG em icon.svg e converta para PNG nos tamanhos necessários.");
console.log("Tamanhos: 72, 96, 128, 144, 192, 384, 512");
