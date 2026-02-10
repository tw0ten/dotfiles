import QtQuick
import Quickshell.Io
import "../"

BarBlock {
    content: BarText {
        color: `#ff${Theme.color.accent}`
        text: value.substring(0, 2)
    }

    property string value

    Process {
        Component.onCompleted: bar.eventStreamSubs.push(this)

        command: ["niri", "msg", "-j", "keyboard-layouts"]
        stdout: SplitParser {
            onRead: i => value = JSON.parse(i)["names"][JSON.parse(i)["current_idx"]]
        }
    }
}
