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
        command: ["nmcli", "network"]
        running: true

        stdout: SplitParser {
            onRead: i => value = i === "enabled" ? "" : "󰣽"
        }
    }

    Timer {
        interval: 10 * 1000
        running: true
        repeat: true
        onTriggered: proc.running = true
    }
}
