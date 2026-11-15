import Quickshell
import Quickshell.Io
import QtQuick

Text {
  id: blight

  text: "B"

  color: "#cdd6f4"

  font {
    family: "Iosevka Nerd Font"
    pixelSize: 24
    bold: true
  }

  Process {
    id: blightProc

    command: [ "brightnessctl", "get" ]

    running: true

    stdout: StdioCollector {
      property real brightness: parseFloat(this.text)

      onStreamFinished: {
        blight.text =
          brightness === 1500 ? "󰃠" :
          brightness  >  1000 ? "󰃞" :
          brightness  >  500  ? "󰃚" :
          "󰃜"
      }
    }
  }

  Timer {
    interval: 500
    running: true
    repeat: true
    onTriggered: blightProc.running = true
  }
}
