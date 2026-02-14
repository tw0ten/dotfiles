import QtQuick
import Quickshell.Io
import "../"

BarBlock {
	content: Fraction {}

	property string battery: "/sys/class/power_supply/BAT0"

	Process {
		id: procStatus
		running: true
		command: ["cat", `${battery}/status`]
		stdout: SplitParser {
			onRead: i => content.prefix = { "Charging": "+", "Not charging": "=" }[i] ?? "-"
		}
	}

	Process {
		id: procCapacity
		running: true
		command: ["cat", `${battery}/capacity`]
		stdout: SplitParser {
			onRead: i => content.value = i / 100
		}
	}

	Timer {
		interval: 5 * 1000
		running: true
		repeat: true
		onTriggered: procStatus.running = procCapacity.running = true
	}
}
