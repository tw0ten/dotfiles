import QtQuick
import Quickshell.Io
import "../"

BarBlock {
    content: BarText {
        text: `g={${valueUsage}% ${valueTemp}°}`
    }

    property string valueUsage
    property string valueTemp

    Process {
        id: procUsage
        command: ["nvidia-smi", "--format=csv,noheader,nounits", "--query-gpu=utilization.gpu"]
        running: true

        stdout: SplitParser {
            onRead: i => valueUsage = i
        }
    }
    Process {
        id: procTemp
        command: ["nvidia-smi", "--format=csv,noheader,nounits", "--query-gpu=temperature.gpu"]
        running: true

        stdout: SplitParser {
            onRead: i => valueTemp = i
        }
    }

    Timer {
        interval: 5 * 1000
        running: true
        repeat: true
        onTriggered: procUsage.running = procTemp.running = true
    }
}
