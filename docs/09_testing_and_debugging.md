# 09 Testing and Debugging

## Warum dieses Kapitel?

Ein modulares System wie MCP ist nur dann robust, wenn:
- du Änderungen systematisch testen kannst,
- Komponenten sich erwartungsgemäß verhalten,
- Fehler nicht nur auffallen, sondern auch analysierbar sind.

In diesem Kapitel lernst du:
- wie du einzelne Komponenten testest (Unit & Integration),
- wie du Struktur & Registrierung automatisch validierst,
- wie du Logs & Kontextdateien zur Fehlersuche nutzt.

---

## 1. Komponenten testen: FastAPI direkt prüfen

Jede Komponente lässt sich mit `curl` oder einem einfachen Testskript prüfen:

### Beispiel: `test_infer.sh`

```bash
#!/bin/bash
curl -X POST http://localhost:8000/mcp/infer \
  -H "Content-Type: application/json" \
  -d '{"context": "Was ist eine rekursive Funktion in Python?"}'
```

> Platziere solche Tests in `tests/` – z. B. `tests/test_infer.sh`

---

## 2. Automatisierte Strukturvalidierung

### Beispiel: `scripts/validate_structure.sh`

```bash
#!/bin/bash
echo "🔍 Prüfe Komponentenverzeichnisse..."

for d in mcp_components/*; do
  test -f "$d/component.meta.yaml" || echo "❌ $d fehlt component.meta.yaml"
  test -f "$d/config.yaml" || echo "❌ $d fehlt config.yaml"
  test -d "$d/src" || echo "❌ $d fehlt src-Verzeichnis"
done
```

> Ergänze diese Prüfung um weitere Regeln aus `structure.rules.yaml`.

---

## 3. API-Tests mit Python

```python
import requests

def test_context_save():
    r = requests.post("http://localhost:8000/mcp/context/save", json={"phase": 2})
    assert r.status_code == 200
```

> Platziere solche Tests in `tests/test_context.py`

---

## 4. Debugging über Logs

Alle kritischen Komponenten (z. B. Tools, Memory) können Logs in `data/` schreiben:

```plaintext
data/
├── tool_log.json
├── memory_store.json
└── debug_context.json
```

Du kannst einen zentralen Debug-Logger anlegen, der alle Aktionen mitspeichert.

---

## 5. CI-Vorbereitung (optional)

Wenn du möchtest, kannst du alle Skripte in einem Runner bündeln:

```bash
chmod +x scripts/*.sh
./scripts/validate_structure.sh
pytest tests/
```

> So wird dein Stack bei jedem Update validiert und bleibt konsistent.

---

## Ergebnis

Du kannst jetzt:
- jede Komponente separat testen
- Systemstruktur automatisch prüfen lassen
- Logs gezielt zur Analyse verwenden
- auf Wunsch CI/CD vorbereiten

---

## 🧩 Prompt-Baustein: Testskript oder Prüfroutine erzeugen

```
Ich möchte ein Testskript für eine MCP-Komponente erzeugen.

Komponente: <z. B. context_saver>
Pfad: /mcp/context/save
Methode: POST
Eingabe: JSON, z. B. { "phase": 1 }

Bitte erstelle:
- `tests/test_<name>.sh` mit curl-Aufruf
- Optional: eine `pytest`-Variante mit Response-Prüfung
- Ausgabe soll "Test erfolgreich" oder Fehler enthalten
```

---

## Nächster Schritt

👉 Kapitel `10_patterns_and_recipes.md`:  
Wiederverwendbare Lösungen für typische Aufgaben – als Blueprint, Template oder Prompt.
