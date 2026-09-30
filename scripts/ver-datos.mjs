/**
 * Comprueba que los datos del caso se leen bien.
 *
 *   npm run datos
 *
 * No hace falta entenderlo: sirve para ver que `npm install` ha funcionado
 * y que los CSV del caso están donde tienen que estar.
 */
import { readFileSync } from "node:fs";
import { parse } from "csv-parse/sync";

const leer = (f) => parse(readFileSync(f, "utf8"), { columns: true, skip_empty_lines: true });

const empresas = leer("assets/seed/empresas.csv");
const facturas = leer("assets/seed/facturas.csv");

console.log(`\n  ${empresas.length} empresas · ${facturas.length} facturas de 2025\n`);

const porSector = {};
for (const e of empresas) porSector[e.sector] = (porSector[e.sector] ?? 0) + 1;
for (const [sector, n] of Object.entries(porSector).sort((a, b) => b[1] - a[1])) {
  console.log(`  ${String(n).padStart(2)}  ${sector}`);
}

// Cuántas empresas se quedan solas si comparamos por CNAE + comunidad
const grupos = {};
for (const e of empresas) {
  const clave = `${e.cnae}|${e.comunidad_autonoma}`;
  grupos[clave] = (grupos[clave] ?? 0) + 1;
}
const solas = Object.values(grupos).filter((n) => n === 1).length;
console.log(`\n  ${solas} empresas se quedan solas en su grupo si comparamos`);
console.log(`  por CNAE + comunidad autónoma. Guárdelo: sale en el Módulo 2.\n`);
