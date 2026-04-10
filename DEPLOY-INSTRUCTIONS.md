# Instructions de déploiement vers GitLab

## Problème d'authentification

Si vous rencontrez l'erreur:
```
fatal: repository 'https://gitlab.com/Ourajeenn/eduprime.git/' not found
```

## Solutions

### Option 1: Utiliser SSH (Recommandé)

1. **Générer une clé SSH** (si vous n'en avez pas):
```bash
ssh-keygen -t ed25519 -C "your-email@example.com"
```

2. **Ajouter la clé à GitLab**:
   - Aller sur GitLab.com
   - Settings > SSH Keys
   - Copier le contenu de `~/.ssh/id_ed25519.pub`
   - Coller et enregistrer

3. **Changer le remote**:
```bash
git remote set-url origin git@gitlab.com:Ourajeenn/eduprime.git
```

4. **Pousser les branches**:
```bash
git push -u origin main
git checkout dev
git push -u origin dev
```

### Option 2: Utiliser un Personal Access Token (PAT)

1. **Créer un PAT sur GitLab**:
   - GitLab.com > Settings > Access Tokens
   - Cocher: api, read_api, write_repository
   - Créer et copier le token

2. **Utiliser le token**:
```bash
git push https://oauth2:YOUR_TOKEN@gitlab.com/Ourajeenn/eduprime.git main
git push https://oauth2:YOUR_TOKEN@gitlab.com/Ourajeenn/eduprime.git dev
```

3. **Ou stocker dans `.git/config`**:
```bash
git config user.password "YOUR_TOKEN"
```

### Option 3: Utiliser Git Credential Manager

```bash
# Installer GCM
# https://github.com/git-ecosystem/git-credential-manager

git config --global credential.helper manager-core

# La prochaine fois que vous pousserez, GCM vous demandera de vous identifier
git push -u origin main
```

## Vérifier la configuration

```bash
# Voir les remotes
git remote -v

# Voir la configuration globale
git config --global -l

# Voir la configuration du projet
git config -l
```

## Statut du projet

### Branches créées localement:
- ✅ main (avec commit initial)
- ✅ dev (avec Docker et CI/CD setup)

### Fichiers préparés pour le push:
- ✅ Dockerfile
- ✅ docker-compose.yml
- ✅ nginx.conf
- ✅ default.conf
- ✅ .gitlab-ci.yml
- ✅ Makefile
- ✅ .dockerignore
- ✅ .env.example
- ✅ DOCKER-README.md

### Prêt pour:
- 🔧 CI/CD Pipeline
- 🐳 Docker Build & Push
- 🚀 Déploiement Automatisé

## Commandes rapides après authentification

```bash
# Pousser les deux branches
git push -u origin main
git push -u origin dev

# Vérifier le statut
git log --oneline -5
git branch -vv

# Voir le projet sur GitLab
# https://gitlab.com/Ourajeenn/eduprime
```

## Notes

- Le projet contient **460 fichiers** dans la branche main
- Le répertoire `.git` fait environ **50-100MB**
- Le push initial peut prendre quelques minutes
- L'authentification n'est nécessaire qu'une fois avec GCM

---

Pour plus d'aide: https://docs.gitlab.com/ee/user/ssh.html
