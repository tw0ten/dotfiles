import QtQuick
import Quickshell.Io
import "../"

BarBlock {
	id: root
	property string valueDate
	property string valueTime
	property real valuePart

	content: Fraction {
		prefix: `${root.valueDate} ${root.valueTime}/`
		value: root.valuePart
	}

	Process {
		id: proc
		running: true
		command: ["date", "+%Y%B%d|%H/%M|%S %N"]
		stdout: SplitParser {
			onRead: i => {
				let t;
				[root.valueDate, root.valueTime, t] = i.split("|");
				const [secs, nanos] = t.split(" ").map(Number);
				return root.valuePart = (secs + nanos / 1000000000) / 60;
			}
		}
	}

	Timer {
		interval: 1000 / 256
		running: true
		repeat: true
		onTriggered: proc.running = true
	}
}
