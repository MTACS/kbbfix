# kbbfix - keyboard backlight fix
Fix annoying system wake keyboard brightness bug on Apple Silicon MacBooks

Sometimes when waking M1 MacBook Pro from sleep the keyboard backlight is completely off, despite always having it at full brightness. Couldn't seem to find anyone else with this problem, but this fixes it. Set the desired backlight brightness with ```[brightnessClient setBrightness:1.0 forKeyboard:1];```, range 0.0 to 1.0. Uses `KeyboardBrightnessClient.h` from [EthanRDoesMC's](https://github.com/EthanRDoesMC) [KBPulse](https://github.com/EthanRDoesMC/KBPulse/tree/main)

Add to login items in Settings > General > Login Items, or run in background with `nohup ./kbbfix &`
