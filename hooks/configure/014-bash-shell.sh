#!/usr/bin/env sh
# shellcheck disable=SC3043

# shellcheck source=/dev/null
. "$ANVIL_HOOK_SUPPORT"

configure_hook_bash_shell() {
  case "$ANVIL_OS" in
    alpine | openbsd)
      local current_shell
      current_shell="$(getent passwd "$USER" | cut -d: -f 7)"

      local bash_shell
      bash_shell="$(command -v bash)"

      if [ "$current_shell" != "$bash_shell" ]; then
        info "Setting default shell for '$USER' to '$bash_shell'"
        chpass -s "$bash_shell"
      fi
      ;;
    macos)
      local current_shell
      current_shell="$(
        dscacheutil -q user -a name "$USER" \
          | grep ^shell: \
          | cut -d' ' -f 2
      )"

      local bash_shell
      bash_shell="$(brew --prefix)/bin/bash"

      if ! grep -q "^${bash_shell}$" /etc/shells; then
        info "Adding '$bash_shell' to /etc/shells"
        echo "$bash_shell" | as_root tee -a /etc/shells >/dev/null
      fi

      if [ "$current_shell" != "$bash_shell" ]; then
        info "Setting default shell for '$USER' to '$bash_shell'"
        chpass -s "$bash_shell"
      fi
      ;;
  esac
}
