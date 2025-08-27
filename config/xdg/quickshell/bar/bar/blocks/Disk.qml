import QtQuick
import Quickshell.Io
import "../"

BarBlock {
    content: BarText {
        text: `(${value})`
    }

    property string value

    Process {
        id: proc
        command: ["df", "/", "-h"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: () => value = this.text.split("\n")[1].split(" ").filter(i => i.length > 0)[3]
        }
    }

    Timer {
        interval: 30 * 1000
        running: true
        repeat: true
        onTriggered: proc.running = true
    }
}
