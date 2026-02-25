import QtQuick
import Quickshell.Io
import "../"

BarBlock {
	content: Fraction {
		prefix: `${valueDate} ${valueTime}/`
		value: valuePart
	}

	property string valueDate
	property string valueTime
	property real valuePart

	Process {
		id: proc
		running: true
		command: ["date", "+%Y/%b/%d-%w | %H/%M | %S %N"]
		stdout: SplitParser {
			onRead: i => {
				let t
				[valueDate, valueTime, t] = i.split(" | ")
				const [secs, nanos] = t.split(" ").map(Number)
				valuePart = (secs + nanos / 1000000000) / 60
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
