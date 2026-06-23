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
		id: proc
		running: true
		command: ["cat", "--", `${root.battery}/energy_now`, `${root.battery}/energy_full`, `${root.battery}/status`]
		stdout: SplitParser {
			splitMarker: "\n\n"
			onRead: i => {
				const [ enow, efull, status ] = i.split("\n");
				root.content.value = enow / efull;
				root.content.prefix = ({
					"Charging": "+",
					"Not charging": "="
				})[status] ?? "-";
			}
		}
	}

	Timer {
		interval: 5 * 1000
		running: true
		repeat: true
		onTriggered: proc.running = true
	}
}
