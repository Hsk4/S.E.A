// packages/shared/src/tokens.ts
// Single source of truth for all design tokens.
// React consumes this via globals.css (CSS custom properties).
// Flutter mirrors this manually in core/constants/.

export const tokens = {

  // ─────────────────────────────────────────────
  // COLOR
  // ─────────────────────────────────────────────

  color: {

    // Brand
    brand: {
      primary:         '#e24b4a',   // S.E.A red — panic button, SOS, alerts
      secondary:       '#378add',   // info blue — responder pins, police, links
      tertiary:        '#ef9f27',   // amber — helpers, timers, warnings
    },

    // Alert types
    alert: {
      medical:         '#e24b4a',
      fire:            '#ef9f27',
      crime:           '#378add',
      silent:          '#8892a4',
    },

    // Incident / responder status
    status: {
      active:          '#e24b4a',
      resolved:        '#1d9e75',
      escalated:       '#ef9f27',
      enroute:         '#378add',
      pending:         '#ef9f27',
      noResponder:     '#e24b4a',
      onScene:         '#1d9e75',
      dispatching:     '#378add',
    },

    // Availability
    availability: {
      online:          '#1d9e75',
      offline:         '#5a6580',
      busy:            '#ef9f27',
    },

    // Responder role identity colors
    responder: {
      ambulance:       '#e24b4a',
      police:          '#378add',
      fire:            '#ef9f27',
      helper:          '#ef9f27',
      admin:           '#8892a4',
      user:            '#e24b4a',
    },

    // Map pins
    map: {
      userPin:         '#e24b4a',
      responderPin:    '#378add',
      helperPin:       '#ef9f27',
      hospitalPin:     '#e24b4a',
      resolvedPin:     '#1d9e75',
      routeLine:       '#378add',
      helperRouteLine: '#ef9f27',
      gridLine:        '#378add',
    },

    // Dark surfaces
    surface: {
      base:            '#0a0d14',   // deepest background — app bg
      elevated:        '#0d1120',   // sidebar, topbar, login card
      overlay:         '#131726',   // cards, inputs, list items
      border:          '#1e2433',   // default border
      borderStrong:    '#2a2f3e',   // hover / active border
    },

    // Alert type tinted surfaces (strips, chips, badges)
    tint: {
      red: {
        bg:            '#1a0f0f',
        border:        '#3a1a1a',
      },
      amber: {
        bg:            '#1a1505',
        border:        '#3a2a05',
      },
      blue: {
        bg:            '#0a1520',
        border:        '#185fa5',
      },
      green: {
        bg:            '#081a10',
        border:        '#0f4a28',
      },
    },

    // Text hierarchy
    text: {
      primary:         '#e8ecf4',   // headings, values, labels
      secondary:       '#8892a4',   // descriptions, subtitles
      muted:           '#5a6580',   // hints, timestamps, placeholders
      disabled:        '#4a5068',   // disabled states
    },

    // Full color ramps (7 stops each — for flexibility)
    ramp: {
      red: {
        50:            '#fcebeb',
        100:           '#f7c1c1',
        200:           '#f09595',
        400:           '#e24b4a',
        600:           '#a32d2d',
        800:           '#791f1f',
        900:           '#501313',
      },
      blue: {
        50:            '#e6f1fb',
        100:           '#b5d4f4',
        200:           '#85b7eb',
        400:           '#378add',
        600:           '#185fa5',
        800:           '#0c447c',
        900:           '#042c53',
      },
      amber: {
        50:            '#fdf3e3',
        100:           '#fac775',
        200:           '#f4b340',
        400:           '#ef9f27',
        600:           '#ba7517',
        800:           '#854f0b',
        900:           '#412402',
      },
      green: {
        50:            '#e1f5ee',
        100:           '#9fe1cb',
        200:           '#5dcaa5',
        400:           '#1d9e75',
        600:           '#0f6e56',
        800:           '#085041',
        900:           '#04342c',
      },
      gray: {
        50:            '#e8ecf4',
        100:           '#c8ccde',
        200:           '#8892a4',
        400:           '#6b7394',
        600:           '#5a6580',
        800:           '#4a5068',
        900:           '#2a2f3e',
      },
      navy: {
        50:            '#1e2433',
        100:           '#131726',
        200:           '#0d1120',
        400:           '#0a0d14',
        600:           '#07090f',
        800:           '#04060a',
        900:           '#020305',
      },
    },

  },

  // ─────────────────────────────────────────────
  // TYPOGRAPHY
  // ─────────────────────────────────────────────

  typography: {

    fontFamily: {
      sans:            'Inter, system-ui, -apple-system, sans-serif',
      mono:            'JetBrains Mono, Fira Code, monospace',
      // Flutter equivalent: GoogleFonts.inter() / GoogleFonts.jetBrainsMono()
    },

    fontSize: {
      xs:              8,    // px — tiny labels, map pin labels
      sm:              9,    // px — hints, timestamps, badges
      base:            10,   // px — secondary labels
      md:              11,   // px — body text, descriptions
      lg:              12,   // px — standard UI text
      xl:              13,   // px — titles, nav items
      '2xl':           15,   // px — section headers
      '3xl':           16,   // px — card values, ETA numbers
      '4xl':           20,   // px — stat values
      '5xl':           26,   // px — countdown numbers
      '6xl':           32,   // px — large display numbers
    },

    fontWeight: {
      regular:         400,
      medium:          500,
      // No bold/heavy in this design — medium is the max weight used
    },

    lineHeight: {
      tight:           1.3,
      normal:          1.5,
      relaxed:         1.7,
    },

    letterSpacing: {
      tight:           -0.2,  // px
      normal:          0,     // px
      wide:            0.5,   // px — nav items, badge labels
      wider:           0.8,   // px — uppercase section labels
    },

  },

  // ─────────────────────────────────────────────
  // SPACING
  // ─────────────────────────────────────────────

  spacing: {
    0:                 0,
    1:                 4,    // px
    2:                 6,    // px
    3:                 8,    // px
    4:                 10,   // px
    5:                 12,   // px
    6:                 14,   // px
    7:                 16,   // px
    8:                 20,   // px
    9:                 24,   // px
    10:                28,   // px
    11:                32,   // px
    12:                40,   // px
  },

  // ─────────────────────────────────────────────
  // BORDER RADIUS
  // ─────────────────────────────────────────────

  radius: {
    sm:                4,    // px — badges, chips, small elements
    md:                6,    // px — buttons, inputs, small cards
    lg:                8,    // px — standard cards, list items
    xl:                10,   // px — map containers, larger cards
    '2xl':             12,   // px — login card, modals
    '3xl':             16,   // px — phone mockup corners
    full:              9999, // px — pills, toggles, dots
  },

  // ─────────────────────────────────────────────
  // COMPONENT SIZES
  // ─────────────────────────────────────────────

  size: {

    // Icons
    icon: {
      xs:              11,   // px
      sm:              13,   // px
      md:              15,   // px
      lg:              16,   // px
      xl:              18,   // px
      '2xl':           22,   // px
      '3xl':           26,   // px
    },

    // Avatars
    avatar: {
      sm:              20,   // px
      md:              24,   // px
      lg:              28,   // px
      xl:              32,   // px
      '2xl':           44,   // px — login logo icon
    },

    // Availability toggle
    toggle: {
      width:           32,   // px
      height:          18,   // px
      thumb:           14,   // px
    },

    // Map pins
    pin: {
      sm:              8,    // px
      md:              10,   // px
      lg:              12,   // px
      xl:              14,   // px
    },

    // Panic button (User home screen)
    panic: {
      ring:            100,  // px — outer ring diameter
      button:          82,   // px — inner button diameter
    },

    // Countdown ring (Cancellation screen)
    countdown: {
      ring:            70,   // px
    },

    // Web dashboard layout
    dashboard: {
      sidebarWidth:    180,  // px
      topbarHeight:    44,   // px
    },

    // Border widths
    border: {
      thin:            0.5,  // px — used everywhere
      standard:        1.5,  // px — phone frame border
    },

  },

  // ─────────────────────────────────────────────
  // ANIMATION
  // ─────────────────────────────────────────────

  animation: {

    duration: {
      fast:            100,  // ms — hover states, toggles
      normal:          150,  // ms — transitions, nav items
      slow:            300,  // ms — modals, screen transitions
    },

    easing: {
      default:         'ease',
      in:              'ease-in',
      out:             'ease-out',
      inOut:           'ease-in-out',
    },

  },

  // ─────────────────────────────────────────────
  // Z-INDEX
  // ─────────────────────────────────────────────

  zIndex: {
    base:              0,
    overlay:           10,   // map overlays, pin labels
    modal:             20,   // alert modals, cancellation screen
    toast:             30,   // push notification banners
    top:               40,   // SOS active bar, critical alerts
  },

  // ─────────────────────────────────────────────
  // OPACITY
  // ─────────────────────────────────────────────

  opacity: {
    mapGrid:           0.08,  // grid lines on map backgrounds
    routeLine:         0.70,  // route line on live map
    disabled:          0.40,  // disabled UI elements
  },

} as const

