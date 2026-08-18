# Academic Website

## Local development

Requires Ruby and Bundler.

```bash
bundle install
bundle exec jekyll serve
```

## Editing content

| File | Description |
|------|-----------------|
| `_config.yml` | profile details |
| `_data/publications.yml` | publications and preprints |
| `_data/research_themes.yml` | research theme titles, descriptions, and IDs |
| `_data/open_source.yml` | open source project listings |
| `_data/teaching.yml` | courses taught |
| `_data/media.yml` | press, podcasts, interviews |
| `_projects/*.md` | open source project detail pages |
| `_courses/*.md` | course detail pages |
| `_blog/*.md` | blog posts — front matter: `title`, `date`, `summary`; body is the post (LaTeX via `$$...$$`) |
| `assets/img/profile.jpg` | profile photo |
| `assets/pdf/cv.pdf` | CV file |

## Tabs

In `_config.yml`:

- `nav` — tabs, in order (`id`, `title`, `url`)
- `active_pages` — `id: true/false`; `false` hides the tab and drops the page from the build

Add: append to both. Remove: delete from `nav` (or set `active_pages: false` to keep it staged but hidden). Reorder: reorder `nav`.

Pages opt in via `nav_id: <id>` in front matter.

## Using this as a template

On GitHub: **Use this template -> Create a new repository**, name it `username.github.io`, public. Then follow **Deploying to GitHub Pages** below.

## Deploying to GitHub Pages

1. Create repo `[username].github.io`
2. Set in `_config.yml`:
   ```yaml
   url: "https://yourusername.github.io"
   baseurl: ""
   ```
3. Settings -> Pages -> Source -> GitHub Actions
4. Push:
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git remote add origin https://github.com/yourusername/yourusername.github.io.git
   git push -u origin main
   ```

Pushes to `main` trigger `.github/workflows/deploy.yml`, which builds and deploys the site.
