# SIM7600 Driver for Spin2

SIMCOM SIM7600 Driver for a P2 running in a dedicated cog. The module supports 2G/3G/4G Networking.

The driver is tested in [FlexSpin 7.6.11](https://github.com/totalspectrum/flexprop/releases/tag/v7.6.11)

## Test Hardware

* Modem

    I used a [Waveshare SIM7600G-H development module](https://www.waveshare.com/wiki/SIM7600X_4G_Module)
    <br>
    They are available from [Amazon](https://www.waveshare.com/wiki/SIM7600X_4G_Module) and include a MAIN antenna (GPS and AUX antenna not included).
    Note that some modules use an SMA connector instead of IPEX 1.

* [P2 Edge](https://www.parallax.com/product/p2-edge-module/)
* Any of the P2 Edge breakouts work for testing. I used the [P2 Edge Module Breadboard](https://www.parallax.com/product/p2-edge-module-breadboard/).
* [PropPlug](https://www.parallax.com/product/prop-plug/)
* DHT22/11 Temperature/Humidity sensor required for some examples
* I also soldered a perfboard and female headers, as the module is too wide for the breadboard.

> [!TIP]
> The SIM7600 can cause large transient current spikes (>2A) when transmitting data. Use a stable supply for stability. The Waveshare module includes a MIC29302 LDO configured for 3.88V.

## Examples

All examples use the following pinout:

| Modem | P2 |
| ----- | -- |
| TX    | 1  |
| RX    | 0  |
| DTR   | 2  |
| RST   | 3  |

All examples use 115200 baud for the modem with 4KB RX and URC buffers.

> [!NOTE]
> The DTR pin is not currently used, but may be required in the future for advanced sleep features.

### [01_modem_info.spin2](01_modem_info.spin2)

Initializes modem, and outputs useful information (firmware rev, model number, manufacturer, serial number, baud rates) to the debug console.

### [02_baud_rate_persist.spin2](02_baud_rate_persist.spin2)

Configures a new baud rate into the SIM7600 non-volatile memory. Supported rates range from 300 to 3,686,400 baud.

### [03_signal_strength.spin2](03_signal_strength.spin2)

Gets the cellular signal strength and bit error rate using the built-in RSSI conversion table.
RSSI is in dBm using signed integers.

### [04_operator_scan.spin2](04_operator_scan.spin2)

Scans for network operators, and returns their name and HNI.

### [05_mqtt_subscribe.spin2](05_mqtt_subscribe.spin2)

Subscribes to a topic on a non-SSL MQTT broker. Waits to receive `t`, `h`, or `l` on the `propeller2/io/56` topic to change the state of the pin.

See [MQTT Development](#mqtt-development) for more information

### [06_mqtt_publish.spin2](06_mqtt_publish.spin2)

Publishes small payloads to an MQTT topic.

See [MQTT Development](#mqtt-development) for more information

### [07_mqtt_publish_large.spin2](07_mqtt_publish_large.spin2)

> [!WARNING]
> This example consumes a lot of data and may incur costs on your cellular plan. Use with caution.

Publishes large payloads (10240 bytes) to an MQTT topic.

See [MQTT Development](#mqtt-development) for more information

### [99_mqtt_dht.spin2](99_mqtt_dht.spin2)

IoT data collection example using a DHT22 temperature/humidity sensor.
Sends data at a fixed interval over MQTT.

The example assumes that a DHT22 sensor is connected to pin 4, using 3.3v power.

See [MQTT Development](#mqtt-development) for more information

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
* [ ] Device mode setting (normal, flight, limited, etc)
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

## Resources

Useful documentation for the SIM7600

* [SIMCOM Product Page](https://www.simcom.com/product/SIM7600X.html)
* [Waveshare Module Wiki](https://www.waveshare.com/wiki/SIM7600X_4G_Module)
* [Waveshare Module Schematic](https://www.waveshare.com/w/upload/8/89/SIM7600X_4G_Module.pdf)
* [MQTT(S) Application Note](https://files.waveshare.com/upload/5/50/SIM7500_SIM7600_SIM7800_Series_MQTT_Application_Note_V2.00.pdf)

## Development

This driver is tested using [FlexSpin](https://github.com/totalspectrum/flexprop/). It should still work in PNut.
The project is configured for development in VSCode using the [Spin2 LanguageServer extension](https://marketplace.visualstudio.com/items?itemName=IronSheepProductionsLLC.spin2)

### MQTT Development

The MQTT features of this driver require an MQTT broker to be **configured and forwarded to a public IP/domain**. The SIM7600 modem does not support MQTTv5, and requires a broker that supports MQTTv3.1/MQIsdp3.

The driver currently does not support SSL, so be mindful of the data you send. Username and password authentication is supported.

#### Broker

I have been using a self-hosted [EMQX Enterprise](https://github.com/emqx/emqx) instance for testing. There are open-source options such as [Mosquitto](https://mosquitto.org/), which should work just as well.

#### Client

A desktop client is required for subscribing and publishing to the topics that the P2 is listening on. Some brokers such as EMQX have a builtin web UI that allows you to interact and monitor traffic.

I used [MQTTX](https://mqttx.app/) for testing. It should work with any MQTT broker.

## License

All work is under the MIT license.

This project includes the following community objects:

| Object                    | Author                     | License |
| ------------------------- | -------------------------- | ------- |
| jm_ansi.spin2             | Jon "JonnyMac" McPhalen    | MIT     |
| jm_nstr.spin2             | Jon "JonnyMac" McPhalen    | MIT     |
| jm_prng.spin2             | Jon "JonnyMac" McPhalen    | MIT     |
| jm_dhtxx.spin2            | Jon "JonnyMac" McPhalen    | MIT     |
| jm_fullduplexserial.spin2 | Jon "JonnyMac" McPhalen    | MIT     |
| string.spin2              | Jesse Burt                 | MIT     |
