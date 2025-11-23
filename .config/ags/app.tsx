import app from "ags/gtk4/app"
import style from "./style.scss"
import Bar from "./widgets/Bar/Bar"
import NotificationPopups from "./widgets/Notification/NotificationPopups"

app.start({
  css: style,
  gtkTheme: "adw-gtk3-dark",
  main() {
    // Create bar on each monitor
    app.get_monitors().map(Bar)
    
    // Create notification popups
    NotificationPopups()
  },
})

