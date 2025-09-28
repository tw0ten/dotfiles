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
        Component.onCompleted: bar.eventStreamSubs.push(this)

        command: ["niri", "msg", "keyboard-layouts"]
        stdout: SplitParser {
            onRead: i => value = i[1] === "*" ? i.split(" ")[3].substring(0, 2).toLowerCase() : value
        }
    }
}
