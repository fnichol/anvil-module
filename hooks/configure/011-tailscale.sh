#!/usr/bin/env sh
# shellcheck disable=SC3043

# shellcheck source=/dev/null
. "$ANVIL_HOOK_SUPPORT"

configure_hook_tailscale() {
  case "$ANVIL_OS" in
    arch | cachyos | debian | ubuntu)
      if ! check_cmd systemctl; then
        info "SystemD not present; skipping"
        return 0
      fi

      local unit svc bu
      svc="tailscaled.service"
      unit="$svc"
      bu="/home/linuxbrew/.linuxbrew/opt/tailscale/homebrew.tailscale.service"

      # Check if Tailscale is installed via Homebrew
      if [ -f "$bu" ]; then
        svc="$(basename "$bu")"
        unit="$bu"
      fi

      if ! systemctl is-enabled "$svc" >/dev/null; then
        info "Enabling and starting '$svc' service"
        indent as_root systemctl enable --now "$unit"
      fi
      ;;
    openbsd)
      local svc=tailscaled

      if ! rcctl get "$svc" status; then
        info "Enabling and starting '$svc' service"
        indent as_root rcctl enable "$svc"
        indent as_root rcctl start "$svc"
      fi
      ;;
  esac
}
