import Quickshell
import Quickshell.Io
import QtQuick

Text {
  id: vol
  
  text: "V"
  
  color: "#cdd6f4"
  
  font { 
    family: "Iosevka Nerd Font"
    pixelSize: 24
    bold: true
  }

  Process {
    id: volProc

    command: [ "wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@" ]

    running: true

    stdout: StdioCollector {

      onStreamFinished: {
        const volume = parseFloat(
          this.text.replace("Volume: ", "").trim()
        )

        if (isNaN(volume))
          return

        vol.text =
          volume > 0.8 ? "" :
          volume > 0.4 ? "" :
          volume > 0.2 ? "" :
          ""
      }

    }
  }

  Timer {
    interval: 500
    running: true
    repeat: true
    onTriggered: volProc.running = true
  }
}
