# Plan de Implementación de Automatización de Estilo - Artenity

## Tabla de Contenidos
1. [Investigación de Herramientas](#investigación-de-herramientas)
2. [Plan de Implementación](#plan-de-implementación)
3. [Herramientas Seleccionadas](#herramientas-seleccionadas)
4. [Archivos de Configuración Creados](#archivos-de-configuración-creados)
5. [Evidencias de Implementación](#evidencias-de-implementación)
6. [Guía de Uso](#guía-de-uso)
7. [Mantenimiento y Mejoras](#mantenimiento-y-mejoras)

---

## Investigación de Herramientas

### 1. Para Frontend (React + TypeScript)

#### ESLint (Linter)
- **Descripción**: Herramienta de análisis estático para identificar patrones problemáticos en código JavaScript/TypeScript
- **Ventajas**:
  - Detecta errores antes de ejecutar código
  - Altamente configurable
  - Amplio ecosistema de plugins
  - Integración perfecta con React y TypeScript
- **Desventajas**:
  - Requiere configuración inicial
  - Puede ser lento en proyectos muy grandes

#### Prettier (Formatter)
- **Descripción**: Formateador de código opinionado que garantiza formato consistente
- **Ventajas**:
  - Menos conflictos en PRs (solo formato, no lógica)
  - Muy rápido
  - Integración perfecta con ESLint
  - Soporta múltiples lenguajes
- **Desventajas**:
  - Opiniones fijas (pocas configuraciones)
  - Requiere desactivar algunas reglas de ESLint

### 2. Para Backend (Python)

#### Black (Formatter)
- **Descripción**: Formateador de código Python opinionado
- **Ventajas**:
  - Elimina debates sobre estilo
  - Muy rápido
  - Ampliamente adoptado en comunidad Python
- **Desventajas**:
  - No configurable (a propósito)
  - Líneas máximo 88 caracteres

#### Pylint (Linter)
- **Descripción**: Analizador estático muy completo para Python
- **Ventajas**:
  - Muy riguroso y detallado
  - Detecta muchos tipos de errores
  - Configurable granularmente
- **Desventajas**:
  - Puede ser lento
  - A veces demasiado estricto

#### Flake8 (Linter alternativo)
- **Descripción**: Linter más ligero basado en PyCodeStyle, PyFlakes e mccabe
- **Ventajas**:
  - Más rápido que Pylint
  - Buen balance entre flexibilidad y rigor
  - Fácil de configurar
- **Desventajas**:
  - Menos completo que Pylint
  - Menos análisis de diseño

#### isort (Import Sorter)
- **Descripción**: Organiza automáticamente imports en Python
- **Ventajas**:
  - Compatible con Black
  - Configurable
  - Mejora legibilidad
- **Desventajas**:
  - Herramienta específica (requiere ejecutarse)

### 3. Herramientas Transversales

#### pre-commit
- **Descripción**: Framework para ejecutar hooks antes de commits
- **Ventajas**:
  - Previene commits con código mal formateado
  - Funciona con múltiples lenguajes
  - Configuración centralizada
  - Fácil de mantener
- **Desventajas**:
  - Requiere instalación de dependencias adicionales
  - Puede ralentizar commits si no se optimiza

#### EditorConfig
- **Descripción**: Especificación para mantener estilos consistentes entre IDEs
- **Ventajas**:
  - Funcionamiento multiplataforma
  - Soportado por VS Code, IntelliJ, Sublime, etc.
  - No requiere plugins adicionales
  - Esencial para equipos heterogéneos
- **Desventajas**:
  - No es ejecutable (solo información)
  - Requiere que IDE tenga soporte

---

## Plan de Implementación

### Fase 1: Preparación (✅ COMPLETADA)
- [x] Seleccionar herramientas (ESLint + Prettier para Frontend, Black + Flake8 para Backend)
- [x] Crear archivos de configuración base
- [x] Documentar estándares

### Fase 2: Configuración Frontend (✅ COMPLETADA)
- [x] Crear `.eslintrc.json` con reglas para React y TypeScript
- [x] Crear `.prettierrc.json` con estándar de formato
- [x] Crear `.prettierignore` para archivos a ignorar
- [x] Actualizar `package.json` con scripts npm
- [x] Mejorar `.gitignore`

### Fase 3: Configuración Backend (✅ COMPLETADA)
- [x] Crear `pyproject.toml` con Black, isort y Pylint
- [x] Crear `.pylintrc` con reglas personalizadas
- [x] Crear `.flake8` con configuración
- [x] Crear `requirements-dev.txt` con herramientas

### Fase 4: Automatización Global (✅ COMPLETADA)
- [x] Crear `.editorconfig` para todos los IDEs
- [x] Crear `.pre-commit-config.yaml` para hooks
- [x] Documentación del plan

### Fase 5: Próximos Pasos (PENDIENTE)
- [ ] Instalar pre-commit en ambiente local
- [ ] Ejecutar formateo en todo el código existente
- [ ] Crear CI/CD en GitHub Actions
- [ ] Entrenar equipo en uso de herramientas

---

## Herramientas Seleccionadas

### Matriz de Decisión

| Criterio | Frontend | Backend |
|---|---|---|
| **Linting** | ESLint + Prettier | Flake8 + Pylint |
| **Formatting** | Prettier (100% automático) | Black (100% automático) |
| **Import Sorting** | ESLint (integrado) | isort (automático) |
| **Configuration** | JSON + YAML | TOML + INI |
| **Pre-commit Hooks** | Sí (global) | Sí (global) |
| **Editor Config** | Sí (global) | Sí (global) |

### Justificación

1. **ESLint + Prettier para Frontend**:
   - Estándar de la industria para React
   - Perfecta integración con TypeScript
   - Comunidad muy activa
   - Miles de plugins disponibles

2. **Black + Flake8 para Backend**:
   - Recomendado por comunidad Python
   - Black es formateador oficial de muchos proyectos
   - Flake8 es más rápido y flexible que Pylint
   - Combinación = rigor + velocidad

3. **EditorConfig**:
   - Garantiza consistencia sin instalación adicional
   - Funciona en todos los IDEs principales

4. **pre-commit**:
   - Automatiza todo el flujo
   - Previene commits problemáticos
   - Fácil mantenimiento

---

## Archivos de Configuración Creados

### Frontend

#### 1. `.eslintrc.json`
```json
{
  "env": {
    "browser": true,
    "es2021": true,
    "node": true
  },
  "extends": [
    "react-app",
    "eslint:recommended",
    "plugin:react/recommended",
    "plugin:react-hooks/recommended",
    "plugin:@typescript-eslint/recommended",
    "prettier"
  ],
  "parser": "@typescript-eslint/parser",
  "parserOptions": {
    "ecmaFeatures": {
      "jsx": true
    },
    "ecmaVersion": "latest",
    "sourceType": "module"
  },
  "plugins": [
    "react",
    "react-hooks",
    "@typescript-eslint",
    "prettier"
  ],
  "rules": {
    "react/react-in-jsx-scope": "off",
    "react/prop-types": "off",
    "@typescript-eslint/explicit-module-boundary-types": "off",
    "@typescript-eslint/no-unused-vars": "warn",
    "no-console": "warn",
    "prettier/prettier": "error",
    "react-hooks/rules-of-hooks": "error",
    "react-hooks/exhaustive-deps": "warn"
  },
  "settings": {
    "react": {
      "version": "detect"
    }
  }
}
```

**Propósito**: Define reglas de linting para React y TypeScript, integra Prettier como plugin.

#### 2. `.prettierrc.json`
```json
{
  "semi": true,
  "trailingComma": "es5",
  "singleQuote": true,
  "printWidth": 100,
  "tabWidth": 2,
  "useTabs": false,
  "arrowParens": "always",
  "endOfLine": "lf",
  "bracketSpacing": true,
  "jsxBracketSameLine": false,
  "jsxSingleQuote": false
}
```

**Propósito**: Define reglas de formateo consistentes para todo el código JavaScript/TypeScript.

**Configuraciones principales**:
- `printWidth: 100` - Máximo 100 caracteres por línea
- `singleQuote: true` - Usar comillas simples
- `trailingComma: "es5"` - Comas al final de línea (compatible ES5)
- `semi: true` - Requerir puntos y comas

#### 3. `.prettierignore`
```
node_modules
build
dist
.next
.cache
coverage
.git
.env
.env.local
*.log
```

**Propósito**: Especifica archivos que Prettier debe ignorar.

#### 4. `package.json` (scripts actualizados)
```json
"scripts": {
  "start": "react-scripts start",
  "build": "react-scripts build",
  "test": "react-scripts test",
  "eject": "react-scripts eject",
  "lint": "eslint src --ext .js,.jsx,.ts,.tsx",
  "lint:fix": "eslint src --ext .js,.jsx,.ts,.tsx --fix",
  "format": "prettier --write \"src/**/*.{js,jsx,ts,tsx,json,css}\"",
  "format:check": "prettier --check \"src/**/*.{js,jsx,ts,tsx,json,css}\""
}
```

**Comandos disponibles**:
- `npm run lint` - Verificar errores sin corregir
- `npm run lint:fix` - Corregir errores automáticamente
- `npm run format` - Formatear código
- `npm run format:check` - Verificar formato sin cambios

### Backend

#### 5. `pyproject.toml`
```toml
[tool.black]
line-length = 100
target-version = ['py310']

[tool.isort]
profile = "black"
multi_line_mode = 3
include_trailing_comma = true
line_length = 100

[tool.pylint.messages_control]
disable = [
    "C0111",  # missing-docstring
    "R0913",  # too-many-arguments
    ...
]

[tool.pylint.format]
max-line-length = 100
```

**Propósito**: Configuración centralizada para Black, isort y Pylint.

#### 6. `.pylintrc`
```ini
[MASTER]
load-plugins=pylint_django
django-settings-module=backend.config

[MESSAGES CONTROL]
disable=
    missing-docstring,
    too-many-arguments,
    ...

[FORMAT]
max-line-length=100
```

**Propósito**: Configuración completa de Pylint con plugins y reglas personalizadas.

#### 7. `.flake8`
```ini
[flake8]
max-line-length = 100
exclude = 
    .git,
    __pycache__,
    .venv,
    migrations,
    build,
    dist

ignore = 
    E203,
    W503,
    E501
```

**Propósito**: Configuración de Flake8 para análisis rápido.

#### 8. `requirements-dev.txt`
```
black==23.12.1
isort==5.13.2
pylint==3.0.3
flake8==6.1.0
pytest==7.4.3
pre-commit==3.5.0
```

**Propósito**: Especifica todas las herramientas de desarrollo necesarias.

### Global

#### 9. `.editorconfig`
```ini
root = true

[*]
charset = utf-8
end_of_line = lf
insert_final_newline = true
trim_trailing_whitespace = true

[*.{js,jsx,ts,tsx,json}]
indent_style = space
indent_size = 2

[*.py]
indent_style = space
indent_size = 4
```

**Propósito**: Mantiene consistencia de estilos entre todos los IDEs sin necesidad de plugins.

**Beneficios**:
- Automático en VS Code, IntelliJ, Sublime, Vim, Emacs
- No requiere plugins
- Funciona para todo el equipo

#### 10. `.pre-commit-config.yaml`
```yaml
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.5.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
      - id: check-yaml
      - id: check-json
      - id: check-merge-conflict

  - repo: https://github.com/psf/black
    rev: 23.12.1
    hooks:
      - id: black

  - repo: https://github.com/PyCQA/isort
    rev: 5.13.2
    hooks:
      - id: isort

  - repo: https://github.com/PyCQA/flake8
    rev: 6.1.0
    hooks:
      - id: flake8

  - repo: https://github.com/pre-commit/mirrors-prettier
    rev: v3.1.0
    hooks:
      - id: prettier
        types_or: [javascript, typescript, jsx, tsx, json]

  - repo: https://github.com/pre-commit/mirrors-eslint
    rev: v8.55.0
    hooks:
      - id: eslint
        types: [javascript, typescript, jsx, tsx]
```

**Propósito**: Automatiza linting y formateo en cada commit.

---

## Evidencias de Implementación

### Evidencia 1: Archivos de Configuración Creados
```
✅ c:\Users\camil\Artenity\frontend\.eslintrc.json
✅ c:\Users\camil\Artenity\frontend\.prettierrc.json
✅ c:\Users\camil\Artenity\frontend\.prettierignore
✅ c:\Users\camil\Artenity\backend\pyproject.toml
✅ c:\Users\camil\Artenity\backend\.pylintrc
✅ c:\Users\camil\Artenity\backend\.flake8
✅ c:\Users\camil\Artenity\backend\requirements-dev.txt
✅ c:\Users\camil\Artenity\.editorconfig
✅ c:\Users\camil\Artenity\.pre-commit-config.yaml
✅ c:\Users\camil\Artenity\PLAN_IMPLEMENTACION.md (este archivo)
```

### Evidencia 2: Estructura del Proyecto
```
Artenity/
├── .editorconfig (global)
├── .pre-commit-config.yaml (global)
├── PLAN_IMPLEMENTACION.md
├── frontend/
│   ├── .eslintrc.json
│   ├── .prettierrc.json
│   ├── .prettierignore
│   ├── package.json (actualizado con scripts)
│   └── src/
├── backend/
│   ├── pyproject.toml
│   ├── .pylintrc
│   ├── .flake8
│   ├── requirements-dev.txt
│   └── *.py
└── .gitignore (mejorado)
```

### Evidencia 3: Scripts Disponibles en Frontend
```bash
npm run lint           # ESLint sin correcciones
npm run lint:fix       # ESLint con correcciones automáticas
npm run format         # Prettier formatea todo
npm run format:check   # Prettier solo verifica sin cambiar
```

### Evidencia 4: Comandos para Backend
```bash
# Black - Formateo
black .

# Flake8 - Linting rápido
flake8 .

# Pylint - Análisis profundo
pylint backend/

# isort - Organizar imports
isort .

# Pre-commit - Verificar todo
pre-commit run --all-files
```

### Evidencia 5: Integración con Git
Con `.pre-commit-config.yaml` instalado:
```bash
# Instalación única (una vez por máquina)
pip install pre-commit
pre-commit install

# Luego, automáticamente en cada commit:
# - Se verifica trailing whitespace
# - Se formatea con Black y isort (Python)
# - Se formatea con Prettier (JavaScript)
# - Se ejecuta ESLint (JavaScript)
# - Se ejecuta Flake8 (Python)
```

---

## Guía de Uso

### Para Desarrolladores Frontend

#### Paso 1: Instalar dependencias (primera vez)
```bash
cd frontend
npm install --legacy-peer-deps
```

#### Paso 2: Usar antes de commitar
```bash
# Verificar errores
npm run lint

# Corregir automáticamente
npm run lint:fix

# Formatear código
npm run format

# O ambos en una línea
npm run lint:fix && npm run format
```

#### Paso 3: VS Code (configuración automática)
Instalar extensiones recomendadas:
- **ESLint** (Microsoft)
- **Prettier - Code Formatter** (Prettier)

VS Code detectará automáticamente `.eslintrc.json` y `.prettierrc.json`.

### Para Desarrolladores Backend

#### Paso 1: Instalar dependencias de desarrollo
```bash
cd backend
pip install -r requirements-dev.txt
```

#### Paso 2: Formatear código antes de commitar
```bash
# Formatear con Black
black .

# Organizar imports
isort .

# Verificar con Flake8
flake8 .

# O todos a la vez
black . && isort . && flake8 .
```

#### Paso 3: IDE Configuration
**.editorconfig** se aplica automáticamente en VS Code, PyCharm, etc.

### Configuración Global (Pre-commit Hooks)

#### Instalación única
```bash
# En la raíz del proyecto
pip install pre-commit
pre-commit install
```

#### Ahora, cada commit automáticamente:
```bash
git add .
git commit -m "feat: nueva funcionalidad"

# Se ejecutan automáticamente:
# 1. Verificaciones generales (trailing whitespace, etc.)
# 2. Black (Python)
# 3. isort (Python)
# 4. Flake8 (Python)
# 5. Prettier (JavaScript/JSON)
# 6. ESLint (JavaScript)

# Si hay cambios, el commit se detiene
# Revisa los archivos modificados y vuelve a commitar
```

### Sobrescribir Checks (Rara vez necesario)
```bash
# Si necesitas saltarte los checks (no recomendado)
git commit --no-verify -m "mensaje"

# O
git commit -n -m "mensaje"
```

---

## Mantenimiento y Mejoras

### Actualizar Herramientas

#### Frontend
```bash
cd frontend
npm update eslint prettier @typescript-eslint/eslint-plugin
```

#### Backend
```bash
cd backend
pip install --upgrade black flake8 pylint isort
# Luego actualizar requirements-dev.txt con nuevas versiones
```

### Ignorar Reglas Específicas (Sin abusar)

#### En archivos específicos (Python)
```python
# pylint: disable=missing-docstring
def mi_funcion():
    ...

# flake8: noqa
var = 1
```

#### En archivos específicos (JavaScript)
```javascript
// eslint-disable-next-line react/prop-types
export const Component = (props) => {
  ...
}

// prettier-ignore
const object = {unformatted}
```

### Estadísticas y Reportes

#### Python Coverage
```bash
coverage run -m pytest
coverage report
coverage html  # Genera reporte en htmlcov/
```

#### Análisis de Calidad
```bash
# Sonarqube analysis (futuro)
sonar-scanner ...

# Codacy integration (futuro)
# Integración automática con pre-commit
```

### Troubleshooting

#### "Prettier y ESLint pelean"
- ✅ Resuelto: ESLint usa `eslint-config-prettier` que desactiva conflictos

#### "Black y otros reformatean diferente"
- ✅ Resuelto: isort usa `profile = "black"` para compatibilidad

#### "Pre-commit es lento"
- Solución: Configurar `stages` para correr en diferentes momentos
- Solución: Usar `skip` para archivos grandes temporalmente

---

## Resumen Ejecutivo

| Componente | Herramientas | Archivos | Estado |
|---|---|---|---|
| **Frontend Linting** | ESLint + Prettier | `.eslintrc.json`, `.prettierrc.json` | ✅ Completo |
| **Frontend Scripts** | npm | `package.json` | ✅ Completo |
| **Backend Formatting** | Black + isort | `pyproject.toml` | ✅ Completo |
| **Backend Linting** | Flake8 + Pylint | `.flake8`, `.pylintrc` | ✅ Completo |
| **Dev Dependencies** | Python | `requirements-dev.txt` | ✅ Completo |
| **Editor Config** | EditorConfig | `.editorconfig` | ✅ Completo |
| **Auto Hooks** | pre-commit | `.pre-commit-config.yaml` | ✅ Completo |
| **Docs** | Markdown | Este archivo | ✅ Completo |

---

## Próximos Pasos Recomendados

1. **Instalar pre-commit** en máquinas locales
   ```bash
   pip install pre-commit && pre-commit install
   ```

2. **Ejecutar formateo inicial** en toda la base de código
   ```bash
   npm run format:fix  # Frontend
   black . && isort .  # Backend
   ```

3. **Configurar CI/CD** en GitHub Actions (ver workflows/)

4. **Entrenar equipo** en uso de herramientas

5. **Monitorear** calidad de código con reportes semanales

---

**Documento generado**: 12 de diciembre de 2025  
**Proyecto**: Artenity  
**Versión**: 1.0
