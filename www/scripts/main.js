function getIngredients(){
    return [
  { id:1, name:"Flour", defaultSupplier:"Lauke", category:"Ingredient", rating:9.2, rank:1},
  { id:2, name:"Eggs", defaultSupplier:"Chicken Co", category:"Ingredient", rating:9.2, rank:2},
  { id:3, name:"Water", defaultSupplier:"Tap", category:"Ingredient", rating:9.0, rank:3},
  { id:4, name:"Sugar", defaultSupplier:"Sweet Company", category:"Ingredient", rating:8.9, rank:4},
  { id:5, name:"Chocolate", defaultSupplier:"Sweet Company", category:"Ingredient", rating:8.9, rank:5},
  { id:6, name:"Coconut", defaultSupplier:"Rainforest Fruits Co", category:"Ingredient", rating:8.9, rank:6},
  { id:7, name:"Baker", defaultSupplier:"Internal", category:"Wage", rating:8.9, rank:6},
  { id:8, name:"Baking Assistant", defaultSupplier:"Internal", category:"Wage", rating:8.9, rank:6}
]
}

function doStuff(){
    grid_data[1].name = "Hello"
}


var grid_data = getIngredients();

var treeData = [
{name:"Coconut", qty:"10", unit:"kg", costPerUnit:10},
{name:"Packet", qty:"500", unit:"Packet", costPerUnit: 10},
{name:"Bakers Wage", qty:"3", unit:"Hour", costPerUnit: 10},
{name:"Choc Dip", qty:"10", unit:"L", costPerUnit: 10, data:[
    {name:"Cocoa", qty:"750", unit:"g", costPerUnit: 10},
    {name:"Water", qty:"10", unit:"L", costPerUnit: 10},
    {name:"Sugar", qty:"3", unit:"kg", costPerUnit: 10}
]},
{name:"Sponge", qty:"100", unit:"kg", costPerUnit: 10, data:[
    {name:"Flour", qty:"10", unit:"kg", costPerUnit: 10},
    {name:"Water", qty:"10", unit:"L", costPerUnit: 10},
    {name:"Egg", qty:"2", unit:"kg", costPerUnit: 10},
    {name:"Sugar", qty:"5", unit:"kg", costPerUnit: 10}
]}
]

grid = webix.ui({
  container: "box",
  view:"datatable",
  //autoConfig:true,
  columns:[
  {id:"name", header:["Name",{content:"textFilter"}], width: 200, editor:"text", sort:"string"},
  {id:"category", header:["Category",{content:"selectFilter"}], width: 150, editor:"combo", sort:"string", options:["Ingredient", "Wage", "Packaging"]},
  {id:"defaultSupplier", header:"Default Supplier", adjust:true, sort:"string"},
  {id:"purchaseQty", header:"Purch Qty", width: 100, sort:"int"},
  {id:"purchaseUnit", header:"Purch Unit", width: 100, sort:"int"},
  {id:"costPerUnit", header:"$/Default Unit", width: 100, sort:"int"},
  {id:"defaultUnit", header:"Default Unit", width: 150, sort:"string"},
  {id:"supplierList", header:"Suppliers", width: 300},
  {id:"bestPrice", header:"Cheapest Price", width: 150, sort:"int"}
],
  resizeColumn:true,
  editable: true,
  autowidth:true,
  data:grid_data,
  autoheight: true
});


tree = webix.ui({
    autoheight: true,
    drag: "order",
    autowidth:true,
    editable: true,
    container: "tree",
    autoheight: true,
    view:"treetable",

    columns:[
        { id:"name", header:"Component Name", editor: "combo", template:"{common.treetable()} #name#", width: 300 },
        { id:"qty", header:"Qty", width:100, editor:"text", template:"#qty# #unit#"},
        { id:"unit", header:"Unit", width:100 },
        { id:"costPerUnit", header:"$/Unit", minWidth: 100, adjust:true, template:"$#costPerUnit#/#unit#"},
        { id:"cost", header:"Cost", width: 100, math:"[$r,:1]*[$r,:3]", template:"$#cost#"}
    ],
    math:true,
    data: treeData //dataset, variable or path
})

tree.attachEvent("onBeforeDrag", function(context, ev){
    return this.getItem(context.start).$level == 1; // Only allow top level dragging
});

tree.attachEvent("onBeforeDrop", function(context, ev){
    return context.parent==0;
});
