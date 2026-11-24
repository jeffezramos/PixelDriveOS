# Pixel Drive OS

> **A lightweight, open-source automotive operating system inspired by Google Pixel and Android Auto, engineered for smooth native performance on entry-level head-units.**

Developed and architected by **Jefferson da Silva Ramos**.

---

## Overview

Most aftermarket Android head-units (such as Allwinner T3 Quad-Core platforms with 2GB RAM) suffer from severe lag when running bloated factory firmwares alongside heavy screen-mirroring servers.

**Pixel Drive OS** solves this by replacing the heavy stock environment with a clean, **Material You (Material 3)** native automotive OS:
* **Zero Mirroring Bottleneck:** Uses your smartphone strictly as a connectivity bridge (Wi-Fi Hotspot for data + Bluetooth A2DP/HFP for audio and calls).
* **Native Vehicle Telemetry (CAN Bus):** Communicates directly with the vehicle's CAN Bus decoder (Raise / UART) to display real-time alerts—such as open doors, parking brake status, and reverse gear—directly on the dashboard.
* **Optimized for 2GB RAM:** Aggressive background debloat and hardware-accelerated Jetpack Compose UI running smoothly at `1280x720`.

## Target Reference Hardware & Vehicle
* **Head-Unit Platform:** K2001N (`Allwinner T3 Quad-Core`, 2GB RAM, 32GB eMMC, `1280x720` LCD)
* **MCU / Radio Module:** `V3.7-FF01` / `XR829` Wi-Fi & BT Combo
* **Reference Vehicle:** Hyundai HB20 Unique 1.0 (2019) via Raise CAN Bus Box

## Repository Architecture
* `pixeldrive-launcher/` — Material You automotive dashboard, media player, and app dock.
* `pixeldrive-can-service/` — Background serial listener translating vehicle CAN frames into Android system events.
* `pixeldrive-system-overlay/` — Custom Pixel-inspired SystemUI, boot animation, and signed `build.prop` overlays.
* `scripts/windows/` — PowerShell automation tools for ADB backup, debloating, and `update.zip` signing.

## License & Attribution
Licensed under the **Apache License, Version 2.0**. See `LICENSE` and `NOTICE` for full terms.
