-- Add Supplier
INSERT INTO Supplier(name)
VALUES("APD");
-- Add Supplier
INSERT INTO Supplier(name)
VALUES("Lauke");
-- Add Supplier
INSERT INTO Supplier(name)
VALUES("Foodland");
-- Add Supplier
INSERT INTO Supplier(name)
VALUES("Drakes");

-- Add Ingredient with Category Number
INSERT INTO Ingredient(name,defaultSupplier,categoryId)
VALUES("Flour",2,4);
-- Add Ingredient with Category Name
INSERT INTO Ingredient(name,defaultSupplier,categoryId)
VALUES("Water",4,(SELECT id FROM Category WHERE name = "Ingredient"));
-- Add Ingredient with Category Number
INSERT INTO Ingredient(name,defaultSupplier,categoryId)
VALUES("Box",1,6);
-- Add Ingredient with Category Number
INSERT INTO Ingredient(name,defaultSupplier,categoryId)
VALUES("Wrapping Film",4,6);


-- Add Ingredient Unit
INSERT INTO IngredientUnit(name, ingredientId, qtyPerPrimaryUnit)
VALUES("kg",1, 1);

-- Add Ingredient Unit
INSERT INTO IngredientUnit(name, ingredientId, qtyPerPrimaryUnit)
VALUES("g", 1, 1000);

-- Add Ingredient Unit without bothering to specify qty
INSERT INTO IngredientUnit(name, ingredientId)
VALUES("roll",4);

-- Add Ingredient Unit
INSERT INTO IngredientUnit(name, ingredientId, qtyPerPrimaryUnit)
VALUES("singlePacket",4, 12345);

-- Add Default Ingredient Unit
INSERT INTO DefaultIngredientUnit(ingredientId, unitId)
VALUES(1, 1);

-- Add Default Ingredient Unit
INSERT INTO DefaultIngredientUnit(ingredientId, unitId)
VALUES(4, 3);

--DONT FORGET PURCHSES LATER

-- Add Recipe
INSERT INTO Recipe(name, categoryId, qty)
VALUES("Lamington", 1, 10);

-- Add Recipe
INSERT INTO Recipe(name, categoryId, qty)
VALUES("Single Lamington", 3, 10);

-- Add Recipe
INSERT INTO Recipe(name, categoryId, qty)
VALUES("Lamington 6pk", 3, 10);

-- Add Recipe
INSERT INTO Recipe(name, categoryId, qty)
VALUES("Lamington Caterer", 3, 10);

-- Add Recipe
INSERT INTO Recipe(name, categoryId, qty)
VALUES("Lamington 12pk", 3, 10);

-- Add Recipe
INSERT INTO Recipe(name, categoryId, qty)
VALUES("Sponge", 2, 10);

-- Add Recipe
INSERT INTO Recipe(name, categoryId, qty)
VALUES("Choc Dip", 2, 10);

-- Add Component to Recipe
INSERT INTO RecipeIngredient(recipeId, ingredientId, qty, unitId)
VALUES(1, 1, 10, 1);

-- Add Component to Recipe From Text
INSERT INTO RecipeIngredient(recipeId, ingredientId, qty, unitId)
VALUES(
(SELECT id FROM Recipe WHERE name = "Lamington"),
(SELECT id FROM Ingredient WHERE name = "Wrapping Film"),
1,
(SELECT id FROM IngredientUnit WHERE name = "singlePacket")
);





-- Show All Data

-- List Suppliers
SELECT id, name FROM Supplier;

-- List Category
SELECT id, name FROM Category;

-- List Ingredients
SELECT id, name, categoryId, defaultSupplier
FROM Ingredient;

-- List Ingredients joined
SELECT Ingredient.id, Ingredient.name, Ingredient.categoryId, Category.name AS "categoryName", Ingredient.defaultSupplier, Supplier.name AS "defaultSupplierName"
FROM Ingredient
LEFT OUTER JOIN Supplier
ON Ingredient.defaultSupplier=Supplier.id
LEFT OUTER JOIN Category
ON Ingredient.categoryId=Category.id;

-- List Ingredient units Joined
SELECT IngredientUnit.id, IngredientUnit.name, IngredientUnit.ingredientId, Ingredient.name AS "ingredientName", IngredientUnit.qtyPerPrimaryUnit
FROM IngredientUnit LEFT OUTER JOIN Ingredient
ON IngredientUnit.ingredientId = Ingredient.id;

-- List Default Ingredient Units Joined
SELECT DefaultIngredientUnit.ingredientId, Ingredient.name, DefaultIngredientUnit.unitId, IngredientUnit.name
FROM DefaultIngredientUnit LEFT OUTER JOIN Ingredient
ON DefaultIngredientUnit.ingredientId = Ingredient.id
LEFT OUTER JOIN IngredientUnit
ON DefaultIngredientUnit.unitId = IngredientUnit.id;

-- List Purchase Informative
SELECT Purchase.id, Purchase.supplierId, Supplier.name AS "supplierName", Purchase.ingredientId, Ingredient.name AS "ingredientName", Purchase.costCents, CONCAT("$", format(Purchase.costCents/100, 2)) AS "cost", Purchase.purchaseQty, Purchase.purchaseUnitsId, IngredientUnit.name AS "uniName"
FROM Purchase LEFT OUTER JOIN Supplier
ON Purchase.supplierId = Supplier.id
LEFT OUTER JOIN Ingredient
ON Purchase.ingredientId = Ingredient.id
LEFT OUTER JOIN IngredientUnit
ON Purchase.purchaseUnitsId = IngredientUnit.id;

-- List Recipes Informative
SELECT Recipe.id, Recipe.name, Recipe.categoryId, Category.name as "categoryName", Recipe.qty
FROM Recipe LEFT OUTER JOIN Category
ON Recipe.categoryId = Category.id;

-- List Ingredient Components informative
SELECT RecipeIngredient.id, RecipeIngredient.recipeId, Recipe.name AS "recipeName", RecipeIngredient.ingredientId, Ingredient.name AS "ingredientName", RecipeIngredient.qty, RecipeIngredient.unitId, IngredientUnit.name AS "unitName"
FROM RecipeIngredient LEFT OUTER JOIN Recipe
ON RecipeIngredient.recipeId = Recipe.id
LEFT OUTER JOIN Ingredient
ON RecipeIngredient.ingredientId = Ingredient.id
LEFT OUTER JOIN IngredientUnit
ON RecipeIngredient.unitId = IngredientUnit.id;
