import QtQuick
import Quickshell.Io
import "../"

BarBlock {
	content: Fraction {
		prefix: "m"
	}

	Process {
		id: proc
		running: true
		command: ["brightnessctl", "--machine-readable", "info"]
		stdout: SplitParser {
			onRead: i => content.value = i.split(",")[2] / i.split(",")[4]
		}
	}

	Timer {
		interval: 5 * 1000
		running: true
		repeat: true
		onTriggered: proc.running = true
	}
}
