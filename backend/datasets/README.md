# StrideCare hackathon demo data

Both files contain synthetic engineering examples. No patient records or physical sensor captures were used.

| File | What it shows | How to use it |
| --- | --- | --- |
| [Seven daily walks](practice_walks_v1.json) | One five-minute walk per day. Steps rise from 270 to 360 and then fall to 306. Mean cane support load increases on the last two days. | Run the [Firebase emulator seed](../README.md) to view the walks in the assigned physio account. |
| [ESP32 serial example](synthetic_esp32_serial.csv) | 64 observations at 250 ms intervals, showing rest, ten counted steps and rest again. Columns cover acceleration magnitude, cumulative steps, cadence, front and rear obstacle distance, and the fall flag. | Open the CSV on GitHub to inspect the readings expected from the prototype sketch. Elapsed time is supplied for replay. |

The walk fixture uses UTC epoch milliseconds, metres, estimated speed in m/s, cadence in steps/minute and mean cane support load in newtons. Each counted step represents 0.5 metres in this simulation. The CSV is a separate short example. The current Arduino sketch prints motion and distance readings over USB. Its serial output does not measure calibrated cane load.
