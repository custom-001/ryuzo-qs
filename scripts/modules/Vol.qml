import Quickshell
import Quickshell.Io
import QtQuick

Text {
  id: vol
  
  text: "V"
  
  color: "#ebdbb2"
  font { family: "Iosevka Nerd Font"; pixelSize: 24; bold: true; }

  Process {
    id: volProc

    command: [ "wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@" ]

    running: true

    stdout: StdioCollector {
      onStreamFinished: vol.text = this.text.replace("Volume: ", "").trim() + "%"
    }
  }
}
