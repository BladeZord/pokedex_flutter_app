# Mi Primera Aplicación en Flutter - Pokédex

## Descripción

Este proyecto consiste en una aplicación móvil desarrollada con **Flutter** llamada **Pokédex**.

La aplicación permite consultar información de diferentes Pokémon obtenidos desde una API pública externa. En la pantalla principal se muestra una lista de Pokémon con su imagen, nombre y tipo. Al seleccionar uno de ellos, el usuario puede acceder a una pantalla de detalle donde se muestra información adicional como sus estadísticas y descripción.

> Este repositorio **continúa la misma aplicación** en la **Actividad Integradora 2**. La documentación original de la Actividad Integradora 1 se mantiene en las secciones siguientes. Las mejoras nuevas están en [Actividad Integradora 2](#actividad-integradora-2).

---

# Objetivo

Desarrollar una aplicación básica utilizando Flutter que permita aplicar los conocimientos iniciales relacionados con:

- Creación de un proyecto Flutter.
- Uso de widgets básicos.
- Construcción de interfaces utilizando Material Design.
- Uso de `MaterialApp`, `Scaffold` y `AppBar`.
- Organización del código en archivos y carpetas.
- Consumo de información desde una API externa.
- Instalación y utilización de un paquete externo.
- Ejecución de la aplicación en un navegador y emulador Android.
- Uso de Git y GitHub para el control de versiones.

---

# Tema de la aplicación

El tema seleccionado para la aplicación es una **Pokédex**.

La aplicación permite visualizar información de diferentes Pokémon y consultar sus características principales.

Entre las funcionalidades implementadas se encuentran:

- Visualización de una lista de Pokémon.
- Consulta de imágenes.
- Visualización de tipos.
- Acceso a una pantalla de detalle.
- Visualización de estadísticas.
- Visualización de información adicional.
- Botón para volver a cargar la información.
- Consumo de datos desde una API externa.

---

# Tecnologías utilizadas

El proyecto fue desarrollado utilizando las siguientes tecnologías:

- Flutter.
- Dart.
- Material Design.
- Git.
- GitHub.
- Android Emulator.
- Visual Studio Code.

---

# Creación del proyecto

El proyecto fue creado utilizando Flutter.

Un proyecto Flutter puede crearse desde la terminal utilizando el siguiente comando:

```bash
flutter create pokedex_flutter_app
```

Posteriormente se puede acceder al directorio del proyecto:

```bash
cd pokedex_flutter_app
```

Para ejecutar la aplicación:

```bash
flutter run
```

---

# Verificación de la instalación de Flutter

Antes de comenzar el desarrollo se verificó la instalación y configuración del entorno mediante el comando:

```bash
flutter doctor
```

Este comando permite comprobar que las herramientas necesarias para desarrollar aplicaciones Flutter se encuentren correctamente instaladas y configuradas.

La evidencia de esta verificación se encuentra en la carpeta `docs`.

## Evidencia

![Validación de Flutter](docs/02_validacion_instalacion_flutter.png)

---

# Ejecución del proyecto

El proyecto fue ejecutado inicialmente desde Visual Studio Code.

También se realizaron pruebas en:

- Navegador web.
- Vista móvil.
- Emulador Android.

## Ejecución inicial en navegador

![Ejecución inicial en web](docs/04_base_inicial_ejecucion_web_vista_inicial.png)

## Vista móvil en navegador

![Ejecución inicial en web móvil](docs/05_base_inicial_ejecucion_web_movil_vista_inicial.png)

## Ejecución en emulador Android

![Aplicación ejecutándose en emulador](docs/06_base_inicial_ejecucion_emulador_vista_inicial.png)

---

# Estructura del proyecto

La aplicación se encuentra organizada en diferentes carpetas según la responsabilidad de cada archivo.

```text
lib/
├── 📁 components
│   ├── 📄 app_loading.dart
│   ├── 📄 app_search_bar.dart
│   ├── 📄 card_button.dart
│   ├── 📄 pokemon_card.dart
│   └── 📄 pokemon_type_chip.dart
├── 📁 constants
│   └── 📄 app_constants.dart
├── 📁 exception
│   └── 📄 api_exception.dart
├── 📁 helpers
│   ├── 📄 color_helper.dart
│   └── 📄 http_helper.dart
├── 📁 models
│   ├── 📄 pokemon_filter.dart
│   └── 📄 pokemon_model.dart
├── 📁 screens
│   ├── 📄 choose_pokemon_screen.dart
│   ├── 📄 home_screen.dart
│   ├── 📄 main_navigation_screen.dart
│   ├── 📄 pokemon_catalog_screen.dart
│   ├── 📄 pokemon_detail_screen.dart
│   ├── 📄 pokemon_search_screen.dart
│   └── 📄 team_screen.dart
├── 📁 services
│   └── 📄 pokemon_service.dart
├── 📁 states
│   ├── 📄 app_team_scope.dart
│   └── 📄 pokemon_search_state.dart
└── 📄 main.dart
```

## `main.dart`

Es el punto de entrada de la aplicación.

En este archivo se configura la aplicación utilizando `MaterialApp` y se establece la pantalla principal.

Entre sus principales responsabilidades se encuentran:

- Inicializar la aplicación.
- Configurar el tema.
- Definir el título.
- Establecer la pantalla inicial.

---

## `models/pokemon_model.dart`

Contiene el modelo utilizado para representar la información de un Pokémon.

El modelo permite organizar los datos obtenidos desde la API, como:

- Nombre.
- Imagen.
- Tipos.
- Estadísticas.
- Descripción.
- Información adicional.

La utilización de un modelo permite separar la estructura de los datos de la interfaz gráfica.

---

## `services/pokemon_service.dart`

Este archivo contiene la lógica encargada de realizar las solicitudes a la API externa.

Su responsabilidad principal es:

- Realizar solicitudes HTTP.
- Obtener la información de los Pokémon.
- Procesar las respuestas recibidas.
- Convertir los datos obtenidos en objetos de tipo `PokemonModel`.

---

## `screens/home_screen.dart`

Contiene la pantalla principal de la aplicación.

En esta pantalla se muestra una lista de Pokémon obtenidos desde el servicio.

La pantalla incluye:

- `Scaffold`.
- `AppBar`.
- Título de la aplicación.
- Indicador de carga.
- Lista de Pokémon.
- Tarjetas con información.
- Imágenes.
- Tipos de Pokémon.
- Botón para actualizar la información.
- Navegación hacia la pantalla de detalle.

---

## `screens/pokemon_detail_screen.dart`

Contiene la pantalla encargada de mostrar información detallada de un Pokémon seleccionado.

Entre la información mostrada se encuentran:

- Imagen.
- Nombre.
- Tipos.
- Estadísticas.
- Información descriptiva.

## Evidencia

![Vista de detalle](docs/07_base_inicial_ejecucion_emulador_vista_detalle.png)

---

# Widgets utilizados

Durante el desarrollo de la aplicación se utilizaron diferentes widgets proporcionados por Flutter.

## MaterialApp

Se utiliza para configurar la aplicación utilizando Material Design.

Permite establecer elementos como:

- Tema.
- Título.
- Pantalla inicial.

---

## Scaffold

Se utiliza como estructura principal de las pantallas.

Permite organizar elementos como:

- `AppBar`.
- Contenido principal.
- Botones flotantes u otros componentes.

---

## AppBar

Se utiliza para mostrar la barra superior de las pantallas.

En la aplicación permite identificar la pantalla que se encuentra utilizando el usuario.

---

## Column

Se utiliza para organizar diferentes widgets de forma vertical.

Es utilizado para estructurar la información mostrada en las pantallas.

---

## Row

Se utiliza para organizar widgets horizontalmente.

Por ejemplo, puede utilizarse para mostrar los tipos asociados a un Pokémon.

---

## Container

Se utiliza para aplicar estilos y organizar elementos.

Permite trabajar con propiedades como:

- Espaciado.
- Márgenes.
- Colores.
- Bordes.
- Tamaños.

---

## Card

Se utiliza para presentar la información de los Pokémon dentro de una tarjeta.

Cada tarjeta permite mostrar información resumida antes de acceder a la pantalla de detalle.

---

## Text

Se utiliza para mostrar información dentro de la aplicación.

Entre los textos mostrados se encuentran:

- Nombre de la aplicación.
- Nombre del Pokémon.
- Tipos.
- Estadísticas.
- Información adicional.

---

## Image

La aplicación muestra imágenes de los Pokémon obtenidas a partir de la información proporcionada por la API.

---

# Colores personalizados

La aplicación utiliza colores para mejorar la presentación visual de la información.

Los colores pueden variar según las características o tipos de los Pokémon mostrados.

Esto permite diferenciar visualmente elementos de la interfaz y mejorar la experiencia del usuario.

---

# Interacción básica

La aplicación incluye diferentes interacciones.

Una de ellas es el botón utilizado para actualizar o volver a cargar la información de los Pokémon.

Al ejecutar esta acción, la aplicación realiza nuevamente la solicitud al servicio y actualiza la información mostrada.

También se implementó interacción mediante las tarjetas de los Pokémon.

Al seleccionar un Pokémon, el usuario es dirigido a una pantalla donde puede consultar información detallada.

De esta manera, la aplicación incluye una interacción básica que permite modificar el contenido mostrado sin necesidad de cerrar o reiniciar la aplicación.

---

# Navegación

La aplicación cuenta con navegación entre pantallas.

El flujo principal es el siguiente:

```text
Pantalla principal
        │
        ▼
Lista de Pokémon
        │
        ▼
Seleccionar Pokémon
        │
        ▼
Pantalla de detalle
```

El usuario puede seleccionar un Pokémon desde la pantalla principal para acceder a su información detallada.

---

# Consumo de API

La información utilizada por la aplicación se obtiene desde **PokéAPI**.

PokéAPI proporciona información relacionada con el universo Pokémon, incluyendo datos como:

- Nombre.
- Tipos.
- Estadísticas.
- Características.
- Imágenes.

La aplicación realiza solicitudes a la API y procesa la información recibida para mostrarla dentro de la interfaz.

---

# Paquete externo utilizado

Para realizar las solicitudes a la API se utiliza el paquete externo:

```text
http
```

Este paquete permite realizar solicitudes HTTP desde una aplicación Flutter.

La dependencia se encuentra registrada dentro del archivo:

```text
pubspec.yaml
```

Ejemplo:

```yaml
dependencies:
  flutter:
    sdk: flutter

  http: ^1.2.2
```

El paquete es utilizado dentro del servicio de Pokémon para realizar las solicitudes necesarias y obtener la información desde la API externa.

Para instalar las dependencias del proyecto se puede utilizar el comando:

```bash
flutter pub get
```

---

# Archivo pubspec.yaml

El archivo `pubspec.yaml` permite administrar las dependencias utilizadas por el proyecto.

Entre las dependencias utilizadas se encuentra el paquete `http`, necesario para realizar la comunicación con la API.

Flutter descarga las dependencias configuradas mediante:

```bash
flutter pub get
```

---

# Evidencias del proyecto

La carpeta `docs` contiene diferentes capturas relacionadas con el proceso de desarrollo.

Actualmente incluye evidencias relacionadas con:

## Creación del workspace

![Creación del workspace](docs/01_creacion_workspaces.png)

## Verificación de Flutter

![Flutter Doctor](docs/02_validacion_instalacion_flutter.png)

## Configuración del repositorio

![Configuración de GitHub](docs/03_agregar_repositorio_github_y_creacion_rama_trabajo.png)

## Ejecución inicial

![Aplicación en web](docs/04_base_inicial_ejecucion_web_vista_inicial.png)

![Aplicación en vista móvil](docs/05_base_inicial_ejecucion_web_movil_vista_inicial.png)

![Aplicación en emulador](docs/06_base_inicial_ejecucion_emulador_vista_inicial.png)

## Pantalla de detalle

![Detalle de Pokémon](docs/07_base_inicial_ejecucion_emulador_vista_detalle.png)

### Regiones

![Submenú de regiones](docs/09_submenu_regiones.png)

### Pokémon por región

![Vista inicial de Pokémon por región](docs/10_vista_inicial_pokemon_por_region.png)

### Detalle de Pokémon

![Detalle con opción de agregar al equipo](docs/11_vista_detalle_pokemon_opcion_agregar_equipo.png)

### Mi equipo

![Vista de Mi equipo](docs/12_vista_mi_equipo.png)

### Búsqueda con filtros

![Búsqueda con filtros aplicados](docs/13_vista_busqueda_con_filtros.png)

---

# Control de versiones

El proyecto utiliza Git para el control de versiones.

El código fuente fue publicado en un repositorio público de GitHub.

Durante el desarrollo se realizaron diferentes commits que permiten mantener un historial de los cambios realizados.

El proyecto cumple con el requisito de contar con un mínimo de cuatro commits.

---

# Declaración de uso de IA

Este proyecto ha sido desarrollado con asistencia de herramientas de **inteligencia artificial (IA)** para tareas puntuales de corrección, optimización de código existente, creación de widgets reutilizables, documentación y revisión.

La arquitectura de la aplicación, las decisiones de diseño y los requisitos funcionales implementados son responsabilidad del autor del proyecto.

---

# Repositorio

El código fuente completo se encuentra publicado en el repositorio público:

**BladeZord/pokedex_flutter_app**

El repositorio incluye:

- Código fuente de Flutter.
- Configuración del proyecto.
- Archivo `pubspec.yaml`.
- Documentación.
- Capturas y evidencias.
- Historial de commits.

---

# Cómo ejecutar el proyecto

## 1. Clonar el repositorio

Clonar el repositorio desde GitHub utilizando Git.

## 2. Acceder al proyecto

```bash
cd pokedex_flutter_app
```

## 3. Instalar las dependencias

```bash
flutter pub get
```

## 4. Verificar los dispositivos disponibles

```bash
flutter devices
```

## 5. Ejecutar la aplicación

```bash
flutter run
```

La aplicación puede ejecutarse en un dispositivo físico, emulador Android o, dependiendo de la configuración del entorno, en otras plataformas compatibles con Flutter.

---

# Autor

**Nombre del estudiante:** Kevin Quito

---

# Referencias

Las siguientes fuentes fueron utilizadas como referencia durante el desarrollo del proyecto:

- Flutter Documentation.
- Dart Documentation.
- Pub.dev.
- Documentación del paquete `http`.
- PokéAPI Documentation.
- GitHub Documentation.

Estas fuentes fueron utilizadas como apoyo para la creación del proyecto, implementación de widgets, consumo de servicios HTTP y publicación del código mediante GitHub.

---

# Actividad Integradora 2

## Continuación de la aplicación

Se **continuó la aplicación de la Actividad Integradora 1** (Pokédex).  Sobre la misma base se agregó navegación entre varias pantallas, un catálogo con filtros, un equipo con estado local y la personalización visible de la app (nombre, logotipo e ícono).

## Descripción breve

**Mi Pokédex Favorita** permite explorar Pokémon por región, buscarlos en un catálogo con filtros, ver su detalle (tipos, estadísticas y descripción) y armar un equipo de hasta 6 integrantes. El equipo se actualiza en pantalla con `setState()`.

## Nuevas funcionalidades

- Navegación inferior entre **Inicio** y **Buscar**.
- Pantalla de **regiones** con iniciales de cada generación.
- Pantalla de **detalle** conectada desde el catálogo, las regiones y el equipo.
- **Mi equipo**: agregar y quitar Pokémon.
- Filtros de búsqueda por nombre y tipo (`AppSearchBar`).
- Mensajes con `SnackBar` y confirmaciones con `AlertDialog`.
- Logotipo en la pantalla de inicio e ícono de lanzamiento personalizado.
- Nombre visible de la aplicación: **Mi Pokédex Favorita**.

## Pantallas desarrolladas


| Pantalla | Archivo                                   | Función                                                                   |
| -------- | ----------------------------------------- | ------------------------------------------------------------------------- |
| Inicio   | `lib/screens/home_screen.dart`            | Dashboard con logotipo y accesos a regiones, equipo, medallas y batallas. |
| Buscar   | `lib/screens/pokemon_catalog_screen.dart` | Catálogo con filtros, recarga y tarjetas de Pokémon.                      |
| Regiones | `lib/screens/choose_pokemon_screen.dart`  | Selección de región y listado de iniciales.                               |
| Detalle  | `lib/screens/pokemon_detail_screen.dart`  | Estadísticas, descripción y acción de agregar o quitar del equipo.        |


Pantalla adicional (relacionada con `setState`):

- **Mi equipo** (`lib/screens/team_screen.dart`): muestra el equipo actual y permite retirar integrantes.

La navegación entre pestañas usa el índice de `BottomNavigationBar` (`setState`). El resto de pantallas se abre con `Navigator.push`.

## Estructura actual de `lib/`

```text
lib/
├── main.dart
├── components/
│   ├── app_loading.dart
│   ├── app_search_bar.dart
│   ├── card_button.dart
│   ├── pokemon_card.dart
│   └── pokemon_type_chip.dart
├── constants/
│   └── app_constants.dart
├── exception/
│   └── api_exception.dart
├── helpers/
│   ├── color_helper.dart
│   └── http_helper.dart
├── models/
│   ├── pokemon_filter.dart
│   └── pokemon_model.dart
├── screens/
│   ├── choose_pokemon_screen.dart
│   ├── home_screen.dart
│   ├── main_navigation_screen.dart
│   ├── pokemon_catalog_screen.dart
│   ├── pokemon_detail_screen.dart
│   ├── pokemon_search_screen.dart
│   └── team_screen.dart
├── services/
│   └── pokemon_service.dart
└── states/
    ├── app_team_scope.dart
    └── Pokemon_search_state.dart
```

## Documentación de archivos (Actividad Integradora 2)

Esta sección documenta las clases que se agregaron o cambiaron significativamente en esta etapa. `models/pokemon_model.dart` y `services/pokemon_service.dart` ya estaban documentados en la Actividad Integradora 1; aquí solo se agregan los métodos nuevos.

### `main.dart`

Ahora es `StatefulWidget` (`MyApp` / `_MyAppState`). Guarda el equipo del jugador en una lista `_equipo` y expone `_agregarAlEquipo` / `_quitarDelEquipo`. Envuelve todo el `MaterialApp` con `AppTeamScope`, de modo que cualquier pantalla descendiente puede leer o modificar el equipo sin pasarlo por constructor.

### `screens/home_screen.dart`

Dashboard principal (`StatelessWidget`). Muestra el logotipo (`assets/images/pokedex_logo.png`), el nombre de la app y una cuadrícula (`GridView.count`) de 4 `CardButton`:

- **Regiones** → navega a `ChoosePokemonScreen`.
- **Mi Equipo** → navega a `TeamScreen`.
- **Medallas** y **Batallas** → todavía no implementadas; muestran un `AlertDialog` ("estará disponible en una próxima actualización") mediante `_mostrarProximamente`.

### `screens/choose_pokemon_screen.dart`

`StatefulWidget` con dos vistas internas controladas por `_regionSeleccionada`:

1. **Selección de región**: `GridView.builder` con un `CardButton` por región (Kanto, Johto, Hoenn, Sinnoh, Unova, Kalos), mapeadas a su ID de generación en PokéAPI.
2. **Listado de iniciales**: al elegir una región, llama a `PokemonService.obtenerInicialesPorRegion()` y muestra los 3 iniciales en un `ListView.builder` con `Card` + `ListTile` (avatar, nombre, tipos). Cada `ListTile` navega a `PokemonDetailScreen`. Incluye un botón "Cambiar de Región" para volver a la vista 1.

### `screens/pokemon_detail_screen.dart`

`StatelessWidget` que recibe un `PokemonModel`. Muestra imagen, chips de tipo (`PokemonTypeChip`), barras de estadísticas (HP, Ataque, Defensa) y la descripción obtenida de `PokemonService.obtenerDescripcion()`. 

Novedad de esta etapa: se conecta a `AppTeamScope` para saber si el Pokémon ya está en el equipo (`estaEnEquipo`) y ofrece un botón que **agrega o quita** al Pokémon del equipo:
- Si el equipo ya tiene 6 integrantes, muestra un `AlertDialog` de advertencia.
- Si la acción se completa, muestra un `SnackBar` de confirmación.

### `screens/pokemon_catalog_screen.dart`

Pantalla del tab "Buscar". Carga un pool de hasta 30 Pokémon (`obtenerPoolPokemon`) y la lista de tipos disponibles (`obtenerTiposDisponibles`) en paralelo con `Future.wait`. Usa `AppSearchBar` para agregar/quitar filtros (`PokemonFilter`) por nombre, tipo primario o tipo secundario, y filtra la lista localmente (`_coincideConFiltros`). Los resultados se muestran en un `GridView.builder` de `PokemonCard`, cada una navega a `PokemonDetailScreen`. Tiene un `FloatingActionButton` para recargar el catálogo.

### `screens/team_screen.dart`

Muestra el equipo actual (`AppTeamScope.of(context).equipo`) en un `ListView.separated` con `Divider` entre elementos. Cada fila es un `ListTile` con `CircleAvatar`, nombre, tipos y un `IconButton` para quitar al Pokémon (pide confirmación con `AlertDialog` mediante la función `confirmarQuitarDelEquipo`, y muestra un `SnackBar` al completar la acción). Tocar la fila navega al detalle.

### `screens/main_navigation_screen.dart`

Contenedor de navegación inferior. Usa `IndexedStack` (en vez de reemplazar el widget del body) para mantener vivo el estado de `HomeScreen` y `PokemonCatalogScreen` al cambiar de pestaña. El índice seleccionado se controla con `setState` en `_cambiarPantalla`.

### `screens/pokemon_search_screen.dart` + `states/Pokemon_search_state.dart`

`PokemonSearchScreen<T>` es un widget de búsqueda genérico y reutilizable: recibe una lista de elementos (`elementos`), una función para extraer el valor a comparar (`valorABuscar`) y un callback (`listadoCambiado`) que se dispara con la lista filtrada. Su `State` (`PokemonSearchState<T>`) contiene el `TextField` con ícono de limpiar y aplica el filtro en cada `onChanged`.

### `states/app_team_scope.dart`

`InheritedWidget` que expone el equipo del jugador a toda la app sin necesidad de pasar el estado manualmente entre pantallas (evita el "prop drilling"). Define:

- `capacidadMaxima = 6`.
- `equipo`: lista inmutable del equipo actual.
- `agregarAlEquipo` / `quitarDelEquipo`: callbacks que delegan en el estado de `MyApp`.
- `estaEnEquipo(pokemon)`: helper para saber si un Pokémon ya fue agregado.
- `AppTeamScope.of(context)`: acceso estático desde cualquier widget descendiente.

### `helpers/color_helper.dart`

`ColorHelper.colorPorTipo(tipo)` mapea el tipo de Pokémon (fuego, agua, planta, etc.) a un `Color` de Material, usado para pintar chips, barras de estadísticas y avatares. Si el tipo no está en el mapa, devuelve `Colors.teal` por defecto.

### `helpers/http_helper.dart`

Envuelve el paquete `http` con manejo de errores centralizado:

- `hasInternetConnection()`: usa `connectivity_plus` para detectar si hay red; en Web omite la verificación de DNS porque el navegador ya la gestiona.
- `get(url)`: lanza `NetworkException` si no hay conexión, agrega timeout de 10 segundos y traduce los códigos de estado HTTP (400, 401/403, 404, 500) a `ApiException` mediante `_processResponse`.

### `exception/api_exception.dart`

Define las dos excepciones personalizadas que usa el resto de la app:

- `NetworkException`: errores de conectividad.
- `ApiException`: errores devueltos por la API, con `codigoEstado` opcional.

### `models/pokemon_filter.dart`

- `PokemonKeyFilter` (enum): `nombre`, `tipoPrimario`, `tipoSecundario`, con una extensión `etiqueta` para mostrar el texto en español en el dropdown.
- `PokemonFilter`: value object inmutable (`key` + `value`) con `==`/`hashCode` sobreescritos para poder compararlos y evitar filtros duplicados.

### `components/card_button.dart`

Botón reutilizable en forma de tarjeta (`Card` + `InkWell`), usado en el dashboard de inicio y en la selección de regiones. Acepta un ícono opcional y cualquier `child`, ambos envueltos en `FittedBox` para evitar overflow si el contenido no cabe.

### `components/app_search_bar.dart`

Barra de filtros reutilizada por `PokemonCatalogScreen`. Permite elegir la clave de búsqueda (nombre / tipo primario / tipo secundario) y, según el caso, escribir un valor o elegir un tipo desde un segundo dropdown. Los filtros activos se muestran como `InputChip` removibles.

## Widgets utilizados en esta etapa

Además de `MaterialApp`, `Scaffold` y `AppBar`, se incorporaron entre otros:

- `ListView`
- `GridView`
- `ListTile`
- `Card`
- `CircleAvatar`
- `Divider`
- `Image` / `Image.asset` / `Image.network`
- `Icon`
- `ElevatedButton`
- `IconButton`
- `FloatingActionButton`
- `Padding`
- `SizedBox`
- `Expanded`
- `Container`
- `BottomNavigationBar`
- `AlertDialog`
- `SnackBar`

## Interacciones implementadas

1. **Navegar entre pantallas** con `Navigator` (regiones, detalle y equipo) y con la barra inferior (Inicio / Buscar).
2. **SnackBar** al agregar o quitar un Pokémon del equipo.
3. **AlertDialog** si el equipo ya tiene 6 integrantes, al confirmar un retiro y en las secciones Medallas / Batallas.
4. **Filtrar** el catálogo y **recargarlo** con el botón flotante.
5. **Cambiar la región** visible con `setState`.

## Funcionalidad con `setState()`

El equipo se guarda en `MyApp` y se comparte con `AppTeamScope`. Cada alta o baja llama a `setState()`, y las pantallas de detalle y equipo se redibujan.

Otros usos de `setState()`:

- Cambio de pestaña en `MainNavigation`.
- Selección de región en `ChoosePokemonScreen`.
- Filtros y recarga del catálogo en `PokemonCatalogScreen`.

## Paquetes externos


| Paquete             | Uso                                                              |
| ------------------- | ---------------------------------------------------------------- |
| `http`              | Solicitudes a PokéAPI.                                           |
| `connectivity_plus` | Comprobar conexión antes de consultar la API (`HttpHelper`).     |
| `google_fonts`      | Tipografía Poppins en constantes y componentes (`AppConstants`). |


## Personalización

- **Nombre:** `Mi Pokédex Favorita` en `MaterialApp`, en `AndroidManifest.xml` (`android:label`) y en iOS (`CFBundleDisplayName`).
- **Ícono de lanzamiento:** `android/app/src/main/res/mipmap-*/ic_launcher.png` e iconos web.
- **Logotipo:** `assets/images/pokedex_logo.png`, mostrado en la pantalla de inicio.
- **Colores:** rojo como color principal y colores por tipo de Pokémon (`ColorHelper`).

## Capturas

Las evidencias de la Actividad Integradora 1 permanecen en `docs/`.

### Inicio

![Rediseño del menú principal](docs/08_rediseno_menu_principal.png)

### Regiones

![Submenú de regiones](docs/09_submenu_regiones.png)

### Pokémon por región

![Vista inicial de Pokémon por región](docs/10_vista_inicial_pokemon_por_region.png)

### Detalle de Pokémon

![Detalle con opción de agregar al equipo](docs/11_vista_detalle_pokemon_opcion_agregar_equipo.png)

### Mi equipo

![Vista de Mi equipo](docs/12_vista_mi_equipo.png)

### Búsqueda con filtros

![Búsqueda con filtros aplicados](docs/13_vista_busqueda_con_filtros.png)

### Agregar Pokémon al equipo desde el detalle

![Agregar al equipo con Provider](docs/14_agregar_pokemon_equipo_provider.png)

### Mi equipo reflejando el cambio en tiempo real

![Equipo actualizado en vivo](docs/15_equipo_actualizado_provider.png)

### Quitar Pokémon del equipo

![Quitar del equipo](docs/16_quitar_pokemon_equipo_provider.png)

## Cómo ejecutar el proyecto

```bash
cd pokedex_flutter_app
flutter pub get
flutter devices
flutter run
```

La aplicación está pensada para ejecutarse en un **emulador Android**. También puede probarse en Chrome u otras plataformas soportadas por Flutter.