import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import "../"

BarBlock {
	content: RowLayout {
		spacing: 0

		BarText {
			text: "("
		}
		Fraction {
			prefix: `${Math.trunc(valueNumber)}`
			value: valueNumber % 1
		}
		BarText {
			text: `${valueUnit})`
		}
	}

	property real valueNumber
	property string valueUnit

	Process {
		id: proc
		running: true
		command: ["df", "/", "--si", "--output=avail"]
		stdout: SplitParser {
			splitMarker: ""
			onRead: i => [valueNumber, valueUnit] = [i.substring(5, i.length - 2), i[i.length - 2]]
		}
	}

	Timer {
		interval: 30 * 1000
		running: true
		repeat: true
		onTriggered: proc.running = true
	}
}
