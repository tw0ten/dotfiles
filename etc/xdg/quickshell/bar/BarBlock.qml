import QtQuick

Rectangle {
	id: root
	required property Item content
	color: "#00000000"

	implicitWidth: contentContainer.width
	implicitHeight: Theme.sizing.height

	Item {
		id: contentContainer
		implicitWidth: root.content.width
		implicitHeight: root.content.height
		anchors.centerIn: parent
		children: root.content
	}
}
