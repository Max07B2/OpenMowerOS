# OpenMowerOS

[![OpenMower header](.github/img/open_mower_header.jpg)](https://github.com/ClemensElflein/OpenMower)

This repository contains the official OpenMowerOS (OMOSv2) image for running the [OpenMower](https://github.com/ClemensElflein/OpenMower) project on your OM's Pi/CM.

➡️ What’s new in the latest release? See [WHATSNEW.md](./WHATSNEW.md).

## Reference/Default Information

- **hostname** : openmower (default)

- **username** : openmower (fixed)

- **password**: openmower ***CHANGE IT! (use `passwd` for that)***

- **ssh**: enabled

- **hotspot SSID**: OpenMower-\<somenumber\> (no password)

***

## How to Get Started

Tip: Click a section title to expand/collapse.

<details>
<summary><b>Install OpenMowerOS on your Pi/CM</b></summary>


1. Flash the latest OpenMowerOS v2.x [OpenMowerOS_YYYYMMDD.zip](https://github.com/ClemensElflein/OpenMowerOS/releases) to an SD card or your CM, preferably using [**Raspberry Pi** Imager](https://www.raspberrypi.com/software/).

2. ***Optional: Raspberry Pi Imager configuration***<br>
   When prompted by Raspberry Pi Imager, you can change some custom settings:
   1. As shown here, but the username must be `openmower`.  
   ![General Settings](.github/img/rpimager_general.png)
   2. You may also add your SSH public key for quicker SSH login;
   password login remains active (even if it's an either/or selection).<br>
   ![SSH Settings](.github/img/rpimager_ssh.png)
   
</details>

<details>
<summary><b>First boot and network setup</b></summary>

3. After writing the image, eject the card, insert it into your mower’s Pi or xCore, and turn it on.

4. Your Pi will boot multiple times. Be patient and wait till the green activity LED becomes silent for ≥ 10 seconds.<br>

5. ***Optional: Comitup hotspot (if you skipped step 2 "Raspberry Pi Imager configuration")***<br>
If you didn't enter your Wifi settings when asked for the custom settings during Pi Imager (see step 2), or if you accidentally entered the wrong Wifi settings:

   1. After a short time, an "OpenMower-\<somenumber>" Wifi hotspot should appear. Connect to it.

   2. Once you are connected to the OpenMower-\<somenumber> hotspot, your default browser should open automatically and display the WiFi configuration page (if not, open http://10.41.0.1).

      <p align="center"><img src=".github/img/comitup_hotspot.png" style="width:50%"></p>

   3. Click on your home WiFi, fill in your password and click "SUBMIT".

   4. The hotspot will disappear and the mower should connect to your WiFi.

6. Once the green activity LED becomes silent, try pinging your mower via `ping openmower` (or the hostname you entered during Pi Imager). If the host can't be found, check your router for the mower's IP address.

7. ***Optional:***<br>
   1. If you didn't configure a custom password during step 2 (Raspberry Pi Imager configuration), login via SSH and change your password now via `passwd`.
   2. Use `raspi-config` to change keyboard, timezone, WLAN country and the like (if not configured in Raspberry Pi Imager's custom settings).

 </details>



<details>
<summary><b>Manage OpenMower stack (GUI + CLI)</b></summary>
 
[Dockge](https://dockge.kuma.pet/) (a container manager GUI) and [ttyd](https://tsl0922.github.io/ttyd/) (a web terminal)
are bundled together with the OpenMowerOS image, get unpacked and installed during the final boot step.

Please wait till Pi/xCore’s green LED becomes silent for ≥ 10 seconds.

The WebTerminal is available as a lightweight alternative to SSH for running the same commands.
It can be reached via `http://openmower:7681` (adjust if you changed the hostname).

For each relevant GUI action, a CLI alternative is available via a powerful `openmower` command; both are listed below.

1. Connect to the container manager:
   - CLI:
     - SSH into your Pi: `ssh openmower@openmower` (or your configured hostname).
     - WebTerminal via URL `http://openmower:7681` (or your configured hostname).
   - GUI: Open <http://openmower:5001> (or your individual hostname if changed)

2. Configure the stack (.env)
   - CLI: `openmower configure env`
   - GUI:
       ![Select and Edit Stack](.github/img/dockge_02_select_and_edit.jpg)
       ![Edit .env](.github/img/dockge_03_edit.jpg)
       ![Save .env](.github/img/dockge_04_save.jpg)

3. Start the stack (including the initial pull)
    - CLI: If you configured your .env file via `openmower configure env` then the stack is pulled and started automatically.
    - GUI:
       ![Start Stack](.github/img/dockge_05_start.jpg)

4. Check status and open the OpenMower web app
   - CLI: `openmower status` should list three services (open_mower_ros, Mosquitto and OpenMowerApp), all with status 'up'. If so, open a browser and visit `http://openmower:8080` (or your configured hostname).
   - GUI:
       ![Stack Active](.github/img/dockge_06_active.jpg)

5. Configure the ROS parameters (CLI only for now): `openmower configure ros` and:
   
   1. Adapt section `gps` to your needs, but set at least `datum_lat` and `datum_lon` to the corresponding lat/lon values near your docking station. Use right‑click in [Google Maps](https://maps.google.com) to get them.
   2. `ntrip_client` settings with the ones from your local RTK base or from your public NTRIP service.
   3. Once (and not before 🩸) you have validated your emergency sensors, set `enable_mower` to true.

</details>

