import QtQuick
import Quickshell.Io
import "../"

BarBlock {
	id: root
	content: Fraction {
		prefix: "m"
		value: 0
	}

	Process {
		id: proc
		running: true
		command: ["brightnessctl", "--machine-readable", "info"]
		stdout: SplitParser {
			onRead: i => root.content.value = i.split(",")[2] / i.split(",")[4]
		}
	}

	Timer {
		interval: 5 * 1000
		running: true
		repeat: true
		onTriggered: proc.running = true
	}
}
