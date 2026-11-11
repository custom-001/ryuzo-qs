import Quickshell
import Quickshell.Io
import QtQuick

Text {
  id: clock
  
  text: "C"
  
  color: "#ebdbb2"
  font { family: "Iosevka Nerd Font"; pixelSize: 24; bold: true; }
  
  Process {
    id: clockProc
    
    command: [ "date", "+%I:%M %p" ]
    
    running: true
    
    stdout: StdioCollector {
      onStreamFinished: clock.text = this.text
    }
  }
  
  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: clockProc.running = true
  }
}