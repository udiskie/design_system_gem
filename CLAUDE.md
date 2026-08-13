# CLAUDE.md — Design System Gem

## Project overview

Ruby gem with a Rails dummy app for developing and previewing UI
components. Components are plain ERB partials. Lookbook is the preview
harness. No React, no asset pipeline other than Propshaft and a
standalone Tailwind v4 binary. Stimulus is used sparingly — only where
CSP (`script-src-attr`) rules out an inline `onclick=""` attribute; see
`app/javascript/controllers/sidebar_controller.js`.

---

## Dev server

```
bin/rails server          # starts on port 4000
```

`localhost:4000` redirects to `localhost:4000/lookbook`.

---

## Using this gem in a host app

Add to the host app's `application.html.erb` layout, **before** its own
`stylesheet_link_tag :app`:

```erb
<%= stylesheet_link_tag "design_system_gem", "data-turbo-track": "reload" %>
```

This single file includes the Manrope `@font-face` declarations, all theme
variables, and all component styles. No `config.assets.paths` change is
needed in the host app.

### CSP compatibility

All component JS (inline `<script>` tags and `ui/sidebar`'s Stimulus
controller) is written to work under a strict nonce-based CSP — the stock
output of `rails new` (`script-src` with a per-request nonce, no
`unsafe-inline`). No host-app config is required for this to work,
**except** for `ui/sidebar`, which needs its Stimulus controller loaded
via importmap. Add this pin to the host app's own `config/importmap.rb`:

```ruby
pin_all_from Gem::Specification.find_by_name("design_system_gem").gem_dir + "/app/javascript/controllers",
  under: "controllers"
```

(The gem's own `config/` isn't packaged, so this pin has to live in the
host app rather than being auto-registered by the engine.)

---

## Design system first

When writing views (in this gem or a host app), **always reach for a DS
component before writing custom HTML or CSS**. Only fall back to a scoped
`<style>` block or inline `style=""` for layout that no component covers.
Never recreate button, input, card, or badge styling from scratch.

---

## UI component quick reference

| Partial | Key locals | Notes |
|---|---|---|
| `ui/card` | — (block) | Wraps any content in a bordered card |
| `ui/heading` | `text:`, `level: 1`, `size: nil` | Renders `h1`–`h6` |
| `ui/paragraph` | — | Renders a `<p>` |
| `ui/input` | `type: "text"`, `name: nil`, `placeholder: ""`, `size: "md"`, `disabled: false`, `invalid: false`, `value: nil` | Does **not** integrate with Rails form builder — pass `name:` manually |
| `ui/button` | `text:`, `variant: "primary"`, `size: "md"`, `disabled: false`, `icon: nil` | Does **not** accept a `type:` local — for submit buttons, use a raw `<button>` tag (see below) |
| `ui/field` | `label:`, `value: nil` (or block) | Display-only label+value pair, not a form field |
| `ui/badge` | `text:`, `variant:`, `size:` | |
| `ui/select` | | |
| `ui/checkbox` | | |

### Submit buttons in forms

`render "ui/button"` cannot render `type="submit"`. Use the raw tag instead
— the DS CSS targets `button[variant]` so it is styled identically:

```erb
<button variant="primary" size="md" type="submit">Sign up</button>
```

### One-off layout in host app views

Host apps do not have Tailwind compiled, so utility classes added in host
views will have no effect. Use a scoped `<style>` block with DS CSS
variables for any layout not covered by a component:

```erb
<style>
  body { background-color: var(--color-muted); }
  .my-wrapper { max-width: 400px; margin: auto; }
</style>
```

Available theme variables: `--color-background`, `--color-foreground`,
`--color-primary`, `--color-muted`, `--color-muted-foreground`,
`--color-border`, `--color-card`, `--color-destructive`.

---

## Tailwind CSS — rebuild after adding new classes

| File | Purpose |
|---|---|
| `app/assets/tailwind/application.css` | source — edit here |
| `app/assets/builds/design_system_gem.css` | compiled output — served in browser |

Rebuild command:
```
tailwindcss -i app/assets/tailwind/application.css \
            -o app/assets/builds/design_system_gem.css
```

Run this every time you:
- Add a new Tailwind utility class to any template or partial
- Add new `@layer components` rules to `application.css`
- Create a new partial or preview file that uses classes not used elsewhere

Tailwind v4 only emits classes it finds in scanned files. If a class
looks correct but has no visible effect, the compiled output is stale —
rebuild before debugging further.

Do not use `bin/rails tailwindcss:build` — that task does not exist.
The binary is the standalone CLI at
`~/.local/share/mise/installs/ruby/.../bin/tailwindcss`.

---

## File locations

| Purpose | Path |
|---|---|
| Reusable partials | `app/views/ui/landing_page_components/_*.html.erb` |
| Landing page preview templates | `app/views/ui/previews/landing_page_views/*.html.erb` |
| Lookbook preview classes | `test/components/previews/landing_page_views/*_preview.rb` |
| Lookbook layout | `app/views/layouts/lookbook.html.erb` |
| Landing page layout | `app/views/layouts/landings/home/marketing.html.erb` |

---

## Creating a component partial

1. Create `app/views/ui/landing_page_components/_my_component.html.erb`.
2. Declare locals at the top using their natural HTML attribute names:
   ```erb
   <%# locals: (title:, id: nil) %>
   ```
3. Render it:
   ```erb
   <%= render "ui/landing_page_components/my_component",
         title: "Hello",
         id:    "my-section" %>
   ```
4. Rebuild Tailwind if new classes were introduced.

---

## Creating a Lookbook preview

