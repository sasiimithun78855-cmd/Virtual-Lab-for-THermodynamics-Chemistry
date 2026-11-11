# Virtual Chemistry Lab – Thermodynamics

A self-contained, single-file web app (`index.html`). No build step, no backend, no API keys.

## Run locally
Open `index.html` in a browser, or run `python3 -m http.server 8000` and visit http://localhost:8000.

## Deploy
- **Vercel / Netlify / Cloudflare Pages:** import this repo; no build command; output directory is the repo root.
- **GitHub Pages:** Settings → Pages → Source: GitHub Actions (the included workflow deploys on every push to `main`).

## Secrets
`.env` and common key files are git-ignored. If you add an API later, keep keys in `.env` locally and in your host's environment-variable settings for deployment. Never put keys in `index.html`, since anything in front-end code is public.
