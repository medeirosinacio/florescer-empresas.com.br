# The Awesome Jekyll Template

A complete, production-ready Jekyll template with **Tailwind CSS v4**, designed for fast and easy deployment on **GitHub Pages**.

[Live Demo](https://jekyll-bootstrap.douglasmedeiros.dev/)

---

## Features

- **Jekyll 3.10**: Static site generator, fully compatible with GitHub Pages.
- **Tailwind CSS v4**: Utility-first CSS framework via standalone CLI — zero npm/node required.
- **Alpine.js 3.x**: Lightweight reactive JS for interactive components (navbar, modals, FAQ accordion).
- **Scroll Animations**: IntersectionObserver-based reveal animations (no external library).
- **Inter Font**: Modern variable-weight font, served locally (woff2, 5 weights, ~556KB).
- **Zero CDN**: All assets (CSS, JS, fonts) are local — no external runtime dependencies.
- **HTML/CSS/JS Minification**: Optimized builds using [Jekyll Minifier](https://github.com/Mendeo/jekyll-minifier).
- **Dynamic Blog**: Pagination, tags, and categories out of the box.
- **Comments**: Powered by [Disqus](https://disqus.com/).
- **Contact Form**: Email responses via [Static Forms](https://www.staticforms.xyz/).
- **Docker Support**: Easy local development with Docker (no Ruby/Node install needed).
- **GitHub Actions CI/CD**: Automated Tailwind build → Jekyll build → GitHub Pages deploy.

## Tech Stack

| Layer | Technology |
|---|---|
| Static generator | Jekyll 3.10 |
| CSS framework | Tailwind CSS v4.2 (standalone CLI) |
| JS framework | Alpine.js 3.14 |
| Animations | Custom IntersectionObserver (`scroll-animations.js`) |
| Font | Inter (woff2, local) |
| Build tooling | Docker + Make |
| CI/CD | GitHub Actions → GitHub Pages |
| Runtime deps | **None** (no npm, no node) |

## Getting Started

### Prerequisites

- [Git](https://git-scm.com/)
- [Docker](https://www.docker.com/)
- [GNU Make](https://www.gnu.org/software/make/) (available by default on most Unix systems)

### Installation

1. **Clone the repository:**
    ```sh
    git clone https://github.com/medeirosinacio/jekyll-bootstrap-github-pages.git
    cd jekyll-bootstrap-github-pages
    ```

2. **Start the local server:**
    ```sh
    make setup
    ```
   The server will be available at [http://localhost:4000](http://localhost:4000).

> **Note:** The `make setup` command automatically detects your system architecture (x86 or ARM) and runs the appropriate Docker environment. Tailwind CSS is compiled inside the container using the standalone CLI — no Node.js required.

### Makefile Commands

- `make setup` — Sets up and runs the project in a Docker container. Detects CPU architecture, downloads the Tailwind CLI, builds CSS, watches for changes, and starts Jekyll with live reload.
- `make help` — Shows all available make commands and their descriptions.

### Dependencies

All runtime dependencies are managed inside the Docker container. You only need Docker and Make installed on your machine. The container handles:

- Ruby 2.7 and Bundler (for Jekyll)
- Tailwind CSS standalone CLI (downloaded automatically, no Node.js)
- All required Ruby gems (see `Gemfile`)

### CI/CD Pipeline

The GitHub Actions workflow (`.github/workflows/deploy.yml`) runs a sequential pipeline:

1. **Download Tailwind CLI** (pinned version, linux-x64)
2. **Build CSS** (`tailwindcss -i input.css -o output.css --minify`)
3. **Build Jekyll** (`bundle exec jekyll build`)
4. **Deploy** to GitHub Pages

## Project Structure

```
├── _includes/          # Reusable HTML components (navbar, footer, head, etc.)
├── _layouts/           # Page layouts (default, blog-post)
├── _posts/             # Blog posts (Markdown)
├── assets/
│   ├── css/
│   │   ├── input.css   # Tailwind v4 source (theme, @font-face, custom styles)
│   │   └── output.css  # Generated (gitignored, built by CLI)
│   ├── fonts/Inter/    # Inter woff2 files (5 weights)
│   ├── scripts/
│   │   ├── alpine.min.js       # Alpine.js (local)
│   │   └── scroll-animations.js # IntersectionObserver animations
│   └── images/
├── .github/workflows/  # CI/CD pipeline
├── makefile            # Docker-based dev commands
├── _config.yml         # Jekyll configuration
├── Gemfile             # Ruby dependencies
└── tailwindcss         # Standalone CLI binary (gitignored)
```

## Usage

- Edit `_config.yml` to update site settings, URLs, and metadata.
- Add your posts in the `_posts` directory.
- Customize styles in `assets/css/input.css` (Tailwind v4 syntax).
- All static assets are located in the `assets/` folder.

## Contributing

Contributions are welcome! Please open issues or submit pull requests for improvements and bug fixes.

## License

Distributed under the MIT License. See `LICENSE` for more information.

---

**Made with ❤️ by [Douglas Medeiros](https://github.com/medeirosinacio)**
