import QtQuick
import Quickshell.Io
import "../"

BarBlock {
    content: BarText {
        text: `<${Math.floor(valueMem * 100)}+${Math.floor(valueSwap * 100)}%>`
    }

    property real valueMem
    property real valueSwap

    Process {
        id: proc
        command: ["free", "-b"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: () => [valueMem, valueSwap] = this.text.split("\n").slice(1).map(i => i.split(" ").filter(i => i.length > 0).slice(1, 3)).map(i => i[1] / i[0])
        }
    }

    Timer {
        interval: 2 * 1000
        running: true
        repeat: true
        onTriggered: proc.running = true
    }
}
