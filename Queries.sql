
-- Add Category
INSERT INTO Category(name)
VALUES("CATEGORY NAME");

-- List Category
SELECT id, name FROM Category;

-- Add Supplier
INSERT INTO Supplier(name)
VALUES("<SUPPLIER NAME>");

-- List Suppliers
SELECT id, name FROM Supplier;

-- Add Ingredient with Category Number
INSERT INTO Ingredient(name,defaultSupplier,categoryId)
VALUES("<INGREDIENT NAME>",<SUPPLIER NUMBER>,CATEGORY NUMBER");

-- Add Ingredient with Category Name
INSERT INTO Ingredient(name,defaultSupplier,categoryId)
VALUES("<INGREDIENT NAME>",<SUPPLIER NUMBER>,(SELECT id FROM Category WHERE name = "<CATEGORY NAME>"));

-- List Ingredients
SELECT id, name
FROM Ingredient;

-- List Ingredients & Default Supplier
SELECT Ingredient.id, Ingredient.name, Ingredient.category, Ingredient.defaultSupplier, Supplier.name
FROM Ingredient LEFT OUTER JOIN Supplier
ON Ingredient.defaultSupplier=Supplier.id;

-- List Ingredients with Default Supplier (By id)
SELECT id, name, category
FROM Ingredient
WHERE defaultSupplier = <SUPPLIER ID>;

-- List Ingredients with Default Supplier (By name)
SELECT id, name, category
FROM Ingredient
WHERE defaultSupplier in (
    SELECT id
    FROM Supplier
    WHERE name = "<SUPPLIER NAME>");

-- Add Ingredient Unit
INSERT INTO IngredientUnit(name, ingredientId, qtyPerPrimaryUnit)
VALUES("<NAME>",<INGREDIENT ID>, <QTY>);
-- Add Ingredient Unit without bothering to specify qty
INSERT INTO IngredientUnit(name, ingredientId)
VALUES("<NAME>",<INGREDIENT ID>);

-- List Ingredient units
SELECT id, name, ingredientId, qtyPerPrimaryUnit
FROM IngredientUnit;

-- List Ingredient units Joined
SELECT IngredientUnit.id, IngredientUnit.name, IngredientUnit.ingredientId, Ingredient.name, IngredientUnit.qtyPerPrimaryUnit
FROM IngredientUnit LEFT OUTER JOIN Ingredient
ON IngredientUnit.ingredientId = Ingredient.id;

-- Add Default Ingredient Unit
INSERT INTO DefaultIngredientUnit(ingredientId, unitId)
VALUES(<INGREDIENT ID>, <INGREDIENT UNIT ID>);

-- List Default Ingredient Units
SELECT ingredientId, unitId
FROM DefaultIngredientUnit;

-- List Default Ingredient Units Joined
SELECT DefaultIngredientUnit.ingredientId, Ingredient.name, DefaultIngredientUnit.unitId, IngredientUnit.name
FROM DefaultIngredientUnit LEFT OUTER JOIN Ingredient
ON DefaultIngredientUnit.ingredientId = Ingredient.id
LEFT OUTER JOIN IngredientUnit
ON DefaultIngredientUnit.unitId = IngredientUnit.id;

-- Create Purchase
INSERT INTO Purchase(supplierId, ingredientId, costCents, purchaseQty, purchaseUnitsId)
VALUES(<SUPPLIER ID>, <INGREDIENT ID>, <COST>, <QTY>, <UNIT ID>);


-- Create Purchase Text
INSERT INTO Purchase(supplierId, ingredientId, costCents, purchaseQty, purchaseUnitsId)
VALUES(
(SELECT id FROM Supplier WHERE name = "<SUPPLIER NAME>"),
(SELECT id FROM Ingredient WHERE name = "<INGREDIENT NAME>"),
<COST>, <QTY>,
(SELECT id FROM IngredientUnit WHERE name = "<UNIT NAME>" AND ingredientId = (SELECT id FROM Ingredient WHERE name = "<INGREDIENT NAME>"))
);


-- List Purchase
SELECT id, supplierId, ingredientId, costCents, purchaseQty, purchaseUnitsId
FROM Purchase;

-- List Purchase Informative
SELECT Purchase.id, Purchase.supplierId, Supplier.name AS "supplierName", Purchase.ingredientId, Ingredient.name AS "ingredientName", Purchase.costCents, CONCAT("$", format(Purchase.costCents/100, 2)) AS "cost", Purchase.purchaseQty, Purchase.purchaseUnitsId, IngredientUnit.name AS "uniName"
FROM Purchase LEFT OUTER JOIN Supplier
ON Purchase.supplierId = Supplier.id
LEFT OUTER JOIN Ingredient
ON Purchase.ingredientId = Ingredient.id
LEFT OUTER JOIN IngredientUnit
ON Purchase.purchaseUnitsId = IngredientUnit.id;

-- Add Recipe
INSERT INTO Recipe(name, categoryId, qty)
VALUES("<RECIPE NAME>", <CATEGORY ID>, <QTY>);


-- List Recipes
SELECT id, name, categoryId, qty
FROM Recipe;

-- List Recipes Informative
SELECT Recipe.id, Recipe.name, Recipe.categoryId, Category.name as "categoryName", Recipe.qty
FROM Recipe LEFT OUTER JOIN Category
ON Recipe.categoryId = Category.id;

-- Add Component to Recipe
INSERT INTO RecipeIngredient(recipeId, ingredientId, qty, unitId)
VALUES(<RECIPE ID>, <INGREDIENT ID>, <QTY>, <UNIT ID>);

-- Add Component to Recipe From Text
INSERT INTO RecipeIngredient(recipeId, ingredientId, qty, unitId)
VALUES(
(SELECT id FROM Recipe WHERE name = "<RECIPE NAME>"),
(SELECT id FROM Ingredient WHERE name = "<INGREDIENT NAME>"),
<QTY>,
(SELECT id FROM IngredientUnit WHERE name = "<UNIT NAME>")
);

-- List Ingredient Components
SELECT id, recipeId, ingredientId, qty, unitId
FROM RecipeIngredient;

-- List Ingredient Components informative
SELECT RecipeIngredient.id, RecipeIngredient.recipeId, Recipe.name AS "recipeName", RecipeIngredient.ingredientId, Ingredient.name AS "ingredientName", RecipeIngredient.qty, RecipeIngredient.unitId, IngredientUnit.name AS "unitName"
FROM RecipeIngredient LEFT OUTER JOIN Recipe
ON RecipeIngredient.recipeId = Recipe.id
LEFT OUTER JOIN Ingredient
ON RecipeIngredient.ingredientId = Ingredient.id
LEFT OUTER JOIN IngredientUnit
ON RecipeIngredient.unitId = IngredientUnit.id;

-- Add Recipe Component to Recipe
INSERT INTO RecipeIngredient(recipeId, ingredientId, qty, unitId)
VALUES(<RECIPE ID>, <INGREDIENT ID>, <QTY>, <UNIT ID>);

-- Add Recipe Component to Recipe From Text
INSERT INTO RecipeIngredient(recipeId, ingredientId, qty, unitId)
VALUES(
(SELECT id FROM Recipe WHERE name = "<RECIPE NAME>"),
(SELECT id FROM Ingredient WHERE name = "<INGREDIENT NAME>"),
<QTY>,
(SELECT id FROM IngredientUnit WHERE name = "<UNIT NAME>")
);

-- List Recipe Components
SELECT id, recipeId, ingredientId, qty, unitId
FROM RecipeIngredient;

-- List Recipe Components informative
SELECT RecipeIngredient.id, RecipeIngredient.recipeId, Recipe.name AS "recipeName", RecipeIngredient.ingredientId, Ingredient.name AS "ingredientName", RecipeIngredient.qty, RecipeIngredient.unitId, IngredientUnit.name AS "unitName"
FROM RecipeIngredient LEFT OUTER JOIN Recipe
ON RecipeIngredient.recipeId = Recipe.id
LEFT OUTER JOIN Ingredient
ON RecipeIngredient.ingredientId = Ingredient.id
LEFT OUTER JOIN IngredientUnit
ON RecipeIngredient.unitId = IngredientUnit.id;
