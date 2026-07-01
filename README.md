# SIM7600 Driver for Spin2

SIMCOM SIM7600 Driver for a P2 running in a dedicated cog. The module supports 2G/3G/4G Networking.

The driver is tested in [FlexSpin 7.6.7](https://github.com/totalspectrum/flexprop/releases/tag/v7.6.7)

## Test Hardware

* Modem

    I used a [Waveshare SIM7600G-H development module](https://www.waveshare.com/wiki/SIM7600X_4G_Module)
    <br>
    They are available from [Amazon](https://www.waveshare.com/wiki/SIM7600X_4G_Module) and include a MAIN antenna. (GPS and AUX antenna not included)

* [P2 Edge](https://www.parallax.com/product/p2-edge-module/)
* Any of the P2 Edge breakouts work for testing. I used the [P2 Edge Module Breadboard](https://www.parallax.com/product/p2-edge-module-breadboard/).
* [PropPlug](https://www.parallax.com/product/prop-plug/)
* I also soldered a perfboard and female headers, as the module is too wide for the breadboard.

## Carrier

I successfully used [Hologram](https://www.hologram.io/) for my testing. I tried checking my IMEI with T-Mobile and Verizon directly, all saying that the device is incompatible.

Hologram supports data and SMS, but voice calling is blocked.

## To Do

* [x] Basic Modem Information
* [x] Signal Strength and RSSI conversion
* [x] Modem Reset
* [x] Network Operator Scanning
* [x] APN Setup
* [x] Baud Rate Configuration
* [x] Device mode setting (normal, flight, limited, etc)
* [x] MQTT
* [ ] SSL
* [ ] SIM Locking
* [ ] SIM Toolkit
* [ ] Modem Filesystem
* [ ] Modem GPIO
* [ ] SMS
* [ ] Voice Calls
* [ ] Phonebook
* [ ] HTTP(S)
* [ ] FTP(S)
* [ ] Network Time
* [ ] GPS/GNSS
* [ ] Raw TCP
* [ ] Raw UDP

## License

All work is under the MIT license.

This project includes the following community objects:

| Object                    | Author                     | License |
| ------------------------- | -------------------------- | ------- |
| jm_ansi.spin2             | Jon "JonnyMac" McPhalen    | MIT     |
| jm_nstr.spin2             | Jon "JonnyMac" McPhalen    | MIT     |
| jm_fullduplexserial.spin2 | Jon "JonnyMac" McPhalen    | MIT     |
| string.spin2              | Jesse Burt                 | MIT     |