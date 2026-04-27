import QtQuick
import QtQuick.Layouts

RowLayout {
	id: root
	property string prefix: ""
	required property real value

	spacing: 0

	BarText {
		text: root.prefix
	}
	Item {
		implicitWidth: 6
		implicitHeight: Theme.sizing.height

		Text {
			anchors.centerIn: parent
			text: `${String.fromCharCode(0xE000 + Math.round(root.value * (2 ** 8)))}`
			color: `#ff${Theme.color.accent}`
			font: {
				family: Theme.font.mono;
			}
		}
	}
}