**Preview class** — `test/components/previews/landing_page_views/my_page_preview.rb`:
```ruby
class LandingPageViews::MyPagePreview < Lookbook::Preview
  layout "landings/home/marketing"

  # @label Default
  def default
    render template: "ui/previews/landing_page_views/my_page"
  end
end
```

**Preview template** — `app/views/ui/previews/landing_page_views/my_page.html.erb`:
```erb
<%= render "ui/landing_page_components/navbar" %>
<main class="flex-1 relative">
  <%# ...sections... %>
</main>
<%= render "ui/landing_page_components/footer" %>
```

Preview URL: `/lookbook/inspect/landing_page_views/my_page/default`

---

## HTML id attributes

- Name locals that map to HTML `id` attributes simply as `id:`, not
  `section_id:` or any other alias. Match the HTML attribute name exactly.
- **Every `id` value in the final rendered page must be unique.** When a
  partial is rendered more than once on the same page, the caller must
  pass distinct `id:` values — the partial must never hard-code one.
- Enforce this in code review: search for duplicated `id=` values
  whenever a partial is rendered multiple times.

Example — `_solutions_section.html.erb` is rendered twice, so the
caller supplies different ids:
```erb
<%= render "ui/landing_page_components/solutions_section",
      ..., id: "solutions-farming" %>

<%= render "ui/landing_page_components/solutions_section",
      ..., id: "solutions-finance" %>
```

---

## CSS specificity — text colour inside themed sections

`application.css` sets `text-foreground` directly on `h1`–`h6` and `p`
inside `@layer base`. This overrides **inherited** colour, so
`text-white` on a parent has no effect on headings and paragraphs.

Fix: add `style="color: white;"` directly on each element, or add the
utility class directly on the element (not an ancestor). Utility classes
beat `@layer base` in the Tailwind cascade only when applied to the
element itself.

---

## Do not change the global CSS

Do not edit `application.css` to fix a one-off colour or layout issue
in a specific component. Use:
- Inline `style=""` attributes on the element
- A `<style>` block scoped inside the partial

---

## overflow and box-shadow clipping

- `overflow: hidden` clips box-shadows. Use it only when vertical
  clipping is intentional (e.g. a `rounded-2xl` card wrapper).
- For a slider track that must hide horizontal overflow while preserving
  vertical shadows, use `overflow-x: clip` — it does not create a scroll
  container and does not force `overflow-y` to `auto`.

---

## JS component pattern

```html
<div data-component="my-widget">
  <button data-slot="my-widget-trigger">…</button>
  <div data-slot="my-widget-content" data-state="closed">…</div>
</div>

<%= javascript_tag nonce: true do %>
  (function () {
    if (window.__myWidgetSetup) return;   // safe to include multiple times
    window.__myWidgetSetup = true;

    document.addEventListener('click', function (e) {
      var trigger = e.target.closest('[data-slot="my-widget-trigger"]');
      if (!trigger) return;
      var widget = trigger.closest('[data-component="my-widget"]');
      // mutate widget.dataset.state, etc.
    });
  })();
<% end %>
```

Rules:
- Guard with `window.__<name>Setup` — Lookbook reloads pages frequently.
- Use event delegation on `document`, not per-element listeners.
- Store state in `data-*` attributes (`data-state`, `data-current`, …).
- Never use `id` inside JS selectors inside a component script — use
  `data-slot` selectors scoped to the nearest `data-component` ancestor
  so multiple instances on the same page work independently.
- **Always wrap the tag as `<%= javascript_tag nonce: true do %> ... <% end
  %>`, never a bare `<script>` tag.** Lookbook disables CSP entirely
  (`content_security_policy(false)`), so a bare `<script>` tag still runs
  there — but a host app with the default Rails nonce-based CSP will
  silently block it. `nonce: true` is a no-op when no CSP nonce is
  configured (e.g. in this dummy app), so it's always safe to use.
- **Never use an inline `onclick="..."` attribute.** A nonce can't make an
  event-handler attribute CSP-safe (`script-src-attr` has no per-element
  nonce escape hatch). If a click needs to reach across elements that
  aren't in the same component subtree (e.g. a page header button that
  opens the sidebar), use a small Stimulus controller instead — see
  `app/javascript/controllers/sidebar_controller.js` and its
  `data-controller="sidebar" data-action="click->sidebar#toggle"` wiring
  in `_sidebar.html.erb` / `_base_layout.html.erb`.

---

## Navbar scroll behaviour

The navbar starts transparent and turns white once the user scrolls
past the hero section. The listener is already wired in `_navbar.html.erb`.
Do not add a second scroll listener — edit the existing one.

---

## Insights slider behaviour

`_insights_section.html.erb` contains a self-contained JS slider.

- **Desktop (≥ 640 px):** peek mode — center item at 50 % width,
  adjacent items at 25 % width with 0.5 opacity.
- **Mobile (< 640 px):** single-item mode — item fills 100 % width,
  no peek, all items at full opacity.
- Item widths are set in **pixels** from `clientWidth`, never
  percentages, to avoid flex-container resolution ambiguity.
- A `resize` listener re-initialises the active slide instantly.

---

## Component inventory

| Partial | Key locals |
|---|---|
| `_navbar` | — |
| `_hero` | — (home hero, hardcoded) |
| `_inner_page_hero` | `title`, `description`, `cta_text`, `cta_url`, `image_src`, `image_alt` |
| `_solutions_section` | `title`, `subtitle_texts`, `cards`, `reversed`, `id` |
| `_solution_card` | `icon_paths`, `title`, `description`, `url` |
| `_insights_section` | — (hardcoded data) |
| `_insight_card` | `image_src`, `image_alt`, `title`, `description`, `url` |
| `_custom_data_section` | — |
| `_contact_section` | — |
| `_partners_marquee` | — (hardcoded logos) |
| `_footer` | — |
