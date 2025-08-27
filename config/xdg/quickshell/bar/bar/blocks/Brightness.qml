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
        command: ["brightnessctl", "get"]
        running: true

        stdout: SplitParser {
            onRead: i => {
                const percentage = parseInt(i);
                const icons = ["󰛩", "󱩎", "󱩏", "󱩐", "󱩑", "󱩒", "󱩓", "󱩔", "󱩕", "󱩖", "󰛨"];
                return value = `${icons[Math.floor(percentage / 100 * icons.length)]}`;
            }
        }
    }

    Timer {
        interval: 5 * 1000
        running: true
        repeat: true
        onTriggered: proc.running = true
    }
}
