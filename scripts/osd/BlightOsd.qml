import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick

PanelWindow {
	id: blightOsd

	property bool isBlightUp: false
	property bool isBlightDown: false

	property double blightValue: 0

	visible: isBlightUp || isBlightDown

  anchors {
    left: true
    bottom: true
  }

  margins {
    left: 24
    bottom: 24
  }

  exclusiveZone: 0

  implicitHeight: 320
  implicitWidth: 160

  color: "transparent"

  Rectangle {
    anchors.fill: parent

    radius: 16

    color: "#1e1e2e80"

    border { width: 4; color: "#e83436"; }

    Text {
      anchors {
          left: parent.left
          verticalCenter: parent.verticalCenter
          leftMargin: 32
      }

      text: "󰃠"

      color: "#cdd6f4"

      font { family: "Iosevka Nerd Font"; pixelSize: 51; }
    }

    Rectangle {
      anchors {
        right: parent.right
        verticalCenter: parent.verticalCenter
        rightMargin: 16
      }

      width: 32
      height: parent.height - 32

      radius: 9999

      color: "#313244"
      Rectangle {
        anchors {
          bottom: parent.bottom
          horizontalCenter: parent.horizontalCenter
        }

        width: parent.width
        height: parent.height * blightOsd.blightValue

        radius: 9999

        color: "#cdd6f4"

        Behavior on height {
          NumberAnimation {
            duration: 250
            easing.type: Easing.OutBack
          }
        }
      }
    }
  }

  Timer {
    id: hideTimer0

    interval: 3000

    running: blightOsd.visible
    repeat: false

    onTriggered: {
      blightOsd.isBlightDown = false
      blightOsd.isBlightUp = false
    }
  }

  GlobalShortcut {
    name: "blightDownOsd"
    description: "lower brightness"

    onPressed: {
      blightOsd.isBlightDown = true
      hideTimer0.restart()
      blightDownProc.running = true
    }
  }

  GlobalShortcut {
    name: "blightUpOsd"
    description: "raises brightness"

    onPressed: {
      blightOsd.isBlightUp = true
      hideTimer0.restart()
      blightUpProc.running = true
    }
  }

  Process {
    id: blightDownProc

    command: [ "brightnessctl", "set", "10%-" ]

    onExited: getBlightProc.running = true
  }

  Process {
    id: blightUpProc

    command: [ "brightnessctl", "set", "10%+" ]

    onExited: getBlightProc.running = true
  }

  Process {
    id: getBlightProc

    command: [ "brightnessctl", "get" ]

    stdout: StdioCollector {
      onStreamFinished: {
        let value = parseFloat(this.text) / 1500
        blightOsd.blightValue = value
        console.log(`brightness value: ${value}`)
      }
    }
  }
}
