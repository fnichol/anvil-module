#!/usr/bin/env sh
# shellcheck disable=SC3043

# shellcheck source=/dev/null
. "$ANVIL_HOOK_SUPPORT"

configure_hook_syncthing() {
  case "$ANVIL_OS" in
    arch | cachyos | debian | ubuntu)
      if ! check_cmd systemctl; then
        info "SystemD not present; skipping"
        return 0
      fi

      local svc="syncthing@${USER}.service"

      if ! systemctl is-enabled "$svc" >/dev/null; then
        info "Enabling and starting '$svc' service"
        indent as_root systemctl enable --now "$svc"
      fi
      ;;
    macos)
      local svc="syncthing"

      local loaded
      loaded="$(
        brew services info "$svc" --json \
          | jq -r --arg svc "$svc" '.[] | select(.name = $svc) | .loaded'
      )"

      if [ "$loaded" != "true" ]; then
        info "Starting '$svc' service"
        indent brew services start "$svc"
      fi
      ;;
  esac
}
