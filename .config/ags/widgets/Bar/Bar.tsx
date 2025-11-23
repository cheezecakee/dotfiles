import app from "ags/gtk4/app"
import { Astal, Gdk, Gtk } from "ags/gtk4"

export default function Bar(gdkmonitor: Gdk.Monitor) {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

  return (
    <window
      visible
      name={`bar-${gdkmonitor.get_model()}`}
      cssClasses={["Bar"]}
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
      application={app}
      marginTop={5}
      marginLeft={5}
      marginRight={5}
    >
      <centerbox cssClasses={["bar-container"]}>
        {/* Left section */}
        <box $type="start" hexpand halign={Gtk.Align.START} spacing={10}>
          {/* DateTime, Weather, Mpris modules go here */}
          <label label="Left Section" />
        </box>

        {/* Center section */}
        <box $type="center">
          {/* Workspaces module goes here */}
          <label label="Center - Workspaces" />
        </box>

        {/* Right section */}
        <box $type="end" hexpand halign={Gtk.Align.END} spacing={10}>
          {/* Volume, Network, Power modules go here */}
          <label label="Right Section" />
        </box>
      </centerbox>
    </window>
  )
}

