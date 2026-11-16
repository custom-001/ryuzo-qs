import Quickshell
import Quickshell.Hyprland
import QtQuick

PanelWindow {
  id: controlOsd

  visible: false

  anchors {
    bottom: true
  }

  margins {
    bottom: 24
  }

  exclusiveZone: 0

  implicitHeight: 640
  implicitWidth: 720

  color: "transparent"

  Rectangle {
    anchors.fill: parent

    radius: 16

    color: "#1e1e2e80"

    border { width: 4; color: "#e83436"; }
  }

  Timer {
    interval: 3000

    running: controlOsd.visible && !controlOsdMouse.containsMouse
    repeat: false

    onTriggered: controlOsd.visible = false
  }

  GlobalShortcut {
    name: "controlOsd"
    description: "control popup"

    onReleased: {
      controlOsd.visible = !controlOsd.visible
    }
  }

  MouseArea {
    id: controlOsdMouse
    anchors.fill: parent
    hoverEnabled: true
  }
}
