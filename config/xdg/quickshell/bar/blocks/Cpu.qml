import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import "../"

BarBlock {
	content: RowLayout {
		spacing: 0

		BarText {
			text: `c{`
		}
		Fraction {
			value: valueUsage
		}
		BarText {
			text: `${Math.ceil(valueTemp)}}`
		}
	}

	property real valueUsage
	property real valueTemp

	Process {
		running: true
		command: ["top", "--batch-mode", "--delay", `${5}`]
		stdout: SplitParser {
			splitMarker: "\n\n"
			onRead: i => {
				if (i.split("\n").length !== 5) return
				valueUsage = i.split("\n")[2].split(" ").filter(i => i.length > 0)[1] / 100
			}
		}
	}
	Process {
		id: procTemp
		running: true
		command: ["sensors", "-j"]
		stdout: StdioCollector {
			onStreamFinished: () => valueTemp = JSON.parse(this.text)["k10temp-pci-00c3"]["Tctl"]["temp1_input"]
		}
	}

	Timer {
		interval: 5 * 1000
		running: true
		repeat: true
		onTriggered: procTemp.running = true
	}
}
