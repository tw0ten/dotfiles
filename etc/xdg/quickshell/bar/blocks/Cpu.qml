import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import "../"

BarBlock {
	id: root
	property var value: Item {
		property real usage
		property real temp
	}

	content: RowLayout {
		spacing: 0

		Fraction {
			prefix: "{C"
			value: root.value.usage
		}
		BarText {
			text: `${Math.ceil(root.value.temp)}}`
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
				root.value.usage = i.split("\n")[2].split(" ").filter(i => i.length > 0)[1] / 100;
			}
		}
	}
	Process {
		id: proc
		running: true
		command: ["sensors", "-j"]
		stdout: SplitParser {
			onRead: i => root.value.temp = 273.15 + JSON.parse(i)["k10temp-pci-00c3"]["Tctl"]["temp1_input"]
		}
	}

	Timer {
		interval: 2 * 1000
		running: true
		repeat: true
		onTriggered: proc.running = true
	}
}
