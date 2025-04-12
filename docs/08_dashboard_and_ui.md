# 08 Dashboard and UI

## Warum dieses Kapitel?

Ein MCP-System ist modular, intelligent – und oft unsichtbar.  
Damit du weißt, **was läuft, was wartet, was blockiert ist**, brauchst du eine **sichtbare Oberfläche**:

- Welche Komponenten sind aktiv?
- Welche Fähigkeiten sind registriert?
- Was wurde zuletzt ausgeführt?
- Welche Policies greifen?

In diesem Kapitel lernst du, wie du:
- ein einfaches, aber mächtiges Dashboard erstellst,
- Agentenstatus & Komponentenstatus einsehen kannst,
- Tools für Start/Stopp, Logs und Kontextkontrolle einbaust.

---

## 1. Ziel: Das minimale Control Center

### Basisfunktionen:

| Element             | Beschreibung                         |
|---------------------|--------------------------------------|
| Komponentenliste    | Anzeige aller registrierten Agenten  |
| Fähigkeitenanzeige  | Welche Capabilities sind verfügbar?  |
| Statusmonitor       | Läuft die Komponente?                |
| Aktion: Start/Stop  | Komponente (de)aktivieren            |
| Live-Logs           | Letzte Tool- oder Kontextaktionen     |

---

## 2. Beispiel: Datei `ui/dashboard.py`

```python
from fastapi import FastAPI
from pathlib import Path
import yaml, json

app = FastAPI()

@app.get("/dashboard/components")
def get_components():
    register = yaml.safe_load(Path("config/mcp_register.yaml").read_text())
    return {"components": register}

@app.get("/dashboard/capabilities")
def get_capabilities():
    caps = yaml.safe_load(Path("config/rules/capabilities.rules.yaml").read_text())
    return {"capabilities": caps}

@app.get("/dashboard/status")
def get_status():
    # Beispiel: Nur Dummy-Status
    return {
        "mintycoder": "running",
        "tool_shell": "stopped"
    }
```

> Du kannst mit wenig Code ein komplett JSON-basiertes UI aufbauen – kompatibel mit Web-Frontends, VS Code oder CLI.

---

## 3. Optional: Statusdateien pro Komponente

Jede Komponente kann ihren Status in `ui/status/<id>.json` schreiben:

```json
{
  "id": "mintycoder",
  "status": "running",
  "last_call": "2025-04-12T12:12:00Z",
  "last_action": "infer",
  "uptime": 124
}
```

> Diese Dateien können von GUI oder anderen Services beobachtet werden – Polling oder Websocket.

---

## 4. GUI-Datenmodell

> Wenn du ein visuelles Frontend baust (React, Electron, TUI...), orientiere dich am **UI-Modell**:

```json
{
  "components": [ ... ],
  "capabilities": [ ... ],
  "status": { "agentX": "running", ... },
  "logs": [ ... ],
  "context": { ... }
}
```

> Dieses Modell kann auch automatisch aus dem MCP-System exportiert werden – z. B. über einen UI-Exporter.

---

## 5. Erweiterungen (später möglich)

- Live-Komponentenstart/-stopp via Shell
- Kontexteditor (live .json bearbeiten)
- Regelanzeige und Policy-Prüfer
- Tool-Ausführungen via Webformular (Test-UI)

---

## Ergebnis

Du kannst jetzt:
- deinen Stack beobachten und kontrollieren
- Status und Fähigkeiten visuell darstellen
- ein Dashboard mit Standardtools oder LowCode umsetzen

---

## 🧩 Prompt-Baustein: Dashboard-API erweitern

```
Ich möchte die UI meines MCP-Systems erweitern.

Ziel:
Eine neue Dashboard-API soll die Datei `data/context_store.json` live ausgeben.

Bitte erstelle:
- Eine FastAPI-Route in `ui/dashboard.py`
- Antwortformat: JSON
- Fehlerbehandlung bei nicht vorhandener Datei

Optional: Erstelle ein JSON-Schema für die Datei (Kontextmodell)
```

---

## Nächster Schritt

👉 Kapitel `09_testing_and_debugging.md`:  
Wie du dein System absicherst, validierst und bei Fehlern gezielt nachverfolgen kannst.
