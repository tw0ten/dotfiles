import QtQuick
import Quickshell.Io
import "../"

BarBlock {
    property string user
    property string host

    color: `#ff${Theme.color.accent}`
    radius: bar.height

    content: BarText {
        color: `#ff${Theme.color.background}`
        text: ` ${user}@${host} `
    }

    Process {
        command: ["whoami"]
        running: true

        stdout: SplitParser {
            onRead: i => user = i
        }
    }

    Process {
        command: ["uname", "-n"]
        running: true

        stdout: SplitParser {
            onRead: i => host = i
        }
    }
}
