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
		left: 2
		right: 2
		top: 1
		bottom: 1
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

		BarBlock {
			color: `#e0${Theme.color.background}`

			radius: Theme.sizing.radius

			TapHandler {
				property var overview: Process {
					command: ["niri", "msg", "action", "toggle-overview"]
				}
				onTapped: overview.running = true
			}

			content: RowLayout {

				id: workspaces

				spacing: Theme.sizing.spacing / 1.5

				property var value: []

				Item {}
				Repeater {
					model: workspaces.value.length

					BarBlock {
						required property int index

						content: BarText {
							color: `#${(index === 0 || index === workspaces.value.length - 1) ? "b0" : "ff"}${workspaces.value[index].is_focused ? Theme.color.accent : Theme.color.foreground}`
							text: `${(workspaces.value[index].is_focused ? workspaces.value[index].name : null) ?? (index === 0 ? 'c' : index <= 9 ? index : `#${String.fromCharCode(0xE000 + index - 9)}`)}`
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
							return layout.proc.running = true;
						}
					}
				}
			}
		}

		BarBlock {
			id: layout

			color: `#ff${Theme.color.foreground}`

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

								color: `#f0${column[index].is_focused ? Theme.color.accent : Theme.color.background}`

								implicitWidth: column[index].size[0] * bar.height
								implicitHeight: column[index].size[1] * (bar.height - layout.spacing * (column.length - 1))

								TapHandler {
									property var focus: Process {
										command: ["niri", "msg", "action", "focus-window", "--id", `${column[index].id}`]
									}
									onTapped: focus.running = true
								}
							}
						}
					}
				}
			}

			property var proc: Process {
				command: ["niri", "msg", "-j", "windows"]
				stdout: SplitParser {
					onRead: i => {
						const workspace = workspaces.value.filter(i => i.is_focused)[0];
						const windows = JSON.parse(i).filter(i => i.workspace_id === workspace.id && i.layout.pos_in_scrolling_layout !== null).sort((a, b) => a.layout.pos_in_scrolling_layout[0] - b.layout.pos_in_scrolling_layout[0]);

						let columns = {};
						for (const i of windows) {
							const x = i.layout.pos_in_scrolling_layout[0];
							const column = [...(columns[x] ?? []), i];
							column.sort((a, b) => a.layout.pos_in_scrolling_layout[1] - b.layout.pos_in_scrolling_layout[1]);
							columns[x] = column;
						}
						columns = Object.values(columns);

						const width = 1080; // columns.reduce((a, i) => a + i[0].layout.tile_size[0], 0);
						return layout.value = columns.map(column => {
							const height = column.map(i => i.layout.tile_size[1]).reduce((a, i) => a + i, 0);
							return column.map(i => ({
								id: i.id,
								is_focused: i.id === workspace.active_window_id,
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

			anchors.centerIn: parent // todo: anchors in layout is undefined behavior

			color: `#ff${Theme.color.foreground}`

			Behavior on implicitWidth {
				NumberAnimation {
					duration: 100
				}
			}

			content: RowLayout {
				spacing: Theme.sizing.spacing / 2

				Item {}
				Rectangle {
					color: "#00000000"
					implicitHeight: Theme.sizing.height - 2
					implicitWidth: this.height

					visible: window.icon.get() !== null

					Image {
						anchors.fill: parent
						source: window.icon.get() ?? ""
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
						if (i !== null)
							i.title = i.title ?? "";
						return window.value = i;
					}
				}
			}

			property var icon: Item {
				property var i: window.value?.app_id
				property var get: () => {
					if (cache[i] === undefined)
						window.icon.fetch.running = true;
					return cache[i];
				}
				property var cache: ({})
				property var fetch: Process {
					command: ["sh", "-c", `set -- '${window.icon.i}' && echo "$1" && find /usr/share/icons -name "$1.*"`]
					stdout: StdioCollector {
						onStreamFinished: () => {
							const i = this.text.split("\n");
							return window.icon.cache[i[0]] = i[1].length === 0 ? null : i[1];
						}
					}
				}
			}
		}

		Item {
			Layout.fillWidth: true
		}

		RowLayout {
			spacing: Theme.sizing.spacing / 2

			BarBlock {
				color: `#e0${Theme.color.background}`
				radius: Theme.sizing.radius

				content: RowLayout {
					spacing: Theme.sizing.spacing

					Item {}
					Blocks.Disk {}
					Blocks.Memory {}
					Blocks.Cpu {}
					Blocks.Gpu {}
					Item {}
				}
			}
			BarBlock {
				color: `#e0${Theme.color.background}`
				radius: Theme.sizing.radius

				content:RowLayout {
					spacing: Theme.sizing.spacing

					Item {}
					Blocks.Battery {}
					Blocks.Audio {}
					Blocks.Brightness {}
					Blocks.Network {}
					Blocks.Keyboard {}
					Item {}
				}
			}
			BarBlock {
				color: `#e0${Theme.color.background}`
				radius: Theme.sizing.radius

				content: RowLayout {
					spacing: Theme.sizing.spacing

					Item {}
					Blocks.Time {}
					Blocks.UserHost {
						radius: Theme.sizing.radius
					}
				}
			}
		}
	}
}
