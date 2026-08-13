import { Controller } from "@hotwired/stimulus"

// Controls the app sidebar (#app-sidebar): desktop collapse/expand and the
// mobile slide-in drawer + backdrop. Any element wired with
// data-controller="sidebar" can trigger these actions — the sidebar is a
// per-page singleton, so lookups go through the DOM rather than Targets,
// letting the toggle button, backdrop, and an out-of-tree mobile trigger
// (see _base_layout.html.erb) all share the same instance.
export default class extends Controller {
  toggle() {
    if (this.isMobile()) {
      this.closeMobile()
      return
    }

    const sidebar = this.sidebar()
    if (!sidebar) return

    const layout = sidebar.closest("[data-type='sidebar-layout']")
    const collapsed = sidebar.getAttribute("data-collapsed") === "true"
    sidebar.setAttribute("data-collapsed", String(!collapsed))
    if (layout) layout.setAttribute("data-collapsed", String(!collapsed))
  }

  openMobile() {
    const sidebar = this.sidebar()
    if (!sidebar) return

    sidebar.setAttribute("data-open", "true")
    const backdrop = this.backdrop()
    if (backdrop) backdrop.setAttribute("data-visible", "true")
  }

  closeMobile() {
    const sidebar = this.sidebar()
    if (!sidebar) return

    sidebar.setAttribute("data-open", "false")
    const backdrop = this.backdrop()
    if (backdrop) backdrop.setAttribute("data-visible", "false")
  }

  sidebar() {
    return document.getElementById("app-sidebar")
  }

  backdrop() {
    return document.querySelector('[data-slot="sidebar-backdrop"]')
  }

  isMobile() {
    return window.innerWidth < 768
  }
}
