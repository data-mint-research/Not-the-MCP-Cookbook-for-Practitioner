# 10 Patterns and Recipes

## Warum dieses Kapitel?

Nicht jedes Problem ist neu. In einem MCP-System treten bestimmte Situationen immer wieder auf:

- Ein Agent braucht mehrere Rückfragen.
- Du willst eine neue API sauber einbinden.
- Der Kontext soll automatisch gespeichert werden.
- Du willst von Phase 1 zu 2 wechseln – strukturiert.

Dieses Kapitel liefert dir:
- **bewährte Lösungsansätze** („Patterns“),
- **konkrete Baupläne** („Recipes“),
- **sofort einsatzbereite Prompts**.

---

## 1. Pattern: "Capability Gate"

**Ziel:** Eine Fähigkeit ist registriert, aber nur unter Bedingungen nutzbar.

**Umsetzung:**
- Capability definieren: `tool.shell.run`
- Policy-Regel erstellen: erlaubt nur, wenn `phase >= 2`
- Komponente bleibt registriert, aber inaktiv bei Phase 1

---

## 2. Pattern: "Memory-assisted Prompting"

**Ziel:** Agent verwendet bei jeder Antwort automatisch gespeicherte Informationen.

**Recipe:**
1. Komponente `memory_recall` mit `memory.recall`
2. In `mintycoder`-Server `context += memory.load()` vor Infer
3. Kontext fließt so automatisch in jede Antwort

---

## 3. Pattern: "Self-updating Registry"

**Ziel:** Neue Komponenten registrieren sich selbst.

**Recipe:**
- Komponente liest `component.meta.yaml`
- Trägt sich via POST in `/mcp/registry/register` ein
- Zentraler `registry-manager` aktualisiert `mcp_register.yaml`

---

## 4. Pattern: "Phase Escalation"

**Ziel:** System soll nach erfolgreicher Aktion Phase erhöhen.

**Recipe:**
- Agent führt `tool.phase.advance` aus
- Diese schreibt `"phase": x+1` in `context_store.json`
- Phase-gesteuerte Policies schalten neue Fähigkeiten frei

---

## 5. Recipe: Eigene GUI-Komponente

**Ziel:** Lokale Statusanzeige via TUI oder Webserver

```bash
mcp_components/status_ui/
├── src/app.py
└── component.meta.yaml
```

Endpoint `/ui/status` gibt zurück:
```json
{
  "active_components": [...],
  "current_phase": 2,
  "last_tool": "tool.shell.run"
}
```

---

## Ergebnis

Du kannst jetzt:
- bekannte Probleme mit bewährten Patterns lösen
- typische Abläufe aus Vorlagen (Recipes) erzeugen
- dein System inkrementell erweitern – strukturiert & robust

---

## 🧩 Prompt-Baustein: Recipe anwenden

```
Ich habe folgendes Ziel in meinem MCP-System:

"<z. B. Kontext soll automatisch nach jeder Infer-Antwort gespeichert werden>"

Bitte finde ein passendes Pattern oder Recipe.

Erstelle alle benötigten Komponenten, Regeln oder Modifikationen in folgenden Dateien:
- `mcp_register.yaml`
- `rules/`
- `mcp_components/<name>/`

Stelle sicher, dass alle Teile modular, dokumentiert und testbar sind.
```

---

## Abschluss

🎉 Du hast das komplette **Not-the-MCP-Cookbook-for-Practitioners** durchlaufen:  
Von Setup → Struktur → Komponenten → Fähigkeiten → Policies → Tools → UI → Tests → Rezepte

---

## 🧭 Wie geht's weiter?

👉 Du kannst nun:
- eigene Komponenten entwickeln
- bestehende erweitern oder kombinieren
- einen LLM orchestrieren, der dir MCP-Module erzeugt

Oder du startest mit:

**🧠 Bonus-Kapitel: Self-Evolving Meta-Agent**  
– Wie ein Agent lernt, sich selbst zu verbessern, neue Fähigkeiten zu integrieren und Pläne auszuführen.
