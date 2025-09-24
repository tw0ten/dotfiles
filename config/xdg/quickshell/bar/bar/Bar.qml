import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import "blocks" as Blocks

PanelWindow {
    id: bar

    color: `#a0${Theme.color.background}`
    implicitHeight: Theme.sizing.height
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
            command: ["niri", "msg", "-j", "event-stream"]
            running: true

            stdout: SplitParser {
                onRead: i => workspaces.proc.running = window.proc.running = true
            }
        }

        BarBlock {
            content: RowLayout {
                id: workspaces
                spacing: Theme.sizing.spacing

                property var value: []
                property real currentWorkspaceId: 0

                Repeater {
                    model: workspaces.value.length

                    BarBlock {
                        required property int index

                        content: BarText {
                            color: `#${(index === 0 || index === workspaces.value.length - 1) ? "b0" : "ff"}${workspaces.value[index].is_focused ? Theme.color.accent : Theme.color.foreground}`
                            text: `${index}`
                        }
                    }
                }

                property var proc: Process {
                    command: ["niri", "msg", "-j", "workspaces"]
                    running: true

                    stdout: StdioCollector {
                        onStreamFinished: () => {
                            workspaces.value = JSON.parse(this.text).sort((a, b) => a.idx - b.idx);
                            workspaces.currentWorkspaceId = workspaces.value.filter(i => i.is_focused)[0].id;
                            layout.proc.running = true;
                        }
                    }
                }
            }
        }

        BarBlock {
            id: layout

            property var value: []
            property real valueWidth: 80 - content.spacing * (layout.value.length - 1)

            content: RowLayout {
                spacing: 2

                Repeater {
                    model: layout.value.length

                    Rectangle {
                        required property int index
                        color: `#ff${layout.value[index].is_focused ? Theme.color.accent : Theme.color.foreground}`
                        implicitWidth: layout.valueWidth * layout.value[index].size[0]
                        implicitHeight: bar.height / 4
                    }
                }
            }

            property var proc: Process {
                command: ["niri", "msg", "-j", "windows"]
                running: true

                stdout: StdioCollector {
                    onStreamFinished: () => {
                        const windows = JSON.parse(this.text).filter(i => i.workspace_id === workspaces.currentWorkspaceId && i.layout.pos_in_scrolling_layout !== null).sort((a, b) => a.layout.pos_in_scrolling_layout[0] - b.layout.pos_in_scrolling_layout[0]);
                        let columns = {};
                        let focused;
                        for (const i of windows) {
                            const x = i.layout.pos_in_scrolling_layout[0];
                            if (i.is_focused)
                                focused = x;
                            columns[x] = [...(columns[x] ?? []), i];
                        }
                        columns = Object.values(columns);
                        const width = columns.reduce((a, i) => a + i[0].layout.tile_size[0], 0);
                        return layout.value = columns.map(i => ({
                                    is_focused: i[0].layout.pos_in_scrolling_layout[0] === focused,
                                    size: i[0].layout.tile_size.map(i => i / width)
                                }));
                    }
                }
            }
        }

        BarBlock {
            id: window
            property string value

            color: `#ff${Theme.color.foreground}`

            content: BarText {
                text: ` ${window.value} `
                color: `#ff${Theme.color.background}`
            }

            visible: window.value.length > 0

            property var proc: Process {
                command: ["niri", "msg", "-j", "focused-window"]
                running: true

                stdout: StdioCollector {
                    onStreamFinished: () => window.value = JSON.parse(this.text)?.title ?? ""
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
