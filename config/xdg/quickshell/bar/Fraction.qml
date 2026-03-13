import QtQuick
import QtQuick.Layouts

RowLayout {
	property string prefix: ""
	required property real value

	spacing: 0

	BarText { text: prefix }
	Item { // todo
		width: 6
		height: Theme.sizing.height

		Text {
			anchors.centerIn: parent
			text: `${String.fromCharCode(0xE000 + Math.round(value * (2**8)))}`
			color: `#ff${Theme.color.accent}`
			font: {
				family: Theme.font.mono
			}
		}
	}
}
