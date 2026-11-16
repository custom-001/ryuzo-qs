import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick

PanelWindow {
  id: volOsd

  property bool isVolumeUpPressed: false
  property bool isVolumeDownPressed: false

  property double volValue: 0

  visible: isVolumeUpPressed || isVolumeDownPressed

  anchors {
    top: true
    left: true
  }

  margins {
    top: 24
    left: 24
  }

  exclusiveZone: 0

  implicitHeight: 320
  implicitWidth: 160

  color: "transparent"

  Rectangle {
    anchors.fill: parent

    radius: 16

    color: "#1e1e2e80"

    border { width: 4; color: "#e83437"; }

    Text {
      anchors {
          left: parent.left
          verticalCenter: parent.verticalCenter
          leftMargin: 32
      }

      text: ""

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
        height: parent.height * volOsd.volValue

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
    id: hideTimer

    interval: 3000

    running: volOsd.visible
    repeat: false

    onTriggered: {
      volOsd.isVolumeDownPressed = false
      volOsd.isVolumeUpPressed = false
    }
  }

  GlobalShortcut {
    name: "volumeDownOsd"
    description: "lowers volume"

    onPressed: {
      volOsd.isVolumeDownPressed = true
      hideTimer.restart()
      volDownProc.running = true
    }
  }

  GlobalShortcut {
    name: "volumeUpOsd"
    description: "raises volume"

    onPressed: {
      volOsd.isVolumeUpPressed = true
      hideTimer.restart()
      volUpProc.running = true
    }
  }

  Process {
    id: volDownProc

    command: [ "wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "10%-" ]

    onExited: getVolProc.running = true
  }

  Process {
    id: volUpProc

    command: [ "wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "10%+" ]

    onExited: getVolProc.running = true
  }

  Process {
    id: getVolProc

    command: [ "wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@" ]

    stdout: StdioCollector {
      onStreamFinished: {
        let value = parseFloat(this.text.replace("Volume: ", "").trim())
        volOsd.volValue = value
        console.log(`volume value: ${value}`)
      }
    }
  }
}
