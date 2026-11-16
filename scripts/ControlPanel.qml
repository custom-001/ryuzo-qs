import Quickshell
import QtQuick

import "modules"

PanelWindow {
  id: controlPanel

  anchors {
    top: true
    left: true
    right: true
  }

  margins {
    top: 16
    left: 24
    right: 24
  }

  implicitHeight: 48

  color: "transparent"

  Rectangle {
    anchors.fill: parent

    radius: 9999

    color: "#1e1e2e80"

    border {
      width: 4
      color: "#e83436"
    }

    Row {
      anchors.centerIn: parent

      Clock {}
    }

    Row {
      anchors {
        right: parent.right
        verticalCenter: parent.verticalCenter
        rightMargin: 24
      }

      spacing: 16

      Vol {}

      Blight {}
    }
  }
}
