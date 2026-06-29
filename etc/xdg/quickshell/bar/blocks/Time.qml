import QtQuick
import Quickshell.Io
import "../"

BarBlock {
	id: root
	property var value: Item {
		property string date
		property string time
		property real part
	}

	content: Fraction {
		prefix: `${root.value.date} ${root.value.time}/`
		value: root.value.part
	}

	Process {
		id: proc
		running: true
		command: ["date", "+%Y%B%d|%H/%M|%S %N"]
		stdout: SplitParser {
			onRead: i => {
				let t;
				[root.value.date, root.value.time, t] = i.split("|");
				const [secs, nanos] = t.split(" ").map(Number);
				return root.value.part = (secs + nanos / 1000000000) / 60;
			}
		}
	}

	Timer {
		interval: 60 * 1000 / 256
		running: true
		repeat: true
		onTriggered: proc.running = true
	}
}
