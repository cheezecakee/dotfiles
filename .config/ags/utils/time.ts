import GLib from "gi://GLib"

export function formatTime(format: string = "%I:%M %p"): string {
  return GLib.DateTime.new_now_local().format(format) || ""
}

export function formatDate(format: string = "%a %d"): string {
  return GLib.DateTime.new_now_local().format(format) || ""
}

export function formatDateTime(format: string = "%a %d, %I:%M %p"): string {
  return GLib.DateTime.new_now_local().format(format) || ""
}
