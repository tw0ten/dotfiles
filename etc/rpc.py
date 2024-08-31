from pypresence import Presence
import subprocess
from time import sleep

def run(cmd):
    return subprocess.run(cmd, capture_output=True).stdout.decode("utf-8").strip()

user = run(["whoami"])
host = run(["uname", "-n"])
rpc = Presence("1133070138602700810")

while True:
    try:
        rpc.connect()
        while True:
            uptime = run(["uptime", "-p"])
            rpc.update(
                state=uptime,
                details=user + "@" + host,
                large_image="arch",
                small_image="linux",
            )
            sleep(10)
    except Exception as e:
        print(e)
        sleep(10)
