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
			text: `${Math.round(valueTemp)}°}`
		}
	}

	property real valueUsage
	property real valueTemp

	Process {
		id: procUsage
		running: true
		command: ["top", "-bn1"]
		stdout: StdioCollector {
			onStreamFinished: () => valueUsage = this.text.split("\n")[2].split(" ").filter(i => i.length > 0)[1] / 100
		}
	}
	Process {
		id: procTemp
		running: true
		command: ["sensors", "k10temp-pci-00c3"]
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
