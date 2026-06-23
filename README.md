# SOC Automation Lab

> Automated SIEM/SOAR pipeline — Internship project @ SMALTER, Rabat

![Wazuh](https://img.shields.io/badge/SIEM-Wazuh-blue)
![Shuffle](https://img.shields.io/badge/SOAR-Shuffle-orange)
![TheHive](https://img.shields.io/badge/IRP-TheHive-yellow)
![VirusTotal](https://img.shields.io/badge/TI-VirusTotal-green)

---

## Overview

Built from scratch during a 5-week technical internship at **SMALTER** (InfoSec/SOC division).
The goal: can a malicious activity on a Windows endpoint trigger a full response chain — alert, enrichment, incident creation, analyst notification — **with zero human intervention**?

**Answer: yes. In under 30 seconds.**

---

## Stack

- **Wazuh** — SIEM, custom detection rules (PCRE2), Sysmon integration
- **Sysmon v15.20** — Windows telemetry (Event ID 1, 3, 7, 10)
- **Shuffle** — SOAR workflow (webhook → parse → VT → TheHive → email)
- **TheHive 4.1.24** — Case management (Docker)
- **VirusTotal API v3** — IOC enrichment
- **Elasticsearch** — TheHive backend storage
- **Docker Compose** — Container orchestration

- ---

## Detection Rules

| Rule ID | Level | Description |
|---------|-------|-------------|
| 92212   | 14    | Suspicious PowerShell compression (mimikatz.zip) |
| 92910   | 12    | Abnormal process memory access (OneDrive → Explorer) |
| 100002  | 15    | Mimikatz detected by original filename (custom rule) |

Custom rule targets `originalFileName` — effective even if the binary is renamed.

---

## Validation — Mimikatz Simulation

**Result:** Email alert received in Outlook in **< 30 seconds**, automatically.
TheHive case pre-filled with: title, severity (High), observables, VirusTotal score.

---

## Key Challenges Solved

| Issue | Solution |
|-------|----------|
| TheHive v3 Docker image broken | Migrated to `thehiveproject/thehive4` |
| Shuffle cloud cant reach private TheHive | Deployed Shuffle locally, freed port 9200 |
| Mimikatz deleted by Defender | Shifted detection to download activity (rule 92212) |
| RAM crashes (3.8 GB machine) | JVM optimization + sequential service startup |


---

## Author

**Chand Nisar** — 4th year Cybersecurity student @ UIR Rabat
Internship: SMALTER, InfoSec/SOC division — Supervisor: M. Hamza El Orf

---

## References

- [Wazuh Documentation](https://documentation.wazuh.com)
- [TheHive Project](https://thehive-project.org)
- [Shuffle](https://shuffler.io)
- [Sysmon — Microsoft Sysinternals](https://docs.microsoft.com/en-us/sysinternals/downloads/sysmon)
- [MITRE ATT&CK T1003](https://attack.mitre.org/techniques/T1003)
