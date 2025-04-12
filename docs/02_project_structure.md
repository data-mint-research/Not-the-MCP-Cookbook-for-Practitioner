# 02 Project Structure

## Warum dieses Kapitel?

Bevor du Module entwickeln, Komponenten registrieren oder Regeln festlegen kannst, musst du verstehen, **wo und wie alles im Projekt abgelegt wird**.

Diese Seite erklärt dir:
- die **Grundstruktur** deines MCP-Projekts,
- die **Systemlogik hinter Präfixen, Regeln und Registrierungen**,
- wie du **eigene Strukturelemente oder Regeln einfügen kannst** – vollständig automatisierbar.

Am Ende bekommst du einen Prompt-Baustein, mit dem du neue Verzeichnisse oder Regeln systemkonform erstellen lassen kannst.

---

## 1. Projektübersicht: Wo liegt was?

```plaintext
MCP-LOCAL/
├── config/                  → Regeln, Register, Policies
├── mcp_components/         → Deine lauffähigen Komponenten (Agenten, Tools, Server)
├── data/                   → Laufzeitdaten, Kontext, Memory
├── scripts/                → Hilfs-Skripte (Setup, Test, Bereinigung)
├── ui/                     → Lokales Dashboard oder API-Oberfläche
├── tests/                  → Testlogik für alle Komponenten
└── docs/                   → Technische Dokumentation (optional)
```

---

## 2. Die 7 Strukturelemente im Überblick

| Ordner             | Zweck                                              | Typische Inhalte                  |
|--------------------|-----------------------------------------------------|-----------------------------------|
| `config/`          | Zentrale Regeln und Registrierung                   | `mcp_register.yaml`, `rules/`     |
| `mcp_components/`  | Alle registrierbaren MCP-Komponenten                | `src/`, `config.yaml`, `meta.yaml`|
| `data/`            | Kontextstatus, Zwischenspeicher, Memory-Snapshots   | `context_store.json`              |
| `scripts/`         | Setup, Reset, Aggregation, Validierung              | `setup_phase1.sh`, `validate.sh`  |
| `ui/`              | Interface, Statusanzeige, Visualisierung            | `dashboard.py`, `ui.status.json`  |
| `tests/`           | Test- und Validierungslogik                         | `test_infer.sh`, `*.py`           |
| `docs/`            | (Optional) Technische Dokumentation, Konzepte       | `architektur.md`, `glossary.md`   |

---

## 3. Systematische Regeln: `config/rules/`

Das MCP-System ist regelgetrieben. Du findest alle Regeldateien hier:

### Beispielhafte Dateien:
- `naming.rules.yaml`: Definiert ID-Syntax, Datei- und API-Namen
- `structure.rules.yaml`: Legt Pflichtverzeichnisse und -dateien fest
- `capabilities.rules.yaml`: Listet erlaubte Fähigkeiten und Kontextoperationen
- `permissions.rules.yaml`: Steuert Zugriff nach Phase, Agent oder Zustand

> Jede Regeldatei ist **maschinenlesbar**, **modular**, und kann vom System oder einem LLM interpretiert werden.

---

## 4. Aggregiertes Regelwerk: `mcp_rules_aggregated.yaml`

Wenn du dein Regelwerk gebündelt exportieren willst, z. B. für:
- Agenteninitialisierung
- externe Analyse
- Dashboard-Darstellung

… dann nutze `mcp_rules_aggregated.yaml` in der Root. Dieser wird aus den Einzeldateien erzeugt:

```bash
cat config/rules/*.rules.yaml > config/mcp_rules_aggregated.yaml
```

---

## 5. Komponentenregistrierung: `mcp_register.yaml`

Jede lauffähige Komponente (Agent, Server, Tool-Modul) wird in dieser Datei eingetragen:

```yaml
- id: mintycoder
  type: llm_agent
  entrypoint: http://localhost:8001/mcp/infer
  capabilities:
    - infer
    - context.load
    - tool.shell.run
  autostart: true
  monitor: true
```

Das System erkennt neue Komponenten **ausschließlich über diese Registrierung**.

---

## 6. Beispiel: Neue Komponente anlegen

```plaintext
mcp_components/myagent/
├── src/agent.py
├── config.yaml
└── component.meta.yaml
```

> Alle diese Dateien werden über `structure.rules.yaml` definiert.  
> Ein Agent oder LLM-Coder kann so neue Komponenten automatisch korrekt anlegen.

---

## Ergebnis nach dieser Seite

Du kannst jetzt:
- die Verzeichnisstruktur verstehen und nutzen,
- neue Komponenten oder Regeln korrekt einfügen,
- alles mit Regeln und Präfixen nachvollziehbar machen.

---

## 🧩 Prompt-Baustein: Neue Struktur oder Regel erzeugen

Nutze diesen Prompt, um neue Projektteile automatisch durch ein LLM erzeugen zu lassen:

```

---

## Nächster Schritt

👉 Kapitel `04_capabilities_and_policies.md`:  
Wie Fähigkeiten kontrolliert, limitiert oder freigegeben werden – und wie man systemische Policies umsetzt.