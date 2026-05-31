// scripts/generate-tokens.ts
// Reads tokens.ts and generates all Flutter Dart files + React globals.css
// Run with: pnpm generate:tokens
// Creates folders and files if missing, updates them if present.

import { fileURLToPath } from 'url'
import * as fs   from 'fs'
import * as path from 'path'
import { tokens } from '../packages/shared/src/tokens'


// ─────────────────────────────────────────────────────────────────────────────
// HELPERS
// ─────────────────────────────────────────────────────────────────────────────
const __filename = fileURLToPath(import.meta.url)
const __dirname  = path.dirname(__filename)

const FLUTTER_OUT = path.resolve(__dirname, '../apps/mobile/lib/core/constants')
const CSS_OUT     = path.resolve(__dirname, '../apps/web/src')
function ensureDir(dir: string): void {
  if (!fs.existsSync(dir)) {
    fs.mkdirSync(dir, { recursive: true })
    console.log(`  📁 Created directory: ${path.relative(process.cwd(), dir)}`)
  }
}

function writeFile(filePath: string, content: string): void {
  const existed = fs.existsSync(filePath)
  fs.writeFileSync(filePath, content, 'utf8')
  const rel = path.relative(process.cwd(), filePath)
  console.log(`  ${existed ? '🔄 Updated' : '✅ Created'}: ${rel}`)
}

// Convert camelCase key to SCREAMING_SNAKE_CASE for Dart constants
function toScreamingSnake(str: string): string {
  return str
    .replace(/([A-Z])/g, '_$1')
    .replace(/^_/, '')
    .toUpperCase()
}

// Convert camelCase to lowerCamelCase for Dart variable names
function toCamelCase(str: string): string {
  return str.charAt(0).toLowerCase() + str.slice(1)
}

// Map specific color names for clarity (e.g., primary → primaryCol, fire → fireCol)
function getColorKey(key: string, category?: string): string {
  const camelKey = toCamelCase(key)
  
  // Special mappings
  if (category === 'brand') {
    if (camelKey === 'primary') return 'primaryCol'
    if (camelKey === 'secondary') return 'secondaryCol'
  }
  if (category === 'alert') {
    if (camelKey === 'fire') return 'fireCol'
  }
  
  return camelKey
}

// Convert hex #rrggbb or #rrggbbaa to Flutter Color(0xFFRRGGBB)
function hexToFlutterColor(hex: string): string {
  const clean = hex.replace('#', '').toUpperCase()
  const full  = clean.length === 6 ? `FF${clean}` : clean
  return `Color(0x${full})`
}

// Convert camelCase to CSS kebab-case
function toKebabCase(str: string): string {
  return str.replace(/([A-Z])/g, '-$1').toLowerCase()
}

// Generate file header comment
function dartHeader(filename: string, source: string): string {
  return [
    '// ─────────────────────────────────────────────────────────────────────────',
    `// ${filename}`,
    '// AUTO-GENERATED — do not edit manually.',
    `// Source: ${source}`,
    `// Generated: ${new Date().toISOString()}`,
    '// Run `pnpm generate:tokens` to regenerate.',
    '// ─────────────────────────────────────────────────────────────────────────',
    '',
  ].join('\n')
}

function cssHeader(source: string): string {
  return [
    '/* ─────────────────────────────────────────────────────────────────────────',
    ' * globals.css',
    ' * AUTO-GENERATED — do not edit manually.',
    ` * Source: ${source}`,
    ` * Generated: ${new Date().toISOString()}`,
    ' * Run `pnpm generate:tokens` to regenerate.',
    ' * ─────────────────────────────────────────────────────────────────────────',
    ' */',
    '',
  ].join('\n')
}

// ─────────────────────────────────────────────────────────────────────────────
// 1. app_colors.dart
// ─────────────────────────────────────────────────────────────────────────────

function generateAppColors(): string {
  const c    = tokens.color
  const lines: string[] = []

  lines.push(dartHeader('app_colors.dart', 'packages/shared/src/tokens.ts → color'))
  lines.push("import 'package:flutter/material.dart';")
  lines.push('')
  lines.push('class AppColors {')
  lines.push('')
  lines.push('  AppColors._();')
  lines.push('')

  function writeSection(label: string, obj: Record<string, string>, category?: string): void {
    lines.push(`  // ${label}`)
    for (const [key, val] of Object.entries(obj)) {
      const dartKey = category ? getColorKey(key, category) : toCamelCase(key)
      lines.push(`  static const Color ${dartKey} = ${hexToFlutterColor(val)};`)
    }
    lines.push('')
  }

  writeSection('Brand', c.brand as unknown as Record<string, string>, 'brand')
  writeSection('Alert types', c.alert as unknown as Record<string, string>, 'alert')
  writeSection('Status', c.status as unknown as Record<string, string>)
  writeSection('Availability', c.availability as unknown as Record<string, string>)
  writeSection('Responder identity', c.responder as unknown as Record<string, string>)
  writeSection('Map', c.map as unknown as Record<string, string>)
  writeSection('Surfaces', c.surface as unknown as Record<string, string>)
  writeSection('Text', c.text as unknown as Record<string, string>)

  // Tints — nested one level deeper
  lines.push('  // Tints')
  for (const [tintName, tintVals] of Object.entries(c.tint)) {
    for (const [variant, hex] of Object.entries(tintVals as Record<string, string>)) {
      const key = toCamelCase(`tint_${tintName}_${variant}`.replace(/_([a-z])/g, (_, l) => l.toUpperCase()))
      lines.push(`  static const Color ${key} = ${hexToFlutterColor(hex)};`)
    }
  }
  lines.push('')

  // Ramps
  lines.push('  // Color ramps')
  for (const [rampName, stops] of Object.entries(c.ramp)) {
    lines.push(`  // ${rampName}`)
    for (const [stop, hex] of Object.entries(stops as Record<string, string>)) {
      const key = toCamelCase(`${rampName}${stop}`)
      lines.push(`  static const Color ${key} = ${hexToFlutterColor(hex)};`)
    }
  }
  lines.push('')
  lines.push('}')

  return lines.join('\n')
}

