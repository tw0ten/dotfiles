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
		running: true
		command: ["free", "--seconds", `${2}`]
		stdout: SplitParser {
			splitMarker: "\n\n"
			onRead: i => [valueMem, valueSwap] = i.split("\n").slice(1).map(i => i.split(" ").filter(i => i.length > 0)).map(i => i[2] / i[1])
		}
	}
}
