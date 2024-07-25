from pypresence import Presence
import time
import subprocess

user = subprocess.run("whoami", shell=True, capture_output=True, check=True).stdout.decode('utf-8').strip()
host = subprocess.run("uname -n", shell=True, capture_output=True, check=True).stdout.decode('utf-8')

while True:
    try:
        rpc = Presence("1133070138602700810")
        rpc.connect()
        while True:
            uptime = subprocess.run("uptime -p", shell=True, capture_output=True, check=True).stdout.decode('utf-8')
            rpc.update(
                state = uptime,
                details = user+"@"+host,
                large_image = "arch",
                small_image = "linux",
                small_text = "linux"
            )
            time.sleep(4)
    except:
        print("discord disabled/error")
    time.sleep(4)
