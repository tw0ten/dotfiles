import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import "../"

BarBlock {
	id: root
	property real valueMem
	property real valueSwap

	content: RowLayout {
		spacing: 0

		Fraction {
			prefix: `<`
			value: root.valueMem
		}
		Fraction {
			prefix: `+`
			value: root.valueSwap
		}
		BarText {
			text: `>`
		}
	}

	Process {
		running: true
		command: ["free", "--seconds", `${2}`]
		stdout: SplitParser {
			splitMarker: "\n\n"
			onRead: i => [root.valueMem, root.valueSwap] = i.split("\n").slice(1).map(i => i.split(" ").filter(i => i.length > 0)).map(i => i[2] / i[1])
		}
	}
}
