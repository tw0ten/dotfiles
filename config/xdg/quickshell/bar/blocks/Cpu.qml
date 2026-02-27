import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import "../"

BarBlock {
	content: RowLayout {
		spacing: 0

		BarText {
			text: "{c"
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
		command: ["top", "--batch-mode", "--delay", `${2}`]
		stdout: SplitParser {
			splitMarker: "\n\n"
			onRead: i => {
				if (!i.startsWith("top")) return
				valueUsage = i.split("\n")[2].split(" ").filter(i => i.length > 0)[1] / 100
			}
		}
	}
	Process {
		id: procTemp
		running: true
		command: ["sensors", "-j"]
		stdout:  SplitParser {
			onRead: i => valueTemp = JSON.parse(i)["k10temp-pci-00c3"]["Tctl"]["temp1_input"]
		}
	}

	Timer {
		interval: 2 * 1000
		running: true
		repeat: true
		onTriggered: procTemp.running = true
	}
}
