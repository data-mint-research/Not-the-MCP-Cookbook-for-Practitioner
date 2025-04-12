# 01 Getting Started

## Ziel dieses Kapitels

In diesem Abschnitt richtest du deine lokale Umgebung so ein, dass du MCP-kompatible Komponenten entwickeln, testen und ausführen kannst.

Du erhältst:
- eine lauffähige Minimalversion des MCP-Stacks („MCP-LOCAL"),
- einen funktionierenden Inferenzserver mit DeepSeek oder Mistral via Ollama,
- ein nachvollziehbares Dateisystem mit Trennung von Code, Kontext und Regeln.

---

## Voraussetzungen

| Tool       | Zweck                            |
|------------|----------------------------------|
| macOS/Linux (Windows via WSL) | Lokale Umgebung                  |
| Git        | Repos klonen und versionieren     |
| Python 3.10+ | Für MCP-Server & Komponenten    |
| [Ollama](https://ollama.com) | Lokaler LLM-Zugriff (Mistral etc.) |
| VS Code + Cursor/Continue | IDE + Coder AI (optional, empfohlen) |

---

## Schritt 1: Projektverzeichnis anlegen

```bash
cd ~/Documents/projects
mkdir -p MCP-LOCAL
cd MCP-LOCAL
```

---

## Schritt 2: Ollama installieren (falls nicht vorhanden)

```bash
brew install ollama
```

> Oder besuche: https://ollama.com/download (GUI-Installer für macOS)

---

## Schritt 3: Modell laden

```bash
ollama pull deepseek-coder:6.7b
# oder:
ollama pull mistral
```

---

## Schritt 4: MCP-Serverstruktur initialisieren

```bash
mkdir -p mcp_servers/llm_server/src
mkdir -p config/rules
touch mcp_servers/llm_server/src/server.py
touch mcp_servers/llm_server/config.yaml
touch mcp_servers/llm_server/component.meta.yaml
touch config/mcp_register.yaml
```

> Die Struktur wird in Kapitel 02 im Detail erklärt.

---

## Schritt 5: Python-Umgebung einrichten

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install fastapi uvicorn pyyaml
```

---

## Schritt 6: Server starten

Beispielhafter Start eines MCP-Inferenzservers (Kapitel 03 erklärt den Code):

```bash
cd mcp_servers/llm_server
python3 src/server.py
```

---

## Schritt 7: Testen

Testaufruf via CURL:

```bash
curl -X POST http://127.0.0.1:8000/mcp/infer \
  -H "Content-Type: application/json" \
  -d '{"context": "Schreibe eine Python-Funktion, die eine Zahl quadriert."}'
```

> Du solltest eine generierte Funktion als Antwort erhalten.

---

## Ergebnis

Wenn du dieses Kapitel abgeschlossen hast, ist dein Projekt:

- lokal startfähig,
- mit einem LLM verbunden,
- bereit für die erste MCP-Komponente.

---

## Nächster Schritt

👉 Fahre fort mit **02_project_structure.md**, um das zentrale Dateisystem, die Regeln und Präfixe kennenzulernen.

> Mit diesem Prompt kannst du die Projektstruktur jederzeit sinnvoll erweitern – auch durch Agenten gesteuert.
