
# Séance 2 — Exercices SwiftUI pas à pas

Dans ce TP vous allez créer les premières vues de l'application **MyReceipes, affichant 5 cartes de recettes scrollables.

Ce guide vous accompagne étape par étape. Suivez-le dans l'ordre : **2.1 → 2.2 → 2.3**.

---

## Prérequis — Vérifier votre projet

Avant de commencer, vérifiez les points suivants :

1. **Xcode 15 ou supérieur** est installé sur votre Mac.
2. Clonez le repository sur votre poste
3. Ouvrir le projet dans Xcode 


**Vérifier que tout compile** : appuyez sur `Cmd + B` (Build). Si vous voyez « Build Succeeded », vous êtes prêt·e.

---

# Exercice 2.1 — Hello SwiftUI

> ⏱ **20 minutes** • Objectif : se familiariser avec les bases de SwiftUI (VStack, Image, Text, Button) et la Preview Xcode.

## Ce qu'on va construire

Une vue d'accueil simple : une grosse icône, un titre, un sous-titre et un bouton « Continuer ». Cet écran ne sera pas conservé dans l'app finale, c'est juste un échauffement.

```
┌────────────────────────────┐
│                            │
│           🍴               │
│                            │
│  Bienvenue dans MyRecipes  │
│                            │
│  Découvrez et partagez     │
│  vos recettes préférées    │
│                            │
│       [ Continuer ]        │
│                            │
└────────────────────────────┘
```

## Étape 1.1 — Créer le fichier

