import QtQuick
import QtQuick.Layouts
import Quickshell

Rectangle {
	Layout.preferredWidth: contentContainer.implicitWidth
	Layout.preferredHeight: bar.height

	color: "#00000000"

	property Item content

	Item {
		id: contentContainer
		implicitWidth: content.implicitWidth
		implicitHeight: content.implicitHeight
		anchors.centerIn: parent
		children: content
	}
}
