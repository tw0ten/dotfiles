import QtQuick
import Quickshell.Io
import "../"

BarBlock {
    content: BarText {
        text: value
    }

    property string value

    Process {
        id: proc
        running: true
        command: ["date", "+%Y/%m/%d-%w %H/%M"]
        stdout: SplitParser {
            onRead: i => value = i
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: proc.running = true
    }
}