1. Dans Xcode, dans le panneau de gauche, faites un **clic droit** sur le dossier du projet (sous l'icône bleue `MyRecipes`).
2. Choisissez **New File…**.
3. Sélectionnez **SwiftUI View** dans la catégorie iOS, puis cliquez sur **Next**.
4. Nommez le fichier `HelloView` et cliquez sur **Create**.

Xcode crée automatiquement un fichier avec une structure minimale et une `#Preview`.

## Étape 1.2 — Lire le squelette généré

Vous devriez voir un code similaire à :

```swift
import SwiftUI

struct HelloView: View {
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    HelloView()
}
```

**À comprendre** :
- `struct HelloView: View` : on crée une vue (un type SwiftUI).
- `var body: some View` : la propriété qui décrit ce que la vue affiche.
- `#Preview { ... }` : le bloc qui apparaît dans le canevas en haut à droite.

## Étape 1.3 — Empiler les éléments avec un VStack

Remplacez le contenu de `body` par :

```swift
var body: some View {
    VStack(spacing: 24) {
        Image(systemName: "fork.knife.circle.fill")
            .font(.system(size: 80))
            .foregroundStyle(.orange)

        Text("Bienvenue dans MyRecipes")
            .font(.title)
            .bold()

        Text("Découvrez et partagez vos recettes préférées")
            .foregroundStyle(.secondary)

        Button("Continuer") { }
            .buttonStyle(.borderedProminent)
    }
}
```

**Activez la Preview** : si elle n'est pas visible, appuyez sur `Cmd + Option + Return`. Si elle est en pause, cliquez sur **Resume** (ou `Cmd + Option + P`).

À ce stade, vous devriez voir les 4 éléments empilés au centre.

## Étape 1.4 — Affiner la mise en forme

Quelques modifiers à ajouter pour rendre l'écran plus joli :

```swift
var body: some View {
    VStack(spacing: 24) {
        Image(systemName: "fork.knife.circle.fill")
            .font(.system(size: 80))
            .foregroundStyle(.orange)

        Text("Bienvenue dans MyRecipes")
            .font(.system(size: 28, weight: .bold, design: .rounded))
            .multilineTextAlignment(.center)

        Text("Découvrez et partagez vos recettes préférées")
            .font(.body)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 40)

        Button("Continuer") { }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
    }
    .padding()
}
```

**Sauvegardez** (`Cmd + S`) et regardez la Preview se mettre à jour.

## Étape 1.5 — Tester en Light et Dark Mode

Dans la Preview, cliquez sur l'icône de variantes en bas à gauche du canevas, puis activez **Color Scheme Variants**. Vous voyez maintenant la même vue en mode clair ET en mode sombre.

Vérifiez que tout reste lisible.

## Étape 1.6 — Vérifier sur le simulateur

1. Dans la barre de Xcode, sélectionnez l'app `HelloView` comme entry point. Pour cela, ouvrez `MyRecipesApp.swift` et remplacez temporairement `ContentView()` par `HelloView()`.
2. Sélectionnez le simulateur **iPhone 15** dans le sélecteur du haut.
3. Appuyez sur `Cmd + R`.

Une fois validé, **remettez `ContentView()`** dans `MyRecipesApp.swift` (on en aura besoin pour 2.3).

## ✅ Critères de validation 2.1

- [ ] Le fichier `HelloView.swift` existe et compile.
- [ ] La Preview affiche les 4 éléments centrés.
- [ ] L'icône est orange et fait 80 pt.
- [ ] Le bouton « Continuer » est dans le style « bordered prominent ».
- [ ] Le texte sous-titre est limité en largeur (40 pt de padding horizontal).
- [ ] La vue s'affiche correctement en Light ET Dark mode.

---

# Exercice 2.2 — RecipeCardView

> ⏱ **60 minutes** • Objectif : créer un composant **réutilisable** qui affiche les informations principales d'une recette. C'est la brique visuelle qu'on réutilisera dans toute l'application.

## Ce qu'on va construire

Une carte avec :
- une image en haut (placeholder visuel),
- un titre en gras,
- un résumé en petit gris,
- une rangée d'infos (durée, portions, difficulté),
- un fond arrondi avec une légère ombre.

```
┌──────────────────────────────────┐
│                                  │
│           [ image ]              │
│                                  │
├──────────────────────────────────┤
│ Tarte aux pommes                 │
│ Le classique inratable du …      │
│ ⏱ 60 min  👥 6 pers  🔥 Facile  │
└──────────────────────────────────┘
```

## Étape 2.1 — Créer le fichier

1. Clic droit sur le projet → **New File…** → **SwiftUI View** → nommez-le `RecipeCardView`.
2. Remplacez le contenu généré par :

```swift
import SwiftUI

struct RecipeCardView: View {
    let recipe: Recipe   // ① on reçoit une recette en paramètre

    var body: some View {
        Text(recipe.title)   // ② point de départ minimal
    }
}

#Preview {
    RecipeCardView(recipe: MockData.sample[0])
        .padding()
}
```

**Pourquoi ça marche déjà ?**
- ① La carte ne fabrique pas de données : elle reçoit une `Recipe` de l'extérieur. C'est le principe d'un **composant réutilisable**.
- ② La Preview affiche `MockData.sample[0]`, qui est notre première recette de démo.

Lancez la Preview : vous devriez voir « Tarte aux pommes » dans l'écran.

## Étape 2.2 — Construire la zone image

Remplacez `Text(recipe.title)` par :

```swift
var body: some View {
    VStack(alignment: .leading, spacing: 0) {

        // MARK: Image
        ZStack {
            LinearGradient(
                colors: [.orange.opacity(0.6), .pink.opacity(0.4)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            Image(systemName: "fork.knife.circle.fill")
                .font(.system(size: 60))
                .foregroundStyle(.white.opacity(0.85))
        }
        .frame(height: 180)
    }
}
```

**Ce que ça fait** :
- `ZStack` superpose le dégradé et l'icône.
- `LinearGradient` est un fond coloré (on simule une vraie image).
- `frame(height: 180)` impose une hauteur fixe à la zone image.

Vérifiez la Preview : vous voyez maintenant un grand rectangle coloré avec une icône au centre.

## Étape 2.3 — Ajouter le bloc de texte

Juste **après** le `ZStack` (toujours dans le `VStack`), ajoutez :

```swift
        // MARK: Bloc de texte
        VStack(alignment: .leading, spacing: 6) {
            Text(recipe.title)
                .font(.headline)

            Text(recipe.summary)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineLimit(2)
        }
        .padding(12)
```

À ce stade, votre Preview affiche :
- le rectangle coloré avec l'icône,
- le titre en gras juste en-dessous,
- le résumé en gris en deux lignes max.

## Étape 2.4 — Ajouter la rangée d'infos

Toujours **dans le `VStack` interne** (celui qui contient les textes), ajoutez après le résumé :

```swift
            HStack(spacing: 12) {
                Label("\(recipe.durationMinutes) min", systemImage: "clock")
                Label("\(recipe.servings) pers.", systemImage: "person.2")
                Spacer()
                Label(recipe.difficulty.rawValue,
                      systemImage: recipe.difficulty.iconName)
                    .foregroundStyle(.orange)
            }
            .font(.caption)
            .foregroundStyle(.secondary)
            .padding(.top, 4)
```

**Ce que ça fait** :
- `Label("texte", systemImage: "icone")` est un raccourci pratique : icône + texte alignés.
- `Spacer()` pousse la difficulté à droite.
- `.font(.caption)` réduit la taille à tous les éléments du `HStack`.

## Étape 2.5 — Donner forme à la carte

Maintenant on stylise tout l'ensemble. **À l'extérieur du `VStack` principal**, ajoutez ces modifiers :

```swift
    }   // fin du VStack principal
    .background(Color(.systemBackground))
    .clipShape(RoundedRectangle(cornerRadius: 16))
    .shadow(color: .black.opacity(0.08), radius: 6, y: 3)
```

⚠️ **Attention à l'ordre des modifiers** :
1. D'abord `background` (fond blanc en mode clair, noir en mode sombre).
2. Ensuite `clipShape` pour arrondir.
3. Enfin `shadow` pour l'ombre **en dehors** du clip.

Si vous mettez `clipShape` avant `background`, le fond passera **au-dessus** des coins arrondis et écrasera l'effet.

## Étape 2.6 — Mettre à jour la Preview

Pour bien voir l'ombre, ajoutez un fond gris à la Preview :

```swift
#Preview("Une carte") {
    RecipeCardView(recipe: MockData.sample[0])
        .padding()
        .background(Color(.systemGroupedBackground))
}
```

Vous pouvez **multiplier les Previews** pour tester plusieurs cas :

```swift
#Preview("Carte difficile") {
    RecipeCardView(recipe: MockData.sample[4])
        .padding()
        .background(Color(.systemGroupedBackground))
}

#Preview("Mode sombre") {
    RecipeCardView(recipe: MockData.sample[2])
        .padding()
        .background(Color(.systemGroupedBackground))
        .preferredColorScheme(.dark)
}
```

Trois Previews apparaissent côte à côte : c'est très pratique pour comparer.

## Étape 2.7 — Code final attendu

Votre fichier devrait ressembler à ceci :

```swift
import SwiftUI

struct RecipeCardView: View {
    let recipe: Recipe

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            // MARK: Image
            ZStack {
                LinearGradient(
                    colors: [.orange.opacity(0.6), .pink.opacity(0.4)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                Image(systemName: "fork.knife.circle.fill")
                    .font(.system(size: 60))
                    .foregroundStyle(.white.opacity(0.85))
            }
            .frame(height: 180)

            // MARK: Bloc de texte
            VStack(alignment: .leading, spacing: 6) {
                Text(recipe.title)
                    .font(.headline)

                Text(recipe.summary)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)

                HStack(spacing: 12) {
                    Label("\(recipe.durationMinutes) min", systemImage: "clock")
                    Label("\(recipe.servings) pers.", systemImage: "person.2")
                    Spacer()
                    Label(recipe.difficulty.rawValue,
                          systemImage: recipe.difficulty.iconName)
                        .foregroundStyle(.orange)
                }
                .font(.caption)
                .foregroundStyle(.secondary)
                .padding(.top, 4)
            }
            .padding(12)
        }
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.08), radius: 6, y: 3)
    }
}

#Preview("Une carte") {
    RecipeCardView(recipe: MockData.sample[0])
        .padding()
        .background(Color(.systemGroupedBackground))
}
```

## ✅ Critères de validation 2.2

- [ ] Le fichier `RecipeCardView.swift` compile sans erreur.
- [ ] La carte montre une zone image (dégradé + icône) en haut.
- [ ] Le titre est en `.headline`, le résumé en `.subheadline` gris (max 2 lignes).
- [ ] La rangée d'infos affiche durée, portions et difficulté avec icônes.
- [ ] Les coins de la carte sont arrondis (16 pt).
- [ ] Une ombre légère est visible.
- [ ] La Preview fonctionne en Light et Dark mode.

---

# Exercice 2.3 — Galerie de cartes

> ⏱ **30 minutes** • Objectif : afficher les 5 recettes de `MockData` dans un écran scrollable.

## Ce qu'on va construire

L'écran principal de l'application :

```
┌────────────────────────┐
│  MyRecipes             │
│  5 recettes à explorer │
│                        │
│  ┌──── Carte 1 ────┐   │
│  │                 │   │
│  └─────────────────┘   │
│                        │
│  ┌──── Carte 2 ────┐   │
│  │   (scroll ↓)    │   │
│  └─────────────────┘   │
│         …              │
└────────────────────────┘
```

## Étape 3.1 — Ouvrir ContentView

Dans Xcode, ouvrez `ContentView.swift`. Remplacez tout le contenu par :

```swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Bientôt")   // placeholder, on va le remplacer
    }
}

#Preview {
    ContentView()
}
```

## Étape 3.2 — Ajouter un ScrollView

Remplacez `Text("Bientôt")` par :

```swift
var body: some View {
    ScrollView {
        VStack(alignment: .leading, spacing: 20) {
            Text("Hello scroll")
        }
    }
}
```

`ScrollView` rend son contenu **scrollable** verticalement (par défaut). Indispensable dès qu'on a plus que ce qui tient à l'écran.

## Étape 3.3 — Ajouter l'en-tête

Remplacez `Text("Hello scroll")` par un en-tête avec titre et sous-titre :

```swift
            VStack(alignment: .leading, spacing: 4) {
                Text("MyRecipes")
                    .font(.system(size: 36, weight: .bold, design: .rounded))

                Text("\(MockData.sample.count) recettes à explorer")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal, 16)
            .padding(.top, 24)
```

## Étape 3.4 — Boucler sur les recettes avec ForEach

Juste **après** le `VStack` de l'en-tête (toujours dans le `VStack` principal), ajoutez :

```swift
            VStack(spacing: 16) {
                ForEach(MockData.sample) { recipe in
                    RecipeCardView(recipe: recipe)
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 24)
```

**Comprendre `ForEach`** :
- C'est l'équivalent SwiftUI d'une boucle qui produit des vues.
- `MockData.sample` est un `[Recipe]`.
- Chaque `Recipe` est `Identifiable` (grâce au `id: UUID` dans `Recipe.swift`), donc `ForEach` sait l'identifier sans qu'on précise `id:`.

## Étape 3.5 — Ajouter un fond gris global

Pour faire ressortir les cartes blanches, ajoutez un fond grisé sur le `ScrollView` :

```swift
    ScrollView {
        VStack(alignment: .leading, spacing: 20) {
            // ... en-tête + galerie ...
        }
    }
    .background(Color(.systemGroupedBackground))   // ← ICI
}
```

Lancez la Preview : vous devriez voir l'en-tête et 5 cartes scrollables sur fond gris clair.

## Étape 3.6 — Tester sur plusieurs tailles d'écran

Dans le canevas de Preview, en haut, cliquez sur le nom du device (en général `iPhone 15`) et essayez :

- **iPhone SE (3rd generation)** : petit écran, voir si l'en-tête et la première carte tiennent bien.
- **iPhone 15 Pro Max** : grand écran, voir si les cartes ne paraissent pas perdues.

Si une carte rogne du contenu, augmentez `spacing` dans le `VStack` ou ajustez `lineLimit(2)` sur le résumé.

## Étape 3.7 — Lancer dans le simulateur

1. Vérifiez que `MyRecipesApp.swift` lance bien `ContentView()`.
2. Sélectionnez **iPhone 15** dans le sélecteur en haut de Xcode.
3. Appuyez sur `Cmd + R`.

L'application se lance dans le Simulator. Faites défiler la liste avec un drag de la souris (ou trackpad).

## Étape 3.8 — Code final attendu

```swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                // En-tête
                VStack(alignment: .leading, spacing: 4) {
                    Text("MyRecipes")
                        .font(.system(size: 36, weight: .bold, design: .rounded))

                    Text("\(MockData.sample.count) recettes à explorer")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal, 16)
                .padding(.top, 24)

                // Galerie
                VStack(spacing: 16) {
                    ForEach(MockData.sample) { recipe in
                        RecipeCardView(recipe: recipe)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 24)
            }
        }
        .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    ContentView()
}
```

## ✅ Critères de validation 2.3

- [ ] L'écran défile bien quand on scrolle (au moins 5 cartes affichées).
- [ ] L'en-tête « MyRecipes » est visible en haut.
- [ ] Les 5 recettes de `MockData.sample` apparaissent toutes.
- [ ] L'espacement entre les cartes est régulier (16 pt).
- [ ] Le fond est gris clair, les cartes ressortent en blanc.
- [ ] L'écran fonctionne sur iPhone SE et iPhone 15 Pro Max.

---

# Bonus — Pour les plus rapides

Si vous avez terminé les 3 exercices avant la fin de la séance, essayez :

## Bonus A — Image de fond personnalisée

Remplacez le dégradé du `RecipeCardView` par une vraie image. Pour cela :

1. Téléchargez une image libre de droits sur [Unsplash](https://unsplash.com).
2. Glissez l'image dans `Assets.xcassets` (panneau de gauche) → renommez l'asset, par exemple `applepie`.
3. Dans `MockData.swift`, mettez à jour `imageName: "applepie"` pour la première recette.
4. Dans `RecipeCardView.swift`, remplacez la `ZStack` actuelle par :

```swift
Image(recipe.imageName)
    .resizable()
    .aspectRatio(contentMode: .fill)
    .frame(height: 180)
    .clipped()
```

Pour les recettes sans image, gardez le dégradé en fallback (utilisez `if UIImage(named: recipe.imageName) != nil`).

## Bonus B — Badge de difficulté en haut à droite

Ajoutez un badge coloré dans le coin supérieur droit de la carte qui indique la difficulté :

```swift
.overlay(alignment: .topTrailing) {
    Text(recipe.difficulty.rawValue)
        .font(.caption2.bold())
        .foregroundStyle(.white)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(.orange, in: Capsule())
        .padding(8)
}
```

Bonus du bonus : changer la couleur du badge selon la difficulté.

## Bonus C — Animation au tap

Ajoutez à la carte :

```swift
.onTapGesture {
    print("Tap sur \(recipe.title)")
}
```

Plus avancé, ajouter un effet de scale au tap :

```swift
@State private var pressed = false

// dans le body :
.scaleEffect(pressed ? 0.95 : 1.0)
.animation(.spring, value: pressed)
.onTapGesture { pressed.toggle() }
```

## Bonus D — En-tête fixe (sticky header)

Faire en sorte que l'en-tête « MyRecipes » reste collé en haut quand on scrolle, plutôt que de défiler avec les cartes.

Indice : utiliser `.safeAreaInset(edge: .top)` au lieu d'inclure l'en-tête dans le `ScrollView`.

---

# FAQ — Problèmes courants

### « La Preview est gelée / ne se met plus à jour »

Appuyez sur `Cmd + Option + P` pour relancer la Preview. Si ça ne suffit pas, faites `Editor → Canvas → Rebuild Preview`.

### « Use of unresolved identifier 'MockData' »

Le fichier `MockData.swift` n'est pas dans la cible. Cliquez dessus dans le panneau de gauche, regardez le panneau de droite (« File Inspector ») et cochez la case `MyRecipes` sous **Target Membership**.

### « Use of unresolved identifier 'Recipe' »

Même cause que ci-dessus, mais sur `Recipe.swift`. Cochez la cible.

### « L'icône SF Symbol ne s'affiche pas »

Vérifiez l'orthographe du `systemName`. Vous pouvez parcourir tous les SF Symbols dans l'app **SF Symbols** (téléchargeable gratuitement chez Apple).

### « L'ombre n'apparaît pas »

Vérifiez l'ordre des modifiers : `.background()` AVANT `.clipShape()` AVANT `.shadow()`. Si l'ombre est trop discrète, augmentez l'opacité : `.shadow(color: .black.opacity(0.2), radius: 8, y: 4)`.

### « ForEach me dit qu'il a besoin d'un id »

Vérifiez que `Recipe` est bien conforme à `Identifiable` dans `Recipe.swift`. Sinon, écrivez explicitement : `ForEach(MockData.sample, id: \.id) { ... }`.

### « Build Failed » avec une erreur dans un fichier que je n'ai pas touché

Faites `Product → Clean Build Folder` (`Cmd + Shift + K`) puis recompilez (`Cmd + B`).

---

# Pour aller plus loin

À la fin de cette séance, vous savez :
- Créer une vue SwiftUI à partir de zéro.
- Composer un layout avec `VStack`, `HStack`, `ZStack` et `Spacer`.
- Utiliser `Image` (asset ou SF Symbol), `Text`, `Button`.
- Appliquer des modifiers et comprendre que **l'ordre compte**.
- Construire un composant réutilisable qui prend un paramètre.
- Boucler sur une collection avec `ForEach`.
- Utiliser `ScrollView` pour rendre du contenu scrollable.
- Tester en Preview avec plusieurs variantes (light/dark, devices).

**Préparation pour la séance 3** : pensez à ce qui manque encore à l'écran d'accueil. Comment afficher des données qui changent ? Comment réagir à un tap sur une carte ? Comment filtrer la liste ? Notez vos questions, on y répondra dès le début de la séance suivante.

Bon travail ! 🎉
