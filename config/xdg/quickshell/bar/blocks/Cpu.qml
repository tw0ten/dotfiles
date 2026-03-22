import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import "../"

BarBlock {
	id: root
	property real valueUsage
	property real valueTemp

	content: RowLayout {
		spacing: 0

		BarText {
			text: "{c"
		}
		Fraction {
			value: root.valueUsage
		}
		BarText {
			text: `${Math.ceil(root.valueTemp)}}`
		}
	}

	Process {
		running: true
		command: ["top", "--batch-mode", "--delay", `${2}`]
		stdout: SplitParser {
			splitMarker: "\n\n"
			onRead: i => {
				if (!i.startsWith("top"))
				return;
				root.valueUsage = i.split("\n")[2].split(" ").filter(i => i.length > 0)[1] / 100;
			}
		}
	}
	Process {
		id: procTemp
		running: true
		command: ["sensors", "-j"]
		stdout: SplitParser {
			onRead: i => root.valueTemp = JSON.parse(i)["k10temp-pci-00c3"]["Tctl"]["temp1_input"]
		}
	}

	Timer {
		interval: 2 * 1000
		running: true
		repeat: true
		onTriggered: procTemp.running = true
	}
}
