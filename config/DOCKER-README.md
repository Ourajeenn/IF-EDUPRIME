# IF-EDUprime Docker & CI/CD Setup

Documentation complète pour Docker, Docker Compose et GitLab CI/CD Pipeline.

## Table des matières
- [Vue d'ensemble](#vue-densemble)
- [Prérequis](#prérequis)
- [Installation](#installation)
- [Utilisation](#utilisation)
- [Pipeline CI/CD](#pipeline-cicd)
- [Déploiement](#déploiement)
- [Dépannage](#dépannage)

## Vue d'ensemble

Ce projet utilise:
- **Docker**: Containerisation de l'application
- **Docker Compose**: Orchestration multi-conteneurs
- **GitLab CI/CD**: Automatisation des tests, builds et déploiements

La pile technique:
- **Frontend**: HTML5, CSS3, JavaScript
- **Serveur**: Nginx
- **Compression**: Gzip activée

## Prérequis

### Système local
- Docker (version 20.10+)
- Docker Compose (version 1.29+)
- Git
- Make (optionnel, pour les commandes rapides)

### Pour GitLab CI/CD
- Projet GitLab
- GitLab Runner configuré
- Accès au GitLab Registry

## Installation

### 1. Cloner le projet

```bash
git clone https://gitlab.com/Ourajeenn/eduprime.git
cd eduprime
```

### 2. Checkout de la branche dev

```bash
git checkout dev
```

### 3. Vérifier les fichiers Docker

```bash
ls -la | grep -E "Dockerfile|docker-compose|nginx|\.dockerignore|Makefile"
```

## Utilisation

### Commands avec Make (recommandé)

```bash
# Afficher l'aide
make help

# Construire l'image
make build

# Démarrer les conteneurs
make up

# Arrêter les conteneurs
make down

# Voir les logs
make logs

# Accéder au shell du conteneur
make shell

# Exécuter les tests
make test

# Nettoyer (supprimer conteneurs et images)
make clean
```

### Commands Docker Compose directes

```bash
# Construire l'image
docker-compose build

# Démarrer les services
docker-compose up -d

# Arrêter les services
docker-compose down

# Voir les logs
docker-compose logs -f

# Afficher l'état des services
docker-compose ps

# Exécuter une commande dans le conteneur
docker-compose exec web sh
```

### Accès à l'application

Après `make up` ou `docker-compose up`:
- Application: `http://localhost` (port 80)
- Nginx: Port 80 ouvert
- HTTPS: Port 443 (configuration optionnelle)

## Pipeline CI/CD

### Étapes de la pipeline

1. **Lint Stage**
   - Validation du Dockerfile
   - Vérification des fichiers HTML

2. **Build Stage**
   - Construction de l'image Docker
   - Push vers GitLab Registry
   - Tagging (commit SHA + latest)

3. **Test Stage**
   - Tests de validité HTML
   - Tests de l'image Docker
   - Validation docker-compose

4. **Security Stage**
   - Scan avec Trivy
   - Vérification des secrets

5. **Deploy Stage**
   - Déploiement en dev (manuel)
   - Déploiement en prod (manuel + sur tag)
   - Rollback possible

### Fichier `.gitlab-ci.yml`

Le fichier définit:
- 6 stages d'exécution
- 10+ jobs d'automatisation
- Triggers basés sur branches
- Environnements (dev, production)
- Approvals manuels

### Variables d'environnement GitLab

À configurer dans GitLab Settings > CI/CD > Variables:

```
CI_REGISTRY_USER=your-gitlab-username
CI_REGISTRY_PASSWORD=your-personal-access-token
DOCKER_HUB_USERNAME=optional
DOCKER_HUB_PASSWORD=optional
```

## Déploiement

### Local (dev)

```bash
# Option 1: avec Make
make deploy-local

# Option 2: avec docker-compose
docker-compose up -d
```

### Staging (dev branch)

1. Push vers branche `dev`
2. Pipeline se déclenche automatiquement
3. Build l'image avec tag `dev-${COMMIT_SHA}`
4. Attendre validation des tests
5. Cliquer "Deploy" manuellement dans GitLab

### Production (main branch)

1. Créer une pull request vers `main`
2. Attendre approval
3. Merger vers `main`
4. Push crée un commit
5. Pipeline se déclenche automatiquement
6. Build l'image avec tags `${COMMIT_SHA}` et `latest`
7. Cliquer "Deploy" manuellement dans GitLab

### Via tags

```bash
# Créer un tag (déclenche déploiement production)
git tag v1.0.0
git push origin v1.0.0
```

## Structure des fichiers

```
.
├── Dockerfile              # Configuration Docker pour build multi-stage
├── docker-compose.yml      # Orchestration des services
├── nginx.conf             # Configuration Nginx
├── default.conf           # Virtual host Nginx
├── .dockerignore          # Fichiers à exclure du build Docker
├── .gitlab-ci.yml         # Configuration du pipeline CI/CD
├── Makefile               # Commands rapides
├── html/                  # Pages HTML
├── css/                   # Feuilles de style
├── js/                    # Scripts JavaScript
├── png/, jpg/, svg/       # Images et assets
└── ...
```

## Security

### Mesures implémentées

- Headers de sécurité (X-Frame-Options, X-Content-Type-Options)
- Restriction des permissions
- Limits d'upload (20MB max)
- Gzip compression
- Cache control headers
- Denial de fichiers sensibles (.git, .env)

### Bonnes pratiques

1. **Image minimale**: Alpine Linux utilisé
2. **Multi-stage build**: Réduit la taille
3. **Read-only volumes**: Pour la prod
4. **Health checks**: Monitoring des conteneurs
5. **Non-root user**: Nginxuser par défaut

## Dépannage

### Le conteneur ne démarre pas

```bash
# Vérifier les logs
docker-compose logs web

# Vérifier la configuration nginx
docker-compose exec web nginx -t

# Reconstruire l'image
docker-compose build --no-cache
```

### Port déjà utilisé

```bash
# Libérer le port 80
sudo lsof -i :80
sudo kill -9 <PID>

# Ou utiliser un autre port dans docker-compose.yml
# ports: "8080:80"
```

### GitLab Runner non trouvé

```bash
# Vérifier les runners disponibles
gitlab-runner verify --config gitlab-runner-config.toml

# Enregistrer un nouveau runner
gitlab-runner register
```

### Build Docker échoué

```bash
# Reconstruire sans cache
docker build --no-cache -t eduprime:dev .

# Vérifier l'espace disque
docker system df

# Nettoyer
docker system prune -a
```

## Performance

### Optimisations incluses

- **Caching layers**: Images réutilisées
- **Gzip compression**: CSS, JS, HTML compressés
- **HTTP caching**: Headers cache-control configurés
- **Asset optimization**: Expiration 30 jours pour images/JS/CSS

### Monitoring

```bash
# Vérifier l'utilisation des ressources
docker stats

# Voir les détails du conteneur
docker-compose ps
docker-compose exec web free -h
```

## Maintenance

### Mettre à jour Nginx

1. Modifier le `Dockerfile`:
```dockerfile
FROM nginx:latest-alpine
```

2. Rebuild:
```bash
make build
```

### Ajouter des fichiers statiques

1. Copier les fichiers dans le projet
2. Ajouter la ligne dans `Dockerfile`:
```dockerfile
COPY nouveau_dossier /usr/share/nginx/html/nouveau_dossier
```

3. Rebuild et redémarrer

## Support et contribution

Pour des questions ou des contributions:
- Issues: https://gitlab.com/Ourajeenn/eduprime/-/issues
- Wiki: https://gitlab.com/Ourajeenn/eduprime/-/wikis/home

## Licence

Ce projet est sous licence [à définir]

---

**Dernière mise à jour**: 2026-04-10
