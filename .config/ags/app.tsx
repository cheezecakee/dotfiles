import app from "ags/gtk4/app"
import NotificationPopups from "./widget/Notification/NotificationPopups"
import style from "./widget/Notification/style.scss"

app.start({
  css: style,
  gtkTheme: "adw-gtk3-dark",
  main() {
    NotificationPopups()
  },
})