// ─────────────────────────────────────────────────────────────────────────────
// 2. app_typography.dart
// ─────────────────────────────────────────────────────────────────────────────

function generateAppTypography(): string {
  const t     = tokens.typography
  const lines: string[] = []

  lines.push(dartHeader('app_typography.dart', 'packages/shared/src/tokens.ts → typography'))
  lines.push("import 'package:flutter/material.dart';")
  lines.push('')
  lines.push('class AppTypography {')
  lines.push('')
  lines.push('  AppTypography._();')
  lines.push('')

  // Font sizes
  lines.push('  // Font sizes')
  for (const [key, val] of Object.entries(t.fontSize)) {
    const safeName = key.replace(/'/g, '').replace(/(\d+)xl/, 's$1xl')
    lines.push(`  static const double fontSize${safeName.charAt(0).toUpperCase() + safeName.slice(1)} = ${val};`)
  }
  lines.push('')

  // Font weights
  lines.push('  // Font weights')
  for (const [key, val] of Object.entries(t.fontWeight)) {
    lines.push(`  static const FontWeight ${key} = FontWeight.w${val};`)
  }
  lines.push('')

  // Line heights
  lines.push('  // Line heights')
  for (const [key, val] of Object.entries(t.lineHeight)) {
    lines.push(`  static const double lineHeight${key.charAt(0).toUpperCase() + key.slice(1)} = ${val};`)
  }
  lines.push('')

  // Letter spacing
  lines.push('  // Letter spacing')
  for (const [key, val] of Object.entries(t.letterSpacing)) {
    lines.push(`  static const double letterSpacing${key.charAt(0).toUpperCase() + key.slice(1)} = ${val};`)
  }
  lines.push('')

  // Preset TextStyles
  lines.push('  // Preset TextStyles')
  lines.push(`  static const TextStyle labelXs = TextStyle(fontSize: fontSize${cap('xs')}, fontWeight: regular);`)
  lines.push(`  static const TextStyle labelSm = TextStyle(fontSize: fontSize${cap('sm')}, fontWeight: regular);`)
  lines.push(`  static const TextStyle body = TextStyle(fontSize: fontSize${cap('md')}, fontWeight: regular, height: lineHeightNormal);`)
  lines.push(`  static const TextStyle bodyMedium = TextStyle(fontSize: fontSize${cap('md')}, fontWeight: medium);`)
  lines.push(`  static const TextStyle label = TextStyle(fontSize: fontSize${cap('lg')}, fontWeight: regular);`)
  lines.push(`  static const TextStyle labelMedium = TextStyle(fontSize: fontSize${cap('lg')}, fontWeight: medium);`)
  lines.push(`  static const TextStyle title = TextStyle(fontSize: fontSize${cap('xl')}, fontWeight: medium);`)
  lines.push(`  static const TextStyle sectionHeader = TextStyle(fontSize: fontSizeS2xl, fontWeight: medium);`)
  lines.push(`  static const TextStyle statValue = TextStyle(fontSize: fontSizeS4xl, fontWeight: medium);`)
  lines.push(`  static const TextStyle countdown = TextStyle(fontSize: fontSizeS5xl, fontWeight: medium);`)
  lines.push(`  static const TextStyle badgeLabel = TextStyle(fontSize: fontSize${cap('sm')}, fontWeight: medium, letterSpacing: letterSpacingWide);`)
  lines.push(`  static const TextStyle sectionTag = TextStyle(fontSize: fontSize${cap('sm')}, fontWeight: regular, letterSpacing: letterSpacingWider);`)
  lines.push('')
  lines.push('}')

  return lines.join('\n')
}

function cap(s: string): string {
  return s.charAt(0).toUpperCase() + s.slice(1)
}

// ─────────────────────────────────────────────────────────────────────────────
// 3. app_spacing.dart
// ─────────────────────────────────────────────────────────────────────────────

function generateAppSpacing(): string {
  const lines: string[] = []

  lines.push(dartHeader('app_spacing.dart', 'packages/shared/src/tokens.ts → spacing'))
  lines.push('class AppSpacing {')
  lines.push('')
  lines.push('  AppSpacing._();')
  lines.push('')
  lines.push('  // Spacing scale (logical pixels)')

  for (const [key, val] of Object.entries(tokens.spacing)) {
    const safeName = /^\d/.test(key) ? `s${key}` : key
    lines.push(`  static const double ${safeName} = ${val};`)
  }

  lines.push('')
  lines.push('}')

  return lines.join('\n')
}

// ─────────────────────────────────────────────────────────────────────────────
// 4. app_radius.dart
// ─────────────────────────────────────────────────────────────────────────────

function generateAppRadius(): string {
  const lines: string[] = []

  lines.push(dartHeader('app_radius.dart', 'packages/shared/src/tokens.ts → radius'))
  lines.push("import 'package:flutter/material.dart';")
  lines.push('')
  lines.push('class AppRadius {')
  lines.push('')
  lines.push('  AppRadius._();')
  lines.push('')
  lines.push('  // Raw values')

  const safeKey = (k: string) => k.replace(/'/g, '').replace(/(\d+)xl/, 's$1xl')

  for (const [key, val] of Object.entries(tokens.radius)) {
    lines.push(`  static const double ${safeKey(key)} = ${val};`)
  }

  lines.push('')
  lines.push('  // BorderRadius helpers')

  for (const [key] of Object.entries(tokens.radius)) {
    const sk = safeKey(key)
    lines.push(`  static final BorderRadius border${cap(sk)} = BorderRadius.circular(${sk});`)
  }

  lines.push('')
  lines.push('}')

  return lines.join('\n')
}

// ─────────────────────────────────────────────────────────────────────────────
// 5. app_sizes.dart
// ─────────────────────────────────────────────────────────────────────────────

function generateAppSizes(): string {
  const s     = tokens.size
  const lines: string[] = []

  lines.push(dartHeader('app_sizes.dart', 'packages/shared/src/tokens.ts → size'))
  lines.push('class AppSizes {')
  lines.push('')
  lines.push('  AppSizes._();')
  lines.push('')

  function writeGroup(label: string, obj: Record<string, number>, prefix: string): void {
    lines.push(`  // ${label}`)
    for (const [key, val] of Object.entries(obj)) {
      const safeK = key.replace(/'/g, '').replace(/(\d+)xl/, '$1xl')
      lines.push(`  static const double ${prefix}${cap(safeK)} = ${val};`)
    }
    lines.push('')
  }

  writeGroup('Icons',      s.icon     as Record<string, number>, 'icon')
  writeGroup('Avatars',    s.avatar   as Record<string, number>, 'avatar')
  writeGroup('Toggle',     s.toggle   as Record<string, number>, 'toggle')
  writeGroup('Map pins',   s.pin      as Record<string, number>, 'pin')
  writeGroup('Panic button', s.panic  as Record<string, number>, 'panic')
  writeGroup('Countdown',  s.countdown as Record<string, number>, 'countdown')
  writeGroup('Dashboard',  s.dashboard as Record<string, number>, 'dashboard')
  writeGroup('Borders',    s.border   as Record<string, number>, 'border')

  // Opacity (from tokens.opacity)
  lines.push('  // Opacity')
  for (const [key, val] of Object.entries(tokens.opacity)) {
    lines.push(`  static const double opacity${cap(key)} = ${val};`)
  }
  lines.push('')

  lines.push('}')

  return lines.join('\n')
}

// ─────────────────────────────────────────────────────────────────────────────
// 6. globals.css (React) — DISABLED FOR NOW (web app is empty)
// ─────────────────────────────────────────────────────────────────────────────
// The generateGlobalsCss() function has been removed to avoid parsing issues
// with template strings inside block comments. Re-enable React CSS generation
// by restoring from git history when the web app is ready.

function main(): void {
  console.log('\n🚀 S.E.A Token Generator\n')

  // Flutter output
  console.log('📱 Flutter (Dart):')
  ensureDir(FLUTTER_OUT)
  writeFile(path.join(FLUTTER_OUT, 'app_colors.dart'),     generateAppColors())
  writeFile(path.join(FLUTTER_OUT, 'app_typography.dart'), generateAppTypography())
  writeFile(path.join(FLUTTER_OUT, 'app_spacing.dart'),    generateAppSpacing())
  writeFile(path.join(FLUTTER_OUT, 'app_radius.dart'),     generateAppRadius())
  writeFile(path.join(FLUTTER_OUT, 'app_sizes.dart'),      generateAppSizes())

  // React output — DISABLED (web app is empty)
  // console.log('\n🌐 React (CSS):')
  // ensureDir(CSS_OUT)
  // writeFile(path.join(CSS_OUT, 'globals.css'), generateGlobalsCss())

  console.log('\n✨ Done. All token files are up to date.\n')
}

main()