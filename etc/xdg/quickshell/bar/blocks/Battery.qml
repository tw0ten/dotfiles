import QtQuick
import Quickshell.Io
import "../"

BarBlock {
	id: root
	property string battery: "/sys/class/power_supply/BAT0"

	content: Fraction {
		prefix: "="
		value: 0
	}

	Process {
		id: procStatus
		running: true
		command: ["cat", `${root.battery}/status`]
		stdout: SplitParser {
			onRead: i => root.content.prefix = {
				"Charging": "+",
				"Not charging": "="
			}[i] ?? "-"
		}
	}

	Process {
		id: procCapacity
		running: true
		command: ["cat", `${root.battery}/capacity`]
		stdout: SplitParser {
			onRead: i => root.content.value = i / 100
		}
	}

	Timer {
		interval: 5 * 1000
		running: true
		repeat: true
		onTriggered: procStatus.running = procCapacity.running = true
	}
}
