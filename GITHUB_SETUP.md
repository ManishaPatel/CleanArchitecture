# GitHub Setup Instructions

Follow these steps to upload your Flutter Clean Architecture app to GitHub:

## Step 1: Create a GitHub Repository

1. Go to [GitHub](https://github.com) and sign in
2. Click the **"+"** icon in the top right corner
3. Select **"New repository"**
4. Fill in the repository details:
   - **Repository name**: `flutter-clean-architecture-app`
   - **Description**: `A Flutter Task Manager app built with Clean Architecture, GetX state management, and REST API integration`
   - **Visibility**: Choose Public or Private
   - **DO NOT** initialize with README, .gitignore, or license (we already have these)
5. Click **"Create repository"**

## Step 2: Connect Local Repository to GitHub

After creating the repository, GitHub will show you commands. Use these commands in your terminal:

### Option A: If you haven't created the repository yet
```bash
git remote add origin https://github.com/YOUR_USERNAME/flutter-clean-architecture-app.git
git branch -M main
git push -u origin main
```

### Option B: If you already created the repository
Replace `YOUR_USERNAME` with your GitHub username:
```bash
git remote add origin https://github.com/YOUR_USERNAME/flutter-clean-architecture-app.git
git branch -M main
git push -u origin main
```

## Step 3: Push Your Code

If you're using HTTPS and GitHub asks for credentials:
- Use a **Personal Access Token** (not your password)
- To create one: GitHub Settings → Developer settings → Personal access tokens → Tokens (classic) → Generate new token
- Give it `repo` permissions

If you're using SSH:
```bash
git remote set-url origin git@github.com:YOUR_USERNAME/flutter-clean-architecture-app.git
git push -u origin main
```

## Alternative: Using GitHub CLI

If you have GitHub CLI installed:
```bash
gh repo create flutter-clean-architecture-app --public --source=. --remote=origin --push
```

## Verify Upload

1. Go to your repository on GitHub
2. You should see all your files including:
   - README.md
   - lib/ folder with all your code
   - pubspec.yaml
   - All other project files

## Next Steps

- Add screenshots to your README.md
- Add topics/tags to your repository (Flutter, Clean Architecture, GetX, etc.)
- Consider adding a LICENSE file
- Set up GitHub Actions for CI/CD (optional)

## Troubleshooting

### If you get "remote origin already exists":
```bash
git remote remove origin
git remote add origin https://github.com/YOUR_USERNAME/flutter-clean-architecture-app.git
```

### If you need to change the branch name:
```bash
git branch -M main
git push -u origin main
```

### If you need to force push (use with caution):
```bash
git push -u origin main --force
```

