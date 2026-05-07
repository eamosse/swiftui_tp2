//
//  MockData.swift
//  MyRecipes — Séance 1
//
//  Jeu de 5 recettes statiques utilisé pour les Previews et les tests
//  pendant les premières séances. Sera remplacé par SwiftData en séance 6.
//

import Foundation

enum MockData {

    static let sample: [Recipe] = [
        Recipe(
            title: "Tarte aux pommes",
            summary: "Le classique inratable du dimanche, avec une compote maison.",
            durationMinutes: 60,
            servings: 6,
            imageName: "applepie",
            difficulty: .easy,
            ingredients: [
                Ingredient(name: "pommes",       quantity: 6,   unit: ""),
                Ingredient(name: "pâte brisée",  quantity: 1,   unit: "rouleau"),
                Ingredient(name: "sucre",        quantity: 80,  unit: "g"),
                Ingredient(name: "cannelle",     quantity: 1,   unit: "c. à c."),
                Ingredient(name: "beurre",       quantity: 30,  unit: "g")
            ],
            steps: [
                "Préchauffer le four à 180°C.",
                "Éplucher et couper les pommes en lamelles.",
                "Étaler la pâte dans le moule.",
                "Disposer les pommes en rosace, saupoudrer de sucre et de cannelle.",
                "Parsemer de noisettes de beurre.",
                "Enfourner 35 minutes, jusqu'à ce que la tarte soit dorée."
            ]
        ),

        Recipe(
            title: "Soupe de potiron au gingembre",
            summary: "Une soupe veloutée et réconfortante, parfaite en automne.",
            durationMinutes: 40,
            servings: 4,
            imageName: "pumpkinsoup",
            difficulty: .easy,
            ingredients: [
                Ingredient(name: "potiron",      quantity: 800, unit: "g"),
                Ingredient(name: "oignon",       quantity: 1,   unit: ""),
                Ingredient(name: "gingembre",    quantity: 20,  unit: "g"),
                Ingredient(name: "bouillon",     quantity: 1,   unit: "L"),
                Ingredient(name: "crème fraîche", quantity: 10, unit: "cl")
            ],
            steps: [
                "Faire revenir l'oignon émincé dans une grande casserole.",
                "Ajouter le gingembre râpé et les morceaux de potiron.",
                "Couvrir de bouillon et porter à ébullition.",
                "Laisser cuire 25 minutes à feu moyen.",
                "Mixer finement, ajouter la crème fraîche.",
                "Servir bien chaud avec quelques graines de courge."
            ]
        ),

        Recipe(
            title: "Risotto aux champignons",
            summary: "Un risotto crémeux relevé d'un trait de truffe pour les soirs un peu spéciaux.",
            durationMinutes: 45,
            servings: 4,
            imageName: "risotto",
            difficulty: .medium,
            ingredients: [
                Ingredient(name: "riz arborio",  quantity: 320, unit: "g"),
                Ingredient(name: "champignons de Paris", quantity: 300, unit: "g"),
                Ingredient(name: "échalote",     quantity: 2,   unit: ""),
                Ingredient(name: "vin blanc",    quantity: 10,  unit: "cl"),
                Ingredient(name: "bouillon",     quantity: 1,   unit: "L"),
                Ingredient(name: "parmesan",     quantity: 80,  unit: "g")
            ],
            steps: [
                "Émincer finement les échalotes et les champignons.",
                "Faire revenir les échalotes, puis les champignons.",
                "Ajouter le riz, le faire nacrer 1 minute.",
                "Déglacer au vin blanc, attendre l'évaporation.",
                "Ajouter le bouillon louche par louche, en remuant constamment.",
                "Quand le riz est al dente, incorporer le parmesan râpé hors du feu."
            ]
        ),

        Recipe(
            title: "Salade César revisitée",
            summary: "Une salade César avec poulet croustillant et croûtons maison.",
            durationMinutes: 25,
            servings: 2,
            imageName: "caesar",
            difficulty: .easy,
            ingredients: [
                Ingredient(name: "blanc de poulet", quantity: 2, unit: ""),
                Ingredient(name: "romaine",      quantity: 1,   unit: ""),
                Ingredient(name: "parmesan",     quantity: 40,  unit: "g"),
                Ingredient(name: "pain rassis",  quantity: 4,   unit: "tranches"),
                Ingredient(name: "anchois",      quantity: 2,   unit: ""),
                Ingredient(name: "ail",          quantity: 1,   unit: "gousse")
            ],
            steps: [
                "Tailler le pain en cubes et le faire dorer à la poêle avec l'ail.",
                "Cuire les blancs de poulet à la poêle, les laisser reposer.",
                "Mixer anchois, parmesan, mayonnaise et jus de citron pour la sauce.",
                "Couper la romaine, ajouter le poulet en lamelles.",
                "Ajouter croûtons, copeaux de parmesan et sauce."
            ]
        ),

        Recipe(
            title: "Mille-feuille aux fraises",
            summary: "Pâte feuilletée, crème pâtissière et fraises gariguette.",
            durationMinutes: 90,
            servings: 6,
            imageName: "millefeuille",
            difficulty: .hard,
            ingredients: [
                Ingredient(name: "pâte feuilletée", quantity: 2, unit: "rouleaux"),
                Ingredient(name: "lait",          quantity: 50,  unit: "cl"),
                Ingredient(name: "jaunes d'œufs", quantity: 4,   unit: ""),
                Ingredient(name: "sucre",         quantity: 100, unit: "g"),
                Ingredient(name: "maïzena",       quantity: 40,  unit: "g"),
                Ingredient(name: "fraises",       quantity: 500, unit: "g")
            ],
            steps: [
                "Préparer une crème pâtissière classique. Réserver au frais.",
                "Étaler la pâte feuilletée et la cuire entre deux plaques.",
                "Découper trois rectangles identiques par mille-feuille.",
                "Monter en alternant pâte, crème, pâte, fraises, pâte.",
                "Saupoudrer de sucre glace au moment du service."
            ]
        )
    ]
}
