import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import "blocks" as Blocks

PanelWindow {
	id: bar

	color: `#00${Theme.color.background}`

	implicitHeight: Theme.sizing.height
	anchors {
		bottom: true
		left: true
		right: true
	}

	margins {
		top: Theme.sizing.inset
		bottom: Theme.sizing.inset
	}

	property var eventStreamSubs: []

	RowLayout {
		anchors.fill: parent
		spacing: Theme.sizing.spacing

		Process {
			running: true
			command: ["niri", "msg", "-j", "event-stream"]
			stdout: SplitParser {
				onRead: i => bar.eventStreamSubs.map(i => i.running = true)
			}
		}

		Item {}

		BarBlock {
			color: `#a0${Theme.color.background}`

			radius: Theme.sizing.radius

			content: RowLayout {
				id: workspaces

				spacing: Theme.sizing.spacing / 1.5

				property var value: []
				property real currentWorkspaceId: 0

				Item {}
				Repeater {
					model: workspaces.value.length

					BarBlock {
						required property int index

						content: BarText {
							color: `#${(index === 0 || index === workspaces.value.length - 1) ? "b0" : "ff"}${workspaces.value[index].is_focused ? Theme.color.accent : Theme.color.foreground}`
							text: `${index === 0 ? 'c' : index <= 9 ? index : `#${String.fromCharCode(0xE000 + index - 9)}`}${workspaces.value[index].name ?? ""}`
						}
					}
				}
				Item {}

				Process {
					Component.onCompleted: bar.eventStreamSubs.push(this)

					command: ["niri", "msg", "-j", "workspaces"]
					stdout: SplitParser {
						onRead: i => {
							workspaces.value = JSON.parse(i).sort((a, b) => a.idx - b.idx);
							workspaces.currentWorkspaceId = workspaces.value.filter(i => i.is_focused)[0].id;
							return layout.proc.running = true;
						}
					}
				}
			}
		}

		BarBlock {
			id: layout

			color: `#a0${Theme.color.background}`

			property var value: []
			property real spacing: 1

			content: RowLayout {
				spacing: layout.spacing
				Repeater {
					model: layout.value.length

					ColumnLayout {
						required property int index

						property var column: layout.value[index]

						spacing: layout.spacing
						Repeater {
							model: column.length

							Rectangle {
								required property int index

								color: `#ff${column[index].is_focused ? Theme.color.accent : Theme.color.foreground}`
								implicitWidth: column[index].size[0] * (bar.height / 9 * 16)
								implicitHeight: column[index].size[1] * (bar.height - layout.spacing * (column.length - 1))
							}
						}
					}
				}
			}

			property var proc: Process {
				command: ["niri", "msg", "-j", "windows"]
				stdout: SplitParser {
					onRead: i => {
						const windows = JSON.parse(i).filter(i => i.workspace_id === workspaces.currentWorkspaceId && i.layout.pos_in_scrolling_layout !== null).sort((a, b) => a.layout.pos_in_scrolling_layout[0] - b.layout.pos_in_scrolling_layout[0]);
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
			property var value: null

			color: `#ff${Theme.color.foreground}`

			content: RowLayout {
				spacing: Theme.sizing.spacing / 2
				Item {}
				Rectangle {
					color: "#00000000"
					implicitHeight: Theme.sizing.height - 2
					implicitWidth: this.height

					visible: window.iconFetch.out !== null

					Image {
						anchors.fill: parent
						source: window.iconFetch.out ?? ""
					}
				}
				BarText {
					visible: window.value?.title !== ""

					text: (window.value?.title ?? "").substring(0, 128)
					color: `#ff${Theme.color.background}`
				}
				Item {}
			}

			visible: window.value !== null

			radius: Theme.sizing.radius

			Process {
				Component.onCompleted: bar.eventStreamSubs.push(this)

				command: ["niri", "msg", "-j", "focused-window"]
				stdout: SplitParser {
					onRead: i => {
						i = JSON.parse(i);

						if (i !== null) {
							i.title = i.title ?? "";
							window.iconFetch.running = true;
							// i.icon = window.iconFetch.out;
						}

						return window.value = i;
					}
				}
			}

			property var iconFetch: Process {
				command: ["find", "/usr/share/icons", "-name", `${window.value?.app_id}.*`]
				property var out: null
				stdout: StdioCollector {
					onStreamFinished: () => window.iconFetch.out = this.text.length === 0 ? null : this.text.split("\n")[0]
				}
			}
		}

		Item {
			Layout.fillWidth: true
		}

		BarBlock {
			color: `#a0${Theme.color.background}`
			radius: Theme.sizing.radius

			content: RowLayout {
				spacing: Theme.sizing.spacing

				Item {}

				Blocks.Disk {}
				Blocks.Memory {}
				Blocks.Cpu {}
				Blocks.Gpu {}

				Blocks.Time {}

				BarBlock {
					content: RowLayout {
						spacing: Theme.sizing.spacing

						RowLayout {
							spacing: parent.spacing

							Blocks.Battery {}
							Blocks.Audio {}
							Blocks.Brightness {}
							Blocks.Network {}
							Blocks.Keyboard {}
						}

						Blocks.UserHost {
							radius: Theme.sizing.radius
						}
					}
				}
			}
		}

		Item {}
	}
}
