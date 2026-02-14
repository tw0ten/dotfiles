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
		command: ["brightnessctl", "get"]
		stdout: SplitParser {
			onRead: i => content.value = i / 100
		}
	}

	Timer {
		interval: 5 * 1000
		running: true
		repeat: true
		onTriggered: proc.running = true
	}
}
