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
		command: ["sensors", "-j"]
		stdout: StdioCollector {
			onStreamFinished: () => valueTemp = JSON.parse(this.text)["k10temp-pci-00c3"]["Tctl"]["temp1_input"]
		}
	}

	Timer {
		interval: 5 * 1000
		running: true
		repeat: true
		onTriggered: procUsage.running = procTemp.running = true
	}
}
