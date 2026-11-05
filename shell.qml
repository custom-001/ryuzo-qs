import Quickshell
import QtQuick

ShellRoot {
  id: root
  
  PanelWindow {
    id: pill
    
    anchors.top: true
    margins.top: 15
    
    implicitHeight: 72
    implicitWidth: 560
    
    color: "transparent"
    
    Rectangle {
      id: pillRect
      
      property bool hovered: pillMouse.containsMouse
      
      anchors.centerIn: parent
      
      height: hovered ? 64 : 48
      width: hovered ? 480 : 128
      radius: 9999
      
      color: hovered ? "#101010" : "#000000"
      border { width: hovered ? 4 : 2; color: hovered ? "#ff1010" : "#ff0000"; }
      
      Behavior on height { NumberAnimation { duration: 250; easing.type: Easing.OutBack; } }
      Behavior on width { NumberAnimation { duration: 250; easing.type: Easing.OutBack; } }
      Behavior on border.width { NumberAnimation { duration: 250; easing.type: Easing.OutBack; } }
      
      Behavior on color { ColorAnimation { duration: 250; easing.type: Easing.OutBack; } }
      Behavior on border.color { ColorAnimation { duration: 250; easing.type: Easing.OutBack; } }
      
      Text {
        id: clockText
        
        anchors.centerIn: parent
        
        color: "#ffffff"
        
        text: Qt.formatDateTime(clock.date, "hh:mm AP")
      }
      
      MouseArea {
        id: pillMouse
        
        anchors.fill: parent
        hoverEnabled: true
      }
    }
  }
  
  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }
}
