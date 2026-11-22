# Refugio ante el Tornado — Menú y publicación

1. Importar `project.godot` en Godot 4.3. Ejecutar F5: ahora aparece `StartMenu.tscn`.
2. Los botones del diseño son zonas transparentes interactivas. JUGAR abre `Main.tscn`; CÓMO JUGAR y otros muestran diálogos; SALIR cierra el juego en escritorio.
3. Para Web: Editor > Administrar plantillas de exportación, instalar plantillas de Godot 4.3. Proyecto > Exportar > Añadir > Web. Ruta: `web/index.html`. Exportar proyecto (no exportar PCK separado).
4. Subir el proyecto a GitHub (sin `.godot/`). En Vercel, importar el repositorio, framework `Other`, sin build command; carpeta raíz del repositorio. `vercel.json` redirige a `web/index.html`.
5. El directorio `web/` no existe todavía: se genera al exportar en Godot. Debe incluir index.html, .wasm, .pck, .js y archivos auxiliares. Subirlo a GitHub.
6. Godot Web requiere compatibilidad del navegador y cabeceras adecuadas para ciertas funciones; comprobar consola y probar en Chrome/Edge.
7. El ZIP parte de la versión anterior. Si modificaste el rescate de 4 a 15 en tu copia local, vuelve a aplicar esos cambios o copia los archivos `game_manager.gd`, `player.gd` y `hud.gd` desde tu versión funcional antes de publicar.
