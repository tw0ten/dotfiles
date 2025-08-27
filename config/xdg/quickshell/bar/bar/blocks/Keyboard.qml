import QtQuick
import Quickshell.Io
import "../"

BarBlock {
    content: BarText {
        color: `#ff${Theme.color.accent}`
        text: value
    }

    property string value

    Process {
        id: proc
        command: ["niri", "msg", "keyboard-layouts"]
        running: true

        stdout: SplitParser {
            onRead: i => value = i[1] === "*" ? i.split(" ")[3].substring(0, 2).toLowerCase() : value
        }
    }

    Timer {
        interval: 10 * 1000
        running: true
        repeat: true
        onTriggered: proc.running = true
    }
}
