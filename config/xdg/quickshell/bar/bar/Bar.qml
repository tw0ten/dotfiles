import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import "blocks" as Blocks

PanelWindow {
    id: bar

    color: `#a0${Theme.color.background}`
    implicitHeight: 20
    anchors {
        bottom: true
        left: true
        right: true
    }

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: Theme.sizing.horizontal
        anchors.rightMargin: Theme.sizing.horizontal
        spacing: Theme.sizing.horizontal

        Process {
            command: ["niri", "msg", "event-stream"]
            running: true

            stdout: SplitParser {
                onRead: i => workspaces.proc.running = window.proc.running = true
            }
        }

        BarBlock {
            content: RowLayout {
                id: workspaces
                property var value: []
                spacing: Theme.sizing.spacing

                Repeater {
                    model: workspaces.value.length

                    BarBlock {
                        required property int index

                        content: BarText {
                            color: `#${(index === 0 || index === workspaces.value.length - 1) ? "b0" : "ff"}${workspaces.value[index].selected ? Theme.color.accent : Theme.color.foreground}`
                            text: `${workspaces.value[index].text}`
                        }
                    }
                }

                property var proc: Process {
                    command: ["niri", "msg", "workspaces"]
                    running: true

                    stdout: StdioCollector {
                        onStreamFinished: () => workspaces.value = this.text.split("\n").slice(1, -1).map(i => ({
                                        selected: i[1] === "*",
                                        text: `${parseInt(i.substring(3)) - 1}`
                                    }))
                    }
                }
            }
        }

        BarBlock {
            id: window
            property string value

            color: `#ff${Theme.color.foreground}`
            radius: bar.height

            content: BarText {
                text: ` ${window.value} `
                color: `#ff${Theme.color.background}`
            }

            visible: window.value !== ""

            property var proc: Process {
                command: ["niri", "msg", "focused-window"]
                running: true

                stdout: StdioCollector {
                    onStreamFinished: () => window.value = (this.text === "No window is focused." ? "" : this.text.split("\n")[1].slice(10, -1))
                }
            }
        }

        Item {
            Layout.fillWidth: true
        }

        BarBlock {
            content: RowLayout {
                spacing: Theme.sizing.spacing

                Blocks.Disk {}
                Blocks.Memory {}
                Blocks.Cpu {}
                Blocks.Gpu {}

                Blocks.Time {}

                BarBlock {
                    color: `#ff${Theme.color.background}`
                    radius: bar.height

                    content: RowLayout {
                        spacing: Theme.sizing.spacing

                        Item {}

                        RowLayout {
                            spacing: parent.spacing / 2

                            Blocks.Battery {}
                            Blocks.Audio {}
                            Blocks.Brightness {}
                            Blocks.Network {}
                            Blocks.Keyboard {}
                        }

                        Blocks.UserHost {}
                    }
                }
            }
        }
    }
}
