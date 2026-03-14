# BTG Bank - Gestión de Fondos de Inversión

Este proyecto es una aplicación de Flutter diseñada para la visualización y gestión de fondos de inversión. Permite a los usuarios suscribirse a fondos, cancelar suscripciones y realizar un seguimiento de su historial de transacciones.

## 🚀 Características Principales

- **Dashboard de Saldo**: Visualización en tiempo real del saldo disponible con diseño premium (degradados y sombras).
- **Catálogo de Fondos**: Lista de fondos disponibles con detalles como monto mínimo y categoría (FPV, FIC).
- **Gestión de Suscripciones**:
  - Suscripción con validación de saldo.
  - Notificaciones configurables (Email/SMS).
  - Cancelación de suscripciones activas.
- **Historial de Transacciones**: Registro detallado con estados visuales (Rojo para suscripciones/débitos, Verde para cancelaciones/créditos).
- **Resumen Ejecutivo**: Dashboards informativos con el estado actual de la cartera.

## 🛠️ Tecnologías Utilizadas

- **Flutter & Dart**: Framework principal.
- **Provider**: Gestión de estado simple y eficiente.
- **Google Fonts**: Tipografía Poppins para una apariencia moderna.
- **Mock Service**: Simulación de API para carga de datos dinámica.

## 📋 Requisitos Previos

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (Versión estable reciente).
- [Dart SDK](https://dart.dev/get-started/sdk).
- Un emulador (Android/iOS) o navegador para ejecución web.

## 📥 Instalación

1.  **Clonar el repositorio**:
    ```bash
    git clone [url-del-repositorio]
    cd btg_bank
    ```

2.  **Instalar dependencias**:
    ```bash
    flutter pub get
    ```

## 🏃 Ejecución

Para ejecutar la aplicación en modo desarrollo:

```bash
flutter run
```

*Nota: Asegúrate de tener un dispositivo conectado o emulador iniciado.*

## 🧪 Pruebas

El proyecto cuenta con una suite de pruebas unitarias y de widgets para asegurar la calidad del código.

Ejecutar todos los tests:
```bash
flutter test
```

Ejecutar un test específico (ejemplo):
```bash
flutter test test/widgets/home/fund_card_test.dart
```

## 📂 Estructura del Proyecto

- `lib/models/`: Definición de entidades de datos (Fund, TransactionRecord).
- `lib/providers/`: Lógica de negocio y gestión de estado (FundProvider).
- `lib/screens/`: Pantallas principales de la aplicación.
- `lib/widgets/`: Componentes de UI reutilizables.
- `lib/theme/`: Configuración global del diseño (AppTheme).
