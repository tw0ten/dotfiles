import QtQuick
import Quickshell.Io
import "../"

BarBlock {
	content: Fraction {
		color: `#ff${Theme.color.accent}`
		prefix: "n"
	}

	Process {
		id: proc
		running: true
		command: ["nmcli", "network"]
		stdout: SplitParser {
			onRead: i => content.value = i === "enabled" ? 1 : 0
		}
	}

	Timer {
		interval: 10 * 1000
		running: true
		repeat: true
		onTriggered: proc.running = true
	}
}
