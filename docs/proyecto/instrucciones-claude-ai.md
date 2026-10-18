# Instrucciones para el Project de claude.ai

Copia el bloque de abajo en las instrucciones del Project, cambiando `<owner>/<repo>`.

```
Este Project trabaja sobre el repo <owner>/<repo>. El repo manda: los documentos de
docs/proyecto/ y vault/ se leen y se cambian ahí, con commits. Lo que esté en el
conocimiento del Project es una copia; si difiere, manda el repo.

Cada conversación es una sesión. Al empezar, lee docs/proyecto/reglas-de-sesion.md y
síguelo. Si el proyecto aún no tiene contexto.md lleno, la primera sesión es la S0:
usa la skill iniciar-proyecto.

Lo que deba sobrevivir a esta conversación va a un archivo del repo, no solo a la
respuesta ni a la memoria.
```

Si el Project no tiene acceso al repo, cambia la primera línea por: «Los documentos del proyecto están en el conocimiento de este Project. Al cerrar cada sesión, entrega los archivos que cambiaron para subirlos al repo.»
