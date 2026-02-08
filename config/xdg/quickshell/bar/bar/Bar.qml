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

    property var eventStreamSubs: []

    RowLayout {
        anchors.fill: parent
        spacing: Theme.sizing.spacing

        Process {
            running: true

            command: ["niri", "msg", "-j", "event-stream"]
            stdout: SplitParser {
                onRead: i => eventStreamSubs.map(i => i.running = true)
            }
        }

        Item {}

        BarBlock {
            content: RowLayout {
                id: workspaces

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

                Process {
                    Component.onCompleted: bar.eventStreamSubs.push(this)

                    command: ["niri", "msg", "-j", "workspaces"]
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
            property real spacing: 1
            property real valueWidth: Math.max((bar.height / 9 * 16) - content.spacing * (layout.value.length - 1), (layout.value.length - 1) * spacing * 2)

            content: RowLayout {
                spacing: layout.spacing

                Repeater {
                    model: layout.value.length

                    Column {
                        spacing: layout.spacing

                        required property int index

                        property var column: layout.value[index]

                        Repeater {
                            model: column.length

                            Rectangle {
                                required property int index

                                color: `#ff${column[index].is_focused ? Theme.color.accent : Theme.color.foreground}`
                                implicitWidth: layout.valueWidth * column[index].size[0]
                                implicitHeight: (bar.height - layout.spacing * (column.length - 1)) * column[index].size[1]
                            }
                        }
                    }
                }
            }

            property var proc: Process {
                command: ["niri", "msg", "-j", "windows"]
                stdout: StdioCollector {
                    onStreamFinished: () => {
                        const windows = JSON.parse(this.text).filter(i => i.workspace_id === workspaces.currentWorkspaceId && i.layout.pos_in_scrolling_layout !== null).sort((a, b) => a.layout.pos_in_scrolling_layout[0] - b.layout.pos_in_scrolling_layout[0]);
                        let columns = {};
                        let focused = {};
                        for (const i of windows) {
                            const x = i.layout.pos_in_scrolling_layout[0];
                            if (i.is_focused)
                                [focused.x, focused.y] = i.layout.pos_in_scrolling_layout;
                            const column = [...(columns[x] ?? []), i];
                            column.sort((a, b) => a.layout.pos_in_scrolling_layout[1] - b.layout.pos_in_scrolling_layout[1]);
                            columns[x] = column;
                        }
                        columns = Object.values(columns);
                        const width = columns.reduce((a, i) => a + i[0].layout.tile_size[0], 0);
                        return layout.value = columns.map(column => {
                            const height = column.map(i => i.layout.tile_size[1]).reduce((a, i) => a + i, 0);
                            return column.map(i => ({
                                        is_focused: i.layout.pos_in_scrolling_layout[0] === focused.x && i.layout.pos_in_scrolling_layout[1] === focused.y,
                                        size: [i.layout.tile_size[0] / width, i.layout.tile_size[1] / height]
                                    }));
                        });
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

            Process {
                Component.onCompleted: bar.eventStreamSubs.push(this)

                command: ["niri", "msg", "-j", "focused-window"]
                stdout: StdioCollector {
                    onStreamFinished: () => window.value = (JSON.parse(this.text)?.title ?? "").substring(0, 128)
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

        Item {}
    }
}
