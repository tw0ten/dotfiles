from pypresence import Presence
from time import sleep
from subprocess import run

interval = 10
user = run("whoami", shell=True, capture_output=True, check=True).stdout.decode('utf-8').strip()
host = run("uname -n", shell=True, capture_output=True, check=True).stdout.decode('utf-8')

while True:
    try:
        rpc = Presence("1133070138602700810")
        rpc.connect()
        while True:
            uptime = run("uptime -p", shell=True, capture_output=True, check=True).stdout.decode('utf-8')
            rpc.update(
                state=uptime,
                details=user+"@"+host,
                large_image="arch",
                small_image="linux",
            )
            sleep(interval)
    except Exception:
        sleep(interval)
