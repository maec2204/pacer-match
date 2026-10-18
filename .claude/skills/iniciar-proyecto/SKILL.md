---
name: iniciar-proyecto
description: Sesión S0 del método de sesiones de Moisés. Llena contexto, plan, fases, glosario y CLAUDE.md de un repo creado desde plantilla-proyecto, o adopta el método en un repo que ya existe. Usar cuando pida iniciar un proyecto, la sesión S0 o /iniciar-proyecto.
argument-hint: "[nombre del proyecto]"
---

# Iniciar proyecto (sesión S0)

Función única: dejar el proyecto listo para la S1. No se escribe código del producto ni se resuelven decisiones de diseño; se anotan como decisiones abiertas.

## 1. Ubicarse
- Busca `docs/proyecto/reglas-de-sesion.md`.
  - Existe y `docs/proyecto/contexto.md` todavía tiene `{{`: repo nuevo de la plantilla. Sigue.
  - Existe y no tiene `{{`: el proyecto ya está iniciado. Dilo y para.
  - No existe (repo con código o Project sin repo): copia de `maec2204/plantilla-proyecto` las carpetas `docs/proyecto/`, `vault/` y `.claude/skills/`, y `CLAUDE.md` si el repo no tiene uno (si tiene, agrégale arriba la línea que manda leer las reglas). Si no tienes acceso a ese repo, pide a Moisés que las copie.
- Si el repo tiene código, léelo antes de preguntar: README, manifiestos (`package.json`, `pyproject.toml`, `go.mod`, `Cargo.toml`, `pubspec.yaml`…), CI e infraestructura. Lo que se deduce de ahí no se pregunta; se confirma en la ronda.

## 2. Una sola ronda de preguntas
Todas juntas, en un mensaje (con AskUserQuestion si está disponible). Solo lo que falte:
1. Qué es el proyecto y para quién, en 2–3 líneas.
2. Objetivo inmediato: qué tiene que existir y para cuándo.
3. Quién más participa y con qué rol (PO, devs, clientes).
4. Stack y dónde se despliega.
5. Dónde viven las tareas: Linear, GitHub Issues, GitLab o ninguno.
6. Qué no entra por ahora.
7. Cuántas horas por semana le da Moisés y si hay costos que alguien deba aprobar.

No inventes respuestas. Lo que no se conteste queda como decisión abierta en `contexto.md`, con propuesta por defecto y la sesión que la cierra.

## 3. Llenar
- `docs/proyecto/contexto.md`: las secciones de la plantilla, solo con hechos dichos por Moisés o leídos del repo. Máx. 150 líneas.
- `docs/proyecto/plan.md`: objetivo, qué entra, qué no, cómo se sabe que funcionó y costos (rango o "estimado").
- `docs/proyecto/fases.md`: S1…SN, cada una con una sola función, 1–2 h y un "hecho cuando" comprobable; si pasan de ~10, agrúpalas en bloques. Marca la S0 como hecha y escribe el orden de recorte.
- `vault/glosario.md`: los términos de negocio que aparecieron, con su nombre en el código si existe.
- `CLAUDE.md`, el título de `docs/proyecto/reglas-de-sesion.md` y `vault/00-inicio.md`: reemplaza `{{nombre-del-proyecto}}`, `{{fecha}}` y los demás `{{…}}`.
- `README.md`: cambia el de la plantilla por uno del proyecto: qué es, estado y cómo se trabaja (las sesiones arrancan con «Sesión SN. Lee `docs/proyecto/reglas-de-sesion.md` y síguelo.»).

## 4. Cerrar
- Comprueba que no queden huecos: `grep -rn "{{" docs vault CLAUDE.md README.md | grep -v "vault/plantillas/"` no devuelve nada. Las plantillas del vault conservan `{{date}}` y `{{title}}` a propósito: son variables de Obsidian.
- Agrega la entrada S0 arriba de `docs/proyecto/bitacora.md` (regla 10).
- Commit `docs: S0, proyecto iniciado`. Si no hay repo, entrega los archivos que cambiaron.
- Responde en 3 líneas: qué quedó, las decisiones abiertas más urgentes y cómo arrancar la S1.

## Hecho cuando
- No queda `{{` fuera de `vault/plantillas/`.
- `fases.md` tiene al menos la S1 con un "hecho cuando" comprobable.
- La bitácora tiene la entrada S0, y existe el commit o se entregaron los archivos.
