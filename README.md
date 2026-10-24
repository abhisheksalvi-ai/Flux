# Flux

Flux is an ultra-lightweight Windows AI coding assistant utility designed for global-hotkey-first workflows.

## Highlights

- Background-first app behavior with optional tray icon
- No traditional dashboard window
- Global hotkeys for full, region, and active-window capture
- OCR pipeline optimized for code/terminal text extraction
- AI responses rendered in a centered glass overlay
- Markdown + syntax-highlighted code rendering
- Tiny settings modal and tray controls
- OpenAI + Ollama support
- Tauri v2 single EXE packaging for Windows (NSIS)

## Architecture

- Frontend: React + TypeScript + Tailwind + Framer Motion
- Desktop runtime: Tauri v2
- Backend: Rust async services
- OCR: Tesseract CLI + image preprocessing
- AI: OpenAI Chat Completions API or Ollama local endpoint

## Project Structure

- src/: overlay UI, settings modal, event bridge, state store
- src-tauri/src/: Rust capture/OCR/AI/hotkey/tray pipeline
- src-tauri/tauri.conf.json: window + bundle configuration

## Default Hotkeys

- Ctrl+Shift+C: capture full screen
- Ctrl+Shift+R: capture region (currently falls back to full capture)
- Ctrl+Shift+W: capture active window (currently falls back to full capture)
- Ctrl+Shift+X: hide overlay
- ESC: dismiss overlay

## Prerequisites

- Node.js 20+
- Rust stable toolchain
- Tesseract OCR installed and available in PATH
- Windows 10/11

## Development

```bash
npm install
npm run tauri:dev
```

## Build Windows Installer/EXE

```bash
npm run tauri:build
```

The build artifacts are generated under src-tauri/target/release/bundle/nsis.

## Settings

Stored locally under app config directory as JSON.

Configurable fields:

- OpenAI API key
- Provider and model
- OCR language
- Overlay timeout
- Hotkey mappings
- Startup toggle

## Optional: Email Answers On Capture

Flux can automatically email the generated answer after a hotkey capture.

Set these environment variables before launching Flux:

- FLUX_EMAIL_ENABLED=true
- RESEND_API_KEY=your_resend_api_key
- FLUX_EMAIL_TO=you@example.com
- FLUX_EMAIL_FROM=Flux <onboarding@resend.dev> (optional)

Notes:

- If FLUX_EMAIL_ENABLED is not true, email sending is disabled.
- Email sending failures do not block overlay responses.

## Performance Notes

- Overlay window is hidden when idle
- No polling loop in idle state
- OCR and AI run only on capture trigger
- Pipeline emits progressive status events: capturing -> ocr -> thinking -> ready/error

## Current Prototype Scope

Implemented now:

- Full pipeline and architecture
- Transparent overlay and markdown rendering
- Global hotkeys (Windows)
- Tray menu and tiny settings UI

Roadmap for hardening:

- Native region-select capture UI
- True active-window capture path
- Streaming AI response rendering in chunks
- Secure keyring-backed API key storage
- Startup registration integration
- Enhanced OCR preprocessing presets per content type
