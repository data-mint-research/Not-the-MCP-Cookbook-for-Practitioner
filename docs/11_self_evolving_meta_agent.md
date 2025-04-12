# Bonus: Self-Evolving Meta-Agent (SEMA)

## Ziel dieses Kapitels

Du lernst, wie du einen Agenten entwickelst, der:
- **sich selbst verbessern kann** (Self-Evolution),
- **eigene Fähigkeiten erweitert**,
- **andere Komponenten orchestriert**,
- **alle Entscheidungen nachvollziehbar dokumentiert**.

Der SEMA-Agent ist das zentrale Nervensystem eines fortgeschrittenen MCP-Systems.

---

## 1. Überblick: Was ist ein Self-Evolving Agent?

| Fähigkeit                  | Beschreibung                                               |
|----------------------------|------------------------------------------------------------|
| `plan.create`              | Erstellt To-dos auf Basis eines Ziels                     |
| `plan.execute`             | Steuert andere Komponenten anhand eines Plans             |
| `plan.adapt`               | Verfeinert Plan nach Fehlern, Rückmeldungen oder Fortschritt |
| `capability.extend`        | Registriert neue Fähigkeiten und Komponenten              |
| `self.reflection`          | Bewertet eigene Antworten, trifft Metaentscheidungen      |

---

## 2. Komponentenstruktur des SEMA

```plaintext
mcp_components/sema/
├── src/
│   ├── planner.py         → plant Aufgaben anhand Kontext
│   ├── executor.py        → steuert Komponenten
│   ├── evaluator.py       → bewertet Ergebnisse
│   └── registry_updater.py→ fügt neue Fähigkeiten hinzu
├── config.yaml
└── component.meta.yaml
```

---

## 3. Registerintegration

```yaml
- id: sema
  type: orchestrator
  entrypoint: mcp_components/sema/src/planner.py
  capabilities:
    - plan.create
    - plan.execute
    - plan.adapt
    - capability.extend
    - self.reflection
  autostart: true
```

---

## 4. Beispiel: Vom Ziel zum Plan

**Input-Kontext:**
```json
{
  "user_goal": "Erzeuge ein Tool, das den Kontext speichert",
  "phase": 2
}
```

**Output-Plan (`data/current_plan.json`):**
```json
[
  { "step": "create_component", "target": "context_saver" },
  { "step": "define_capability", "target": "context.save" },
  { "step": "generate_code", "template": "store_context_to_file" },
  { "step": "test_component", "target": "context_saver" },
  { "step": "register_capability", "target": "context.save" }
]
```

---

## 5. Ausführung (plan.execute)

Der Executor ruft nach Plan Schritt für Schritt andere Komponenten auf:  
- `/mcp/component/generate` → erzeugt Code  
- `/mcp/register/update` → fügt ID ein  
- `/mcp/test/run` → validiert neue Komponente  

> Fehler führen automatisch zu `plan.adapt` → Plan wird angepasst.

---

## 6. Selbstreflexion (optional)

Mit `self.reflection` kannst du Bewertungen einbauen:

```json
{
  "step_id": "generate_code",
  "result": "failed",
  "reason": "Syntax error in generated script",
  "action": "retry_with_alternative_template"
}
```

---

## 7. Policies für Autonomie

In `permissions.rules.yaml` kannst du steuern, **wie autonom** SEMA agieren darf:

```yaml
- if: phase < 3
  then: deny
  capabilities:
    - capability.extend
```

---

## Ergebnis

Mit dem SEMA-Agenten kannst du:
- Ziele formulieren statt Befehle geben,
- neue Fähigkeiten schrittweise integrieren lassen,
- dein System selbstständig wachsen lassen,
- jederzeit nachvollziehen, **was, wann, warum passiert ist**.

---

## 🧩 Prompt-Baustein: SEMA einsetzen

```
Ich arbeite mit einem MCP-System und möchte einen Self-Evolving Meta-Agent einsetzen.

Ziel:
Ein Agent soll auf Basis von Kontext ein Ziel erkennen, einen Plan erstellen und passende Komponenten erzeugen.

Bitte:
- erstelle alle notwendigen Dateien unter `mcp_components/sema/`
- trage den Agenten in `mcp_register.yaml` ein
- speichere aktuelle Pläne in `data/current_plan.json`
- verwende bestehende Fähigkeiten (context.save, capability.extend)
- dokumentiere Entscheidungen und Fortschritt
```

---

## Nächster Schritt

🚀 Du kannst SEMA nun als zentrale Komponente verwenden.  
Er steuert alles – du gibst nur noch ein Ziel ein.

Empfohlene Kombination:
- Zielvorgabe via `context.user_goal`
- Plan speichern unter `data/current_plan.json`
- Statusanzeige im Dashboard (`/dashboard/sema`)

---

## 🎓 Abschluss des Practitioner Cookbooks

Du hast jetzt alles, um:
- ein MCP-System vollständig zu verstehen,
- Komponenten strukturiert zu entwickeln,
- und mit **SEMA** ein System zu bauen, das sich weiterentwickelt.
