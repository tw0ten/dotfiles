import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import "../"

BarBlock {
	id: root
	property var value: Item {
		property real usage
		property real temp
		property real memory_used
		property real memory
	}

	content: RowLayout {
		spacing: 0

		Fraction {
			prefix: "{G"
			value: root.value.usage / 100
		}
		Fraction {
			prefix: `${root.value.temp + 273}`
			value: root.value.memory_used / root.value.memory
		}
		BarText {
			text: "}"
		}
	}

	Process {
		running: true
		command: ["nvidia-smi", "--format=csv,noheader,nounits", "--query-gpu=utilization.gpu,temperature.gpu,memory.used,memory.total", `--loop=${2}`]
		stdout: SplitParser {
			onRead: i => [root.value.usage, root.value.temp, root.value.memory_used, root.value.memory] = i.split(", ")
		}
	}
}
