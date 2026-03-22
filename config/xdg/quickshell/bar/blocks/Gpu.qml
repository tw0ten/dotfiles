import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import "../"

BarBlock {
	id: root
	property real valueUsage
	property real valueTemp

	content: RowLayout {
		spacing: 0

		BarText {
			text: "{g"
		}
		Fraction {
			value: root.valueUsage / 100
		}
		BarText {
			text: `${root.valueTemp}}`
		}
	}

	Process {
		running: true
		command: ["nvidia-smi", "--format=csv,noheader,nounits", "--query-gpu=utilization.gpu,temperature.gpu", `--loop=${2}`]
		stdout: SplitParser {
			onRead: i => [root.valueUsage, root.valueTemp] = i.split(", ")
		}
	}
}
