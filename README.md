# IF-EDUprime - Plateforme d'apprentissage innovante

![Status](https://img.shields.io/badge/Status-Development-blue)
![Version](https://img.shields.io/badge/Version-1.0.0-green)
![License](https://img.shields.io/badge/License-Proprietary-red)

**IF-EDUprime révolutionne l'apprentissage en ligne avec des cours captivants et des animations qui vous feront sourire. Dites adieu aux cours ennuyeux et bonjour à l'apprentissage dynamique!**

## 📋 Table des matières

- [À propos](#à-propos)
- [Fonctionnalités](#fonctionnalités)
- [Structure du projet](#structure-du-projet)
- [Installation](#installation)
- [Déploiement](#déploiement)
- [Docker & CI/CD](#docker--cicd)
- [Contribution](#contribution)
- [Support](#support)

## 🎯 À propos

IF-EDUprime est une plateforme éducative moderne qui offre une expérience d'apprentissage engageante avec:
- Cours interactifs et animés
- Interface utilisateur intuitive
- Contenu pédagogique de qualité
- Système de mentoring professionnel
- Blog et ressources éducatives

## ✨ Fonctionnalités

### 📚 Modules Principaux
- **Accueil**: Landing page dynamique
- **À propos**: Présentation et valeurs
- **Cours**: Catalogue complet de formations
- **Blog**: Articles et ressources éducatives
- **Mentors**: Profils et services de mentoring
- **Services**: Offres et packages
- **FAQ**: Questions fréquemment posées
- **Contact**: Formulaire de contact
- **Centre d'aide**: Documentation complète

### 🎨 Caractéristiques Techniques
- Design responsive (mobile, tablet, desktop)
- Animations fluides et engageantes
- Performance optimisée
- Accessibilité WCAG
- SEO-friendly

## 📁 Structure du projet

```
IF-EDUprime/
├── html/                          # Pages HTML principales
│   ├── index.html                 # Accueil
│   ├── about.html                 # À propos
│   ├── course.html                # Catalogue de cours
│   ├── blog.html                  # Blog
│   ├── mentor.html                # Mentors
│   └── ...autres pages
├── css/                           # Feuilles de style
│   ├── bootstrap.min.css
│   ├── style.css                  # Styles personnalisés
│   └── theme-default.css
├── js/                            # Scripts JavaScript
│   ├── jquery-3.6.2.min.js
│   ├── theme.js                   # Script principal
│   └── ...autres scripts
├── png/, jpg/, svg/               # Assets d'images
├── Centrale_d'aide/               # Documentation d'aide
├── IF/                            # Dossier de configuration
├── Docker/
│   ├── Dockerfile                 # Image Docker
│   ├── docker-compose.yml         # Orchestration
│   └── nginx.conf                 # Nginx config
├── CI-CD/
│   └── .gitlab-ci.yml             # Pipeline GitLab CI/CD
├── Makefile                       # Commands rapides
└── README.md                      # Ce fichier

```

## 🚀 Installation

### Prérequis
- Git
- Node.js 18+ (optionnel)
- Docker & Docker Compose (pour la containerisation)

### Étapes

1. **Cloner le projet**
```bash
git clone https://gitlab.com/Ourajeenn/eduprime.git
cd eduprime
```

2. **Checkout de la branche appropriée**
```bash
# Pour le développement
git checkout dev

# Pour la production
git checkout main
```

3. **Installer les dépendances (optionnel)**
```bash
npm install
```

## 🐳 Docker & CI/CD

### Démarrage rapide avec Docker

```bash
# Construire l'image
make build

# Démarrer les conteneurs
make up

# Accéder à l'application
# http://localhost
```

### Pipeline CI/CD GitLab

Le projet inclut une pipeline complète (`/.gitlab-ci.yml`):

- **Lint**: Validation HTML et Dockerfile
- **Build**: Construction et push de l'image Docker
- **Test**: Tests d'intégrité
- **Security**: Scan de vulnérabilités
- **Deploy**: Déploiement automatisé

Pour plus de détails: [DOCKER-README.md](./DOCKER-README.md)

## 📝 Configuration

### Variables d'environnement

Créer une `.env` depuis `.env.example`:
```bash
cp .env.example .env
```

Modifier selon vos besoins:
```env
NODE_ENV=production
APP_URL=http://localhost
NGINX_PORT=80
```

## 📦 Déploiement

### Local
```bash
make up
```

### Développement (GitLab)
```bash
git checkout dev
git push origin dev
# Pipeline se déclenche automatiquement
```

### Production (GitLab)
```bash
git checkout main
git push origin main
# Push d'une version tagguée déclenche le déploiement
git tag v1.0.0
git push origin v1.0.0
```

Plus de détails: [DEPLOY-INSTRUCTIONS.md](./DEPLOY-INSTRUCTIONS.md)

## 🛠️ Commandes disponibles

### Avec Make
```bash
make help              # Afficher l'aide
make build             # Construire l'image Docker
make up                # Démarrer les conteneurs
make down              # Arrêter les conteneurs
make logs              # Voir les logs
make test              # Exécuter les tests
make clean             # Nettoyer les images
```

### Avec Docker Compose
```bash
docker-compose build
docker-compose up -d
docker-compose down
docker-compose logs -f
```

## 📊 Branches

- **main**: Production - Code stable et testé
- **dev**: Développement - Nouvelles features et fixes
- **feature/***: Features en développement

## 🔒 Sécurité

- Headers de sécurité HTTP
- Compression Gzip activée
- Cache control mis en place
- Validation d'entrées
- Sanitization du contenu

## 🤝 Contribution

### Processus de contribution

1. Fork le projet
2. Créer une branche feature (`git checkout -b feature/AmazingFeature`)
3. Commit les changements (`git commit -m 'Add AmazingFeature'`)
4. Push vers la branche (`git push origin feature/AmazingFeature`)
5. Ouvrir une Pull Request

### Guidelines

- Respecter le style de code existant
- Ajouter des tests pour les nouvelles features
- Mettre à jour la documentation
- Utiliser des messages de commit clairs

## 🐛 Signaler des bugs

Créer une issue sur GitLab avec:
- Description du bug
- Étapes pour reproduire
- Résultat attendu vs réel
- Screenshots si possible

## 📚 Documentation

- [Docker & CI/CD](./DOCKER-README.md)
- [Instructions de déploiement](./DEPLOY-INSTRUCTIONS.md)
- [Centre d'aide](./Centrale_d'aide/)

## 👥 Équipe

- **Lead Developer**: Ourajene
- **Designer**: [À compléter]
- **Project Manager**: [À compléter]

## 📞 Support

Pour toute question ou support:
- 📧 Email: info@if-eduprime.com
- 🐛 Issues: https://gitlab.com/Ourajeenn/eduprime/-/issues
- 💬 Discussions: https://gitlab.com/Ourajeenn/eduprime/-/discussions

## 📄 Licence

Ce projet est propriétaire. Tous les droits réservés © 2026 IF-EDUprime

## 🙏 Remerciements

- Merci à tous les contributeurs
- Bootstrap - Framework CSS
- jQuery - Bibliothèque JavaScript
- Nginx - Serveur web

---

**Dernière mise à jour**: Avril 2026

**Repository**: https://gitlab.com/Ourajeenn/eduprime

**Website**: [À compléter]
