# 07 Tools and Execution

## Warum dieses Kapitel?

Bisher konnte dein Agent nur:
- Fragen beantworten,
- sich erinnern,
- Anfragen strukturieren.

Jetzt lernt er, **tatsächlich Dinge zu tun**:
- Shell-Befehle ausführen,
- Dateien lesen/schreiben,
- externe APIs aufrufen,
- ... und das alles kontrolliert, abgesichert und protokolliert.

---

## 1. Das Konzept: Fähigkeiten als Tools

### Fähigkeit: `tool.shell.run`

Agenten, die diese Fähigkeit besitzen, dürfen vorbereitete Shell-Kommandos ausführen – z. B.:

```json
{
  "command": "ls -la ~/Documents/projects/"
}
```

> Die Ausführung erfolgt über eine spezialisierte Komponente, nicht direkt durch den Agenten selbst.

---

## 2. Beispiel-Komponente: Shell Executor

```plaintext
mcp_components/tool_shell/
├── src/tool_shell.py
├── config.yaml
└── component.meta.yaml
```

### Beispiel-Endpoint:

```python
@app.post("/mcp/tool/shell/run")
async def shell(request: Request):
    data = await request.json()
    command = data.get("command", "")
    try:
        result = subprocess.check_output(command, shell=True, stderr=subprocess.STDOUT, timeout=5)
        return {"output": result.decode("utf-8")}
    except Exception as e:
        return {"error": str(e)}
```

---

## 3. Absicherung: Policies und Dry-Run

Du kannst in `permissions.rules.yaml` Einschränkungen definieren:

```yaml
- if: command.contains("rm")
  then: deny
```

Oder in `config.yaml` der Komponente einen **dry_run-Modus** aktivieren:

```yaml
dry_run: true
```

---

## 4. Erweiterbare Tool-Arten

Du kannst beliebig viele Tool-Fähigkeiten hinzufügen:

| Capability          | Beschreibung                                |
|---------------------|---------------------------------------------|
| `tool.api.get`      | Ruft GET-API mit Parametern auf             |
| `tool.file.read`    | Liest Datei aus gegebenem Pfad              |
| `tool.file.write`   | Schreibt Text in Zieldatei                  |
| `tool.validate.yaml`| Prüft YAML auf Syntax & Struktur            |

> Tools können beliebig tief verschachtelt und kombiniert werden.  
> Wichtig ist: Jede Fähigkeit ist registriert und überprüfbar.

---

## 5. Logging & Rückmeldung

Du kannst alle Aktionen in `data/tool_log.json` speichern:

```json
{
  "timestamp": "2025-04-12T12:34:00",
  "agent": "mintycoder",
  "action": "tool.shell.run",
  "command": "ls -la",
  "result": "OK"
}
```

---

## Ergebnis

Du kannst jetzt:
- Tools sicher über Agenten ansprechen
- Ausführbare Aktionen strukturieren und begrenzen
- Den Handlungsraum vollständig kontrollieren

---

## 🧩 Prompt-Baustein: Neue Tool-Komponente definieren

```
Ich möchte in meinem MCP-System eine neue Tool-Komponente hinzufügen.

Ziel: Die Fähigkeit `<tool.file.write>` soll bereitgestellt werden.

Bitte erstelle:
- `component.meta.yaml` (capability, entrypoint, type: tool)
- `src/<tool>.py` mit FastAPI-Handler
- Logging-Ausgabe in `data/tool_log.json`
- Optional: dry_run-Konfiguration in `config.yaml`

Pfad: `mcp_components/tool_file_writer/`
```

---

## Nächster Schritt

👉 Kapitel `08_dashboard_and_ui.md`:  
Wie du den Systemstatus, Komponenten-Status, Logs und Fähigkeiten visualisierst.
