import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import "../"

BarBlock {
	id: root
	property var value: Item {
		property real mem
		property real swap
	}

	content: RowLayout {
		spacing: 0

		Fraction {
			prefix: "<"
			value: root.value.mem
		}
		Fraction {
			prefix: "+"
			value: root.value.swap
		}
		BarText {
			text: ">"
		}
	}

	Process {
		running: true
		command: ["free", "--seconds", `${2}`]
		stdout: SplitParser {
			splitMarker: "\n\n"
			onRead: i => [root.value.mem, root.value.swap] = i.split("\n").slice(1).map(i => i.split(" ").filter(i => i.length > 0)).map(i => i[2] / i[1])
		}
	}
}
