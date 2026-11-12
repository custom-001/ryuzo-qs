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
  
  implicitHeight: 32
  
  color: "transparent"
  
  Rectangle {
    anchors.fill: parent
    
    color: "#282828"
    
    Row {
      anchors.centerIn: parent
      
      Clock {}
    }
    
    Row {
      anchors {
        right: parent.right
        verticalCenter: parent.verticalCenter
        rightMargin: 8
      }

      spacing: 16
      
      Vol {}

      Blight {}
    }
  }
}