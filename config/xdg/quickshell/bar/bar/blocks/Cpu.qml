import QtQuick
import Quickshell.Io
import "../"

BarBlock {
    content: BarText {
        text: `c={${Math.round(valueUsage)}% ${Math.round(valueTemp)}°}`
    }

    property real valueUsage
    property real valueTemp

    Process {
        id: procUsage
        command: ["top", "-bn1"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: () => valueUsage = this.text.split("\n")[2].split(" ").filter(i => i.length > 0)[1]
        }
    }
    Process {
        id: procTemp
        command: ["sensors", "k10temp-pci-00c3"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: () => valueTemp = this.text.split("\n")[2].split(" ").filter(i => i.length > 0)[1].slice(1, -2)
        }
    }

    Timer {
        interval: 5 * 1000
        running: true
        repeat: true
        onTriggered: procUsage.running = procTemp.running = true
    }
}