// ─────────────────────────────────────────────
// TYPE EXPORTS
// ─────────────────────────────────────────────

export type Tokens          = typeof tokens
export type ColorTokens     = typeof tokens.color
export type TypographyTokens= typeof tokens.typography
export type SpacingTokens   = typeof tokens.spacing
export type RadiusTokens    = typeof tokens.radius
export type SizeTokens      = typeof tokens.size

// ─────────────────────────────────────────────
// FLAT HELPERS
// For libraries that expect flat key-value maps
// ─────────────────────────────────────────────

export const colorFlat = {
  primary:             tokens.color.brand.primary,
  secondary:           tokens.color.brand.secondary,
  tertiary:            tokens.color.brand.tertiary,
  surfaceBase:         tokens.color.surface.base,
  surfaceElevated:     tokens.color.surface.elevated,
  surfaceOverlay:      tokens.color.surface.overlay,
  border:              tokens.color.surface.border,
  borderStrong:        tokens.color.surface.borderStrong,
  textPrimary:         tokens.color.text.primary,
  textSecondary:       tokens.color.text.secondary,
  textMuted:           tokens.color.text.muted,
  textDisabled:        tokens.color.text.disabled,
  online:              tokens.color.availability.online,
  offline:             tokens.color.availability.offline,
  busy:                tokens.color.availability.busy,
} as const