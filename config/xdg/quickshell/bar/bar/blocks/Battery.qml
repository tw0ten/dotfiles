import QtQuick
import Quickshell.Io
import "../"

BarBlock {
    content: BarText {
        color: `#ff${Theme.color.accent}`
        text: {
            const icons = ["󰂎", "󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹"];
            const status = {
                "Charging": "+",
                "Not charging": ""
            }[valueStatus] ?? "-";
            return `${status}${icons[Math.floor(valueCapacity / 100 * icons.length)]}`;
        }
    }

    property string battery: "/sys/class/power_supply/BAT0"

    property string valueStatus
    property real valueCapacity

    Process {
        id: procStatus
        command: ["cat", `${battery}/status`]
        running: true

        stdout: SplitParser {
            onRead: i => valueStatus = i
        }
    }

    Process {
        id: procCapacity
        command: ["cat", `${battery}/capacity`]
        running: true

        stdout: SplitParser {
            onRead: i => valueCapacity = i
        }
    }

    Timer {
        interval: 5 * 1000
        running: true
        repeat: true
        onTriggered: procStatus.running = procCapacity.running = true
    }
}
