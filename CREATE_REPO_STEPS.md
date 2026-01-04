# Steps to Create GitHub Repository and Push Code

## Step 1: Create Repository on GitHub

1. Go to: https://github.com/new
2. Fill in the details:
   - **Repository name**: `flutter-clean-architecture-app`
   - **Description**: `A Flutter Task Manager app built with Clean Architecture, GetX state management, and REST API integration`
   - **Visibility**: Choose **Public** or **Private**
   - ⚠️ **IMPORTANT**: Do NOT check any of these boxes:
     - ❌ Add a README file
     - ❌ Add .gitignore
     - ❌ Choose a license
   (We already have these files in the project)
3. Click **"Create repository"**

## Step 2: Push Your Code

After creating the repository, run these commands in your terminal:

```bash
git push --set-upstream origin main
```

If you're prompted for credentials:
- **Username**: Your GitHub username (ManishaPatel)
- **Password**: Use a **Personal Access Token** (NOT your GitHub password)

### How to Create a Personal Access Token:

1. Go to: https://github.com/settings/tokens
2. Click **"Generate new token"** → **"Generate new token (classic)"**
3. Give it a name: "Flutter Project"
4. Select scopes: Check **`repo`** (this gives full repository access)
5. Click **"Generate token"**
6. **Copy the token immediately** (you won't see it again!)
7. Use this token as your password when pushing

## Step 3: Verify

After pushing, visit:
https://github.com/ManishaPatel/flutter-clean-architecture-app

You should see all your files there!

