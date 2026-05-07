//
//  Recipe.swift
//  MyRecipes — Séance 1
//
//  Modèle de données : Recipe, Ingredient, Difficulty.
//  C'est la base sur laquelle on va construire toute l'application.
//

import Foundation

// MARK: - Difficulty

/// Difficulté d'une recette. Conforme à `Identifiable` et `CaseIterable`
/// pour pouvoir être utilisée dans un `Picker` SwiftUI.
enum Difficulty: String, CaseIterable, Identifiable, Codable {
    case easy   = "Facile"
    case medium = "Moyen"
    case hard   = "Difficile"

    var id: String { rawValue }

    /// Icône SF Symbol associée. À utiliser dans `Image(systemName:)`.
    var iconName: String {
        switch self {
        case .easy:   return "leaf"
        case .medium: return "flame"
        case .hard:   return "bolt"
        }
    }

    /// Couleur conseillée pour mettre en valeur la difficulté.
    var tintHex: String {
        switch self {
        case .easy:   return "30D158"
        case .medium: return "FF9500"
        case .hard:   return "FF3B30"
        }
    }
}

// MARK: - Ingredient

/// Un ingrédient d'une recette. `Identifiable` pour `ForEach`.
struct Ingredient: Identifiable, Hashable, Codable {
    var id: UUID = UUID()
    var name: String
    var quantity: Double
    var unit: String

    /// Représentation lisible : "200 g de farine".
    var displayText: String {
        let formattedQty = quantity.truncatingRemainder(dividingBy: 1) == 0
            ? String(Int(quantity))
            : String(format: "%.1f", quantity)
        return "\(formattedQty) \(unit) de \(name)"
    }
}

// MARK: - Recipe

/// Une recette de cuisine.
///
/// `struct` (value type) : adaptée à SwiftUI car les copies sont indépendantes
/// et la diffusion des changements est explicite via `@State` / `@Bindable`.
struct Recipe: Identifiable, Hashable, Codable {
    var id: UUID = UUID()
    var title: String
    var summary: String
    var durationMinutes: Int
    var servings: Int
    var imageName: String          // nom dans l'Asset Catalog (ou systemName en fallback)
    var difficulty: Difficulty
    var ingredients: [Ingredient]
    var steps: [String]
    var isFavorite: Bool = false

    /// Construit une chaîne courte "30 min · 4 pers" pour l'affichage.
    var quickInfo: String {
        "\(durationMinutes) min · \(servings) pers."
    }

    /// Vérifie si la recette est valide (utile pour la validation de formulaire).
    var isValid: Bool {
        let trimmed = title.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.count >= 3
            && servings > 0
            && durationMinutes > 0
            && !ingredients.isEmpty
    }
}
