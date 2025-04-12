# 05 Component Creation

## Warum dieses Kapitel?

Im MCP-System wird jede Fähigkeit über eine **eigenständige Komponente** bereitgestellt:  
Ob `infer`, `context.load`, `tool.shell.run` oder ein eigener Planer – alles ist modular.

Statt alles per Hand zu schreiben, kannst du:
- eine neue Komponente vollständig durch einen **Prompt** erzeugen lassen,
- inkl. API-Endpoint, Metadaten, Konfiguration und Test-Stub.

---

## 1. Was gehört zu einer Komponente?

Jede Komponente liegt unter `mcp_components/<name>/` und besteht mindestens aus:

```plaintext
mcp_components/myagent/
├── src/agent.py              → Die ausführbare Logik
├── config.yaml               → Lokale Konfigurationswerte
└── component.meta.yaml       → Selbstbeschreibung für das MCP-System
```

Diese Dateien werden bei der Registrierung automatisch gelesen und mit `structure.rules.yaml` validiert.

---

## 2. Metadaten: component.meta.yaml

```yaml
id: myagent
type: tool_executor
capabilities:
  - tool.shell.run
entrypoint: src/agent.py
requires:
  - python3
  - subprocess
```

Diese Datei ist Pflicht – das Register (`mcp_register.yaml`) liest daraus alle Startinformationen.

---

## 3. Beispiel: Komponente für context.save

```plaintext
mcp_components/context_saver/
├── src/context_saver.py      → FastAPI-Endpoint für /mcp/context/save
├── config.yaml               → Z. B. Pfad zur Datei
└── component.meta.yaml       → capability: context.save
```

```python
@app.post("/mcp/context/save")
async def save(request: Request):
    data = await request.json()
    with open("data/context_store.json", "w") as f:
        json.dump(data, f)
    return {"status": "ok"}
```

Mit nur wenigen Zeilen schaffst du eine systemkompatible, wiederverwendbare Komponente.

---

## 4. Autoload und Registrierung

Deine neue Komponente wird durch die `component.meta.yaml` automatisch erkannt
und durch folgenden Eintrag in `mcp_register.yaml` aktiviert:

```yaml
- id: context_saver
  type: context_agent
  entrypoint: mcp_components/context_saver/src/context_saver.py
  capabilities:
    - context.save
  autostart: true
```

---

## 5. Struktur validieren

Verwende dein Skript `scripts/validate_structure.sh`:

```bash
#!/bin/bash
for dir in mcp_components/*; do
  test -f "$dir/component.meta.yaml" || echo "$dir fehlt Metadaten"
done
```

---

## Ergebnis

Du kannst jetzt:
- eine neue Fähigkeit in eine lauffähige Komponente umsetzen,
- sie automatisch registrieren und nutzen,
- sie per Prompt generieren lassen.

---

## 🧩 Prompt-Baustein: Neue MCP-Komponente generieren

Verwende diesen Prompt, um eine vollständig neue Komponente zu erzeugen:

```
Ich entwickle eine neue MCP-Komponente.

Ziel:
Eine neue Fähigkeit mit der ID `<capability_id>` soll bereitgestellt werden.

Bitte erstelle:
- `component.meta.yaml` mit allen Pflichtfeldern
- `config.yaml` mit sinnvollen Default-Werten
- `src/<name>.py` mit einem lauffähigen FastAPI-Endpoint
- Einen passenden Eintrag für `mcp_register.yaml`

Verzeichnis: `mcp_components/<komponentenname>/`

Format, Pfade und Inhalt sollen MCP-konform, dokumentiert und testbar sein.
```

---

## Nächster Schritt

👉 Kapitel `06_interaction_and_memory.md`:  
Wie Komponenten miteinander kommunizieren und Kontextdaten austauschen.
