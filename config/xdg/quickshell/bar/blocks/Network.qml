import QtQuick
import Quickshell.Io
import "../"

BarBlock {
	content: Fraction {
		prefix: "n"
	}

	Process {
		id: proc
		running: true
		command: ["iwctl", "station", "wlan0", "show"]
		stdout: SplitParser {
			splitMarker: ""
			onRead: i => content.value = Math.min(Math.max(i.split("\n").map(i => i.split(" ").filter(i => i.length > 0)).filter(i => i[0] === "AverageRSSI")[0][1], -100), 0) / 100 + 1
		}
	}

	Timer {
		interval: 5 * 1000
		running: true
		repeat: true
		onTriggered: proc.running = true
	}
}
