#!/usr/bin/env sh
# shellcheck disable=SC3043

# shellcheck source=/dev/null
. "$ANVIL_HOOK_SUPPORT"

configure_hook_openbsd_locale() {
  case "$ANVIL_OS" in
    openbsd)
      local locale="en_CA.UTF-8"

      local profile
      for profile in "$HOME/.profile" "$HOME/.bash_profile"; do
        if [ ! -r "$profile" ] || ! grep -q "^export LANG=" "$profile"; then
          info "Setting locale to '$locale' in $profile"
          echo "export LANG=$locale" >>"$profile"
        fi
      done
      ;;
  esac
}
