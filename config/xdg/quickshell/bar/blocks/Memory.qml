import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import "../"

BarBlock {
	content: RowLayout {
		spacing: 0

		BarText {
			text: `<`
		}
		Fraction {
			value: valueMem
		}
		BarText {
			text: `+`
		}
		Fraction {
			value: valueSwap
		}
		BarText {
			text: `>`
		}
	}

	property real valueMem
	property real valueSwap

	Process {
		id: proc
		running: true
		command: ["free", "-b"]
		stdout: StdioCollector {
			onStreamFinished: () => [valueMem, valueSwap] = this.text.split("\n").slice(1).map(i => i.split(" ").filter(i => i.length > 0).slice(1, 3)).map(i => i[1] / i[0])
		}
	}

	Timer {
		interval: 2 * 1000
		running: true
		repeat: true
		onTriggered: proc.running = true
	}
}
